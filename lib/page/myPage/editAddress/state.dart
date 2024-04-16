import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 编辑地址的数据层
class EditAddressState {

  /// 名字输入框控制器
  late TextEditingController nController;

  /// 手机号码输入框控制器
  late TextEditingController pController;

  /// 详细地址输入框控制器
  late TextEditingController aController;

  /// 名字输入框的文本内容
  late String contact;

  /// 手机号码输入框的文本内容
  late String phone;

  /// 地区
  late String areaAddress;

  /// 详细地址 输入框的文本内容
  late String address;

  /// switch开关的值
  late bool isChecked;

  /// 地区码
  late String adCode;

  /// 地址id
  late int id;

  /// 初始化 构造函数
  EditAddressState() {
    id = 0;
    adCode = "";
    isChecked = false;
    contact = "";
    phone = "";
    areaAddress = "请选择地区";
    address = "";
    nController = TextEditingController();
    pController = TextEditingController();
    aController = TextEditingController();
  }
}

