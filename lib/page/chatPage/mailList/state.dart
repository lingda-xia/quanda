import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 通讯录的状态
class MailListState {
  /// 功能区域列表
  late List<FunctionalInfo> functionalList;

  /// 好友item的高度
  final double cellHeight = 140.dp;

  /// 组头的高度
  final double groupHeight = 50.dp;

  /// 每一个组头距离顶部的距离
  late Map groupOffsetMap;

  /// 好友列表
  late List<FriendList> friendList;

  MailListState() {
    friendList = [];
    groupOffsetMap = {};
    functionalList = [
      FunctionalInfo(
        imgUrl: "${RequestApi.imgBaseUrl}friends.png",
        textInfo: "新的朋友",
        /// 新的朋友页面
        goToPage: RouteConfig.newFriends,
      ),
      // FunctionalInfo(
      //   imgUrl: "${RequestApi.imgBaseUrl}business.png",
      //   textInfo: "企业商家",
      //   goToPage: "企业商家",
      // ),
      FunctionalInfo(
        imgUrl: "${RequestApi.imgBaseUrl}label.png",
        textInfo: "标签",
        goToPage: RouteConfig.labelManage,
      ),
      // FunctionalInfo(
      //   imgUrl: "${RequestApi.imgBaseUrl}linshihuihua.png",
      //   textInfo: "临时会话",
      //   /// 临时会话页面
      //   goToPage: RouteConfig.temporarySession,
      // ),
    ];
  }
}

/// 功能区域信息
class FunctionalInfo {
  /// 图片信息
  late String imgUrl;

  /// 内容信息
  late String textInfo;

  /// 需要前往的页面
  late String goToPage;

  FunctionalInfo({required this.imgUrl, required this.textInfo, required this.goToPage});
}

