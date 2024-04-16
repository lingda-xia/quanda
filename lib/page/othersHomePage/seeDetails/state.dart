import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:quanda/model/publish/DetailsEntity.dart';
import 'package:quanda/model/user/InfoEntity.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:video_player/video_player.dart';

/// 查看信息 的数据层
class SeeDetailsState {
  /// 输入框的文本内容
  late String textContent;

  /// 详情内容
  late DetailsEntity details;

  /// 提货方式
  late List<String> extract;

  /// 任务类型
  late List<String> taskType;

  /// 性别要求
  late List<String> sexType;

  /// 视频还是图片状态 true 图片  false 视频
  late bool notVideo;

  /// GlobalKey
  late GlobalKey globalKey;

  /// 轮播图控制器
  late SwiperController controller;

  /// 是否展开全部
  late bool develop;

  /// 自身用户信息
  late UserInfo userInfo;

  /// 发布id
  late String id;

  /// 前往主页时是返回页面还是跳转
  late bool close;

  /// 初始化 构造函数
  SeeDetailsState() {
    close = false;

    id = "";

    userInfo = UserInfo(0, "", 0, 0, "", 0, 1, "", "", "", 0);

    develop = false;

    textContent = "";

    notVideo = true;

    controller = SwiperController();

    globalKey = GlobalKey();

    details = DetailsEntity(0, 0, 1, "", "", "", "", "", "", 0, 0, 1, 0, 0, 0,
        0, 1, 0, 0, 0, "", 0, 0, 0, 0, 1, "", [], InfoEntity("", "", "", ""), false, 0, 0, 0);

    extract = ["", "上门自提", "包邮到家", "自费邮费"];

    taskType = ["一起玩耍", "到店奖励", "一起玩耍"];

    sexType = ["男女不限", "男性参加", "女性参加"];
  }
}
