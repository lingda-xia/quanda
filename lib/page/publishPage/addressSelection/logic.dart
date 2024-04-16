import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quanda/model/location/SearchResult.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'state.dart';
import 'package:city_pickers/city_pickers.dart';

/// 地址选择 的逻辑层
class AddressSelectLogic extends GetxController {
  AddressSelectState state = AddressSelectState();

  @override
  void onInit() {
    obtainAddress();
    super.onInit();
  }

  /// 获取地址
  obtainAddress() async {
    var value = await SpUtil.getAddress();
    if (value != null) {
      print("获取到的地址信息${value.city}");
      print("获取到的地址信息${value.latitude}");
      print("获取到的地址信息${value.longitude}");
      print("获取到的地址信息${value.address}");
      print("获取到的地址信息${value.street}");
      print("获取到的地址信息${value.district}");
      state.address = value;
      state.selectCity = value.city;
      state.selectLocation =
          "${value.latitude},${value.longitude}";
    }

    update();
  }

  /// 周边搜索请求
  searchRequest(String value) async {
    try {
      Response response;
      var dio = Dio();
      response = await dio
          .get('https://restapi.amap.com/v3/place/around', queryParameters: {
        'key': "1ca4ca8344fb07d5795a0772716ba2bc",
        'keywords': value,
        'city': state.selectCity,
        'location': state.selectLocation,
        "page": 1,

        /// 查询半径 m
        "radius": 50000,

        /// 排序规则  weight 综合排序
        "sortrule": "weight",
      });

      /// 成功
      if (response.data["infocode"] == "10000") {
        /// 得到的搜索列表
        List list = response.data["pois"];
        List<SearchResult> searchResult = [];
        // print("这是请求回来的东西${list}");

        for (int i = 0; i < list.length; i++) {
          var _address = list[i]["address"];

          if (_address is List) {
            _address = _address.toString();
          }
          searchResult.add(SearchResult(
            name: list[i]["name"],
            address: _address,
            distance: list[i]["distance"],
            city: list[i]["cityname"],
            district: list[i]["adname"],
            location: list[i]["location"],
          ));
        }
        state.searchList = searchResult;
        print("这是请求回来的东西${state.searchList}");
      } else {
        /// 显示提示框 自定义
        CustomToast.showToast("搜索出错${response.data["infocode"]}",
            const Color.fromRGBO(255, 77, 96, 1));
      }
    } on DioError catch (e) {
      /// 显示提示框 自定义
      CustomToast.showToast("搜索出错",
          const Color.fromRGBO(255, 77, 96, 1));
      print("周边搜索请求出错$e");
    }
    update();
  }

  /// 选择城市
  void selectCity(BuildContext context) async {
    /// 打开城市选择器
    Result? result = await CityPickers.showFullPageCityPicker(
      context: context,

      /// 主题颜色配置
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromRGBO(7, 17, 20, 1),

            /// AppBar 标题样式
            titleTextStyle: TextStyle(
              color: const Color.fromRGBO(223, 226, 235, 1),
              fontFamily: "PingFang SC",
              fontSize: 36.dp,
            ),
          ),

          /// 主体背景颜色
          backgroundColor: const Color.fromRGBO(7, 17, 20, 1),

          /// 下划线颜色
          dividerColor: const Color.fromRGBO(17, 22, 24, 1),

          /// 列表文本颜色和选择颜色
          listTileTheme: const ListTileThemeData(
            selectedColor: Colors.white,
            textColor: Color.fromRGBO(115, 117, 124, 1),
          ),

          /// 墨水颜色
          splashColor: Colors.transparent,

          /// ✔的颜色
          primaryColor: Colors.white),

      /// 地区码
      locationCode: state.address.adCode,
    );
    print("这是选择返回的地址${result}");

    if(result == null) return;
    /// 将选择的城市赋值
    state.selectCity = result.cityName!;

    /// 地理编码 获得选择地区的经纬度
    List<Location> locations = await locationFromAddress(
        result.provinceName! + result.cityName! + result.areaName!);

    print("获得选择地区的经纬度$locations");

    /// 将经纬度赋值
    state.selectLocation = "${locations[0].latitude},${locations[0].longitude}";

    /// 执行一遍周边搜索
    await searchRequest("");
    update();
  }

  /// 输入监听
  void inputChange(String value) {
    /// 周边搜索请求
    searchRequest(value);
    update();
  }

  /// 选择的列表item
  void selectItem(SearchResult item) {
    /// 转为json字符串
    String value = jsonEncode(item.toJson());

    /// 将选择的地址传回上一个页面
    Get.back(result: value);
  }
}
