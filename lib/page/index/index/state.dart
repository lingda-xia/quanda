import 'package:flutter/material.dart';
import 'package:quanda/model/index/Recommend.dart';
import 'package:quanda/model/location/Address.dart';

/// 首页 数据层
class IndexState {
  /// 市
  late String city;

  /// 区
  late String district;

  /// 地址信息
  late Address address;

  /// tab列表
  late List<String> tabList;

  /// 列表Map
  late Map<int, List<Recommend>?> listMap;

  /// 列表是否需要重新加载
  late Map<int, bool> reload;

  /// tab选择的下标
  late int index;

  /// 地区列表
  late List<Area> areaList;

  /// 坐标列表
  late List<Coordinate> list;

  /// 初始化 构造函数
  IndexState() {
    listMap = {
      0: [],
      1: [],
      2: [],
      3: [],
      4: [],
    };
    reload = {
      0: false,
      1: false,
      2: false,
      3: false,
      4: false,
    };
    city = "深圳市";
    district = "龙华区";
    tabList = [
      "全部",
      "瞬间",
      "广播",
      "任务",
      "闲置",
    ];
    index = 0;
    list = [];
    address = Address("", "", "", "", "", "", 0, 0, "");
    areaList = [
      Area(
        name: "龙岗区",
      ),
      Area(
        name: "盐田区",
      ),
      Area(
        name: "坪山区"
      ),
      Area(
        name: "罗湖区"
      ),
      Area(
        name: "福田区"
      ),
      Area(
        name: "宝安区"
      ),
      Area(
        name: "光明区"
      ),
      Area(
        name: "南山区"
      ),
      Area(
        name: "龙华区", stress: true,
      ),
    ];
  }
}

class Area {

  /// 区名
  late String name;

  /// 是否是主区
  late bool stress;


  Area({required this.name, this.stress = false});
}

class Coordinate {

  /// x轴上的距离
  late int dx;

  /// y轴上的距离
  late int dy;


  Coordinate({required this.dx, required this.dy});
}