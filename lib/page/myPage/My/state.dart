import 'package:flutter/material.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/model/user/PersonalInfo.dart';
import 'package:quanda/model/user/UserInfo.dart';

/// 我的的数据层
class MyState {
  /// 用户信息
  late PersonalInfo userInfo;

  /// 地址信息
  late Address address;

  /// 发布列表
  late List<ReleaseList> list;

  /// 发布类别
  late List<String> type;

  /// 列表是否需要重新加载
  late bool reload;

  /// 初始化 构造函数
  MyState() {
    userInfo = PersonalInfo(0, "", "", 1, 0, "", 0, "", 0, 0, 0, 1, 0);
    address = Address(
        "address", "street", "country", "province", "city", "district", 0, 0, "");

    list = [];

    type = [
      "全部",
      "瞬间",
      "广播",
      "任务",
      "闲置",
    ];

    reload = false;
  }
}
