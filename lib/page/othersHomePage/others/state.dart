import 'package:flutter/material.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/model/user/PersonalInfo.dart';
import 'package:quanda/model/user/UserInfo.dart';

/// 他人主页 的数据层
class OthersState {
  /// 用户信息
  late PersonalInfo userInfo;

  /// 自身用户信息
  late UserInfo info;

  /// 地址信息
  late Address address;

  /// tab列表
  late List<String> tabs;

  /// 列表Map
  late Map<int, List<ReleaseList>?> listMap;

  /// 列表是否需要重新加载
  late Map<int, bool> reload;

  /// 用户id
  late int id;

  /// 初始化 构造函数
  OthersState() {
    id = -1;

    userInfo = PersonalInfo(-1, "", "", 1, 0, "", 0, "", 0, 0, 1, 2, 0);

    info = UserInfo(0, "", 0, 0, "", 0, 0, "", "", "", 0);

    address = Address(
        "address", "street", "country", "province", "city", "district", 0, 0, "");

    tabs = [
      "全部",
      "瞬间",
      "广播",
      "任务",
      "闲置",
    ];

    reload = {
      0: false,
      1: false,
      2: false,
      3: false,
      4: false,
    };

    listMap = {
      0: [],
      1: [],
      2: [],
      3: [],
      4: [],
    };
  }
}
