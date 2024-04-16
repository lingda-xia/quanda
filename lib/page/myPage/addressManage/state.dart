import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/ReceivingEntity.dart';

/// 地址管理的数据层
class AddressManageState {

  /// 收货地址列表
  late List<ReceivingEntity> list;

  /// 选择的地址id
  late int selectId;

  /// 初始化 构造函数
  AddressManageState() {

    list = [];

    selectId = 0;
  }
}

