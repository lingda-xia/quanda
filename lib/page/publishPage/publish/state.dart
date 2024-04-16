import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/router/router.dart';

/// 发布页面的数据层
class PublishState {

  /// 发布列表
  late List<Release> releaseList;

  /// 初始化 构造函数
  PublishState() {
    releaseList = [
      Release(
        img: "${RequestApi.imgBaseUrl}task.png",
        title: "发任务",
        content: "事情太多一键找人",
        page: RouteConfig.publishTask,
      ),
      Release(
        img: "${RequestApi.imgBaseUrl}moment.png",
        title: "发瞬间",
        content: "分享我的有趣生活",
        page: RouteConfig.publishDynamic,
      ),
      Release(
        img: "${RequestApi.imgBaseUrl}radioBroadcast.png",
        title: "发广播",
        content: "产品没销量一键广告",
        page: RouteConfig.broadcast,
      ),
      Release(
        img: "${RequestApi.imgBaseUrl}xianzhi.png",
        title: "发闲置",
        content: "存着不如换钱花",
        page: RouteConfig.setAside,
      ),
    ];
  }
}

/// 发布
class Release {
  /// 图片地址
  final String img;
  /// 标题
  final String title;
  /// 内容
  final String content;
  /// 跳转的页面
  final String page;

  Release({required this.img, required this.title, required this.content, required this.page});
}
