import 'package:flutter/material.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/model/location/SearchResult.dart';

/// 地址选择 的数据层
class AddressSelectState {
  /// 地址信息
  /// [name] 详细信息
  /// [street]大街
  /// [country] 国家
  /// [province] 省份
  /// [city] 城市
  /// [district] 区县
  /// [latitude] 经度
  /// [longitude] 纬度
  late Address address;

  /// 选择的城市
  late String selectCity;

  /// 搜索列表
  /// [address] 地址
  /// [distance] 距离 m
  /// [city] 城市名字
  /// [district] 区
  /// [name] 店名
  /// [location] 经纬度
  late List<SearchResult> searchList;

  /// 选择地区的经纬度
  late String selectLocation;

  /// 初始化 构造函数
  AddressSelectState() {
    address = Address(
      "",
      "",
      "",
      "",
      "",
      "",
      0,
      0,
      ""
    );
    selectCity = "北京市";
    searchList = [];
    selectLocation = "";
  }
}

