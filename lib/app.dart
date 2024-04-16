import 'dart:convert';

import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quanda/page/home/view.dart';
import 'package:quanda/page/login/chooseGender/view.dart';
import 'package:quanda/page/login/verifyLogin/view.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:amap_flutter_location/amap_flutter_location.dart';

import 'model/location/Address.dart';

/// 启动配置页
class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  /// 获取定位实例
  final AMapFlutterLocation locationPlugin = AMapFlutterLocation();

  /// 定位监听器
  late StreamSubscription<Map<String, Object>>? locationListener;

  ///用来控制动画的状态
  double opacityLevel = 0.0;

  /// 设置动画的透明度
  lazyInitAnim() {
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

  /// 初始化
  init() {
    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// [hasContains] 隐私声明中是否包含高德隐私政策说明
    ///
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);
  }

  /// 获取定位信息
  Future<String> getLocation() async {
    Completer<String> completer = Completer();

    getJurisdiction().then((value) async {
      /// 权限通过
      if (value) {
        /// 设置key
        AMapFlutterLocation.setApiKey("ccb49d1137c0f7a097bd9e40603e1ba8", "");

        /// 定位监听器
        locationListener = locationPlugin
            .onLocationChanged()
            .listen((Map<String, Object> result) async {
          print("获取到的定位信息${result}");

          if(result["errorCode"] == null) {
            var _str = Address.fromJson(result);
            /// jsonEncode 转换object为 JSON 字符串。
            var str = jsonEncode(_str);

            /// 保存地址信息
            await SpUtil.saveAddress(str);
          }

          completer.complete("true");
        });

        /// 设置定位参数
        locationPlugin.setLocationOption(
          AMapLocationOption(
            /// 是否单次定位
            onceLocation: true,
          ),
        );

        /// 开始定位
        locationPlugin.startLocation();

      }
    }).catchError((e) {
      print("获取定位出错$e");
      completer.complete("false");
    });
    return completer.future;
  }

  /// 获取定位权限
  getJurisdiction() async {
    /// 获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      /// 已经授权
      return true;
    } else {
      /// 未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // SpUtil.deleteUserInfo();

    /// 18770455793

    /// 初始化
    init();
  }

  @override
  void dispose() {
    super.dispose();

    if (locationListener != null) {
      /// 销毁监听器
      locationListener!.cancel();
    }

    /// 销毁定位
    locationPlugin.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future:
          Future<String>.delayed(const Duration(milliseconds: 1000), () async {
        /// 获取定位信息
        await getLocation();
        return "value";
      }),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
            // /// 根据是否存储有用户的信息进入登录页面
            // if (SpUtil.getUserInfo() == null) {
            //   return VerifyLogin();
            // } else if (SpUtil.getUserInfo()?.nickname == "") {
            //   /// 如果用户还未填写名称则跳转到信息填写页面
            //   return ChooseGender();
            // } else {
              return const HomePage();
            // }
        } else {
          return Container();
        }
      },
    );
  }
}
