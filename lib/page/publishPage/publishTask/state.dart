import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';

/// 发布页面的数据层
class PublishTaskState {

  /// 人数焦点
  late FocusNode rFocusNode;

  /// 奖励焦点
  late FocusNode mFocusNode;

  /// 时间焦点
  late FocusNode tFocusNode;

  /// 所需人数 输入框控制器
  late TextEditingController numController;

  /// 完成奖励 输入框控制器
  late TextEditingController moneyController;

  /// 停留时间 输入框控制器
  late TextEditingController timeController;

  /// 图片列表
  late List<String> media;

  /// 公里数
  late double kilometers;

  /// 时长数
  late double times;

  /// 选择的任务类型
  late int selectType;

  /// 选择的性别要求
  late int selectGender;

  /// 所需人数
  late String personNumber;

  /// 完成奖励
  late String finishMoney;

  /// 停留时间
  late String taskTime;

  /// 所需支付的总金额
  late double payMoney;

  /// 金币奖励类型:任务  用于完成发布任务需要
  late String goldType;

  /// 任务类型的列表
  late List<String> taskTypeList;

  /// 性别要求的列表
  late List<String> genderList;

  /// 初始化 构造函数
  PublishTaskState() {
    numController = TextEditingController();
    moneyController = TextEditingController();
    timeController = TextEditingController();

    tFocusNode = FocusNode();
    mFocusNode = FocusNode();
    rFocusNode = FocusNode();

    media = [];

    kilometers = 1;

    times = 24;

    selectType = 0;

    selectGender = 0;

    personNumber = "0";

    finishMoney = "0";

    taskTime = "0";

    payMoney = 0;

    goldType = "";

    taskTypeList = [
      "到店奖励",
      "一起玩耍"
    ];

    genderList = [
      "不限",
      "男生",
      "女生",
    ];
  }
}
