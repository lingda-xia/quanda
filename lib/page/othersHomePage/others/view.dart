import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'dart:math';

import 'logic.dart';
import 'widget/more.dart';
import 'widget/tabList.dart';

/// 他人主页 页面
class Others extends StatelessWidget {
  Others({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(OthersLogic());

  /// 数据层
  final state = Get.find<OthersLogic>().state;

  /// 弹起更多弹窗
  void openMore() async {
    await Get.bottomSheet(
      /// 提交订单弹窗 自定义widget
      More(
        state: state,
        logic: logic,
      ),

      /// 蒙层颜色
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),

      /// 设置圆角  圆角矩形
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.dp),
          topLeft: Radius.circular(40.dp),
        ),
      ),
      backgroundColor: blackGrey,
    );
  }

  /// 点赞部分
  Widget fabulous() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 高颜值
        GestureDetector(
          onTap: state.userInfo.appearanceStatus != 1
              ? () => logic.appearanceSave(1)
              : null,
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              Text(
                state.userInfo.appearanceHighNumber.toString(),
                style: TextStyle(
                  fontSize: 28.dp,
                  color: state.userInfo.appearanceStatus == 1
                      ? const Color.fromRGBO(142, 231, 203, 1)
                      : const Color.fromRGBO(223, 226, 235, 1),
                ),
              ),
              SizedBox(height: 24.dp),
              Row(
                children: [
                  Image.asset(
                    "img/Icon/${state.userInfo.appearanceStatus == 1 ? "high" : "no_high"}.png",
                    width: 48.dp,
                    height: 48.dp,
                  ),
                  SizedBox(width: 10.dp),
                  Text(
                    "高颜值",
                    style: TextStyle(
                      fontSize: 28.dp,
                      color: state.userInfo.appearanceStatus == 1
                          ? const Color.fromRGBO(142, 231, 203, 1)
                          : const Color.fromRGBO(223, 226, 235, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(width: 86.dp),

        /// 小呆呆
        GestureDetector(
          onTap: state.userInfo.appearanceStatus != 2
              ? () => logic.appearanceSave(2)
              : null,
          behavior: HitTestBehavior.translucent,
          child: Column(
            children: [
              Text(
                state.userInfo.appearanceLowNumber.toString(),
                style: TextStyle(
                  fontSize: 28.dp,
                  color: state.userInfo.appearanceStatus == 2
                      ? const Color.fromRGBO(142, 231, 203, 1)
                      : const Color.fromRGBO(223, 226, 235, 1),
                ),
              ),
              SizedBox(height: 24.dp),
              Row(
                children: [
                  Image.asset(
                    "img/Icon/${state.userInfo.appearanceStatus == 2 ? "low" : "no_good"}.png",
                    width: 48.dp,
                    height: 48.dp,
                  ),
                  SizedBox(width: 10.dp),
                  Text(
                    "小呆呆",
                    style: TextStyle(
                      fontSize: 28.dp,
                      color: state.userInfo.appearanceStatus == 2
                          ? const Color.fromRGBO(142, 231, 203, 1)
                          : const Color.fromRGBO(223, 226, 235, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 性别和地点
  Widget genderAndAddress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 性别
        Container(
          height: 36.dp,
          padding: EdgeInsets.symmetric(horizontal: 9.dp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.dp),
            color: state.userInfo.sex == 1
                ? const Color.fromRGBO(49, 156, 255, 1)
                : const Color.fromRGBO(255, 114, 129, 1),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Image.asset(
                "img/Icon/${state.userInfo.sex == 1 ? "nan" : "nv"}.png",
                width: 20.dp,
                height: 20.dp,
              ),
              SizedBox(width: 2.dp),
              Text(
                state.userInfo.age.toString(),
                style: TextStyle(
                  fontSize: 22.dp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 20.dp),

        /// 地点
        Container(
          height: 36.dp,
          padding: EdgeInsets.symmetric(horizontal: 9.dp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.dp),
            color: const Color.fromRGBO(100, 203, 177, 1),
          ),
          alignment: Alignment.center,
          child: Text(
            city(),
            style: TextStyle(
              fontSize: 22.dp,
              color: Colors.white,
            ),
          ),
        ),

        SizedBox(width: 20.dp),

        /// 距离
        Container(
          height: 36.dp,
          padding: EdgeInsets.symmetric(horizontal: 9.dp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.dp),
            color: const Color.fromRGBO(46, 55, 57, 1),
          ),
          alignment: Alignment.center,
          child: Text(
            "距你:${state.userInfo.distance}",
            style: TextStyle(
              fontSize: 22.dp,
            ),
          ),
        ),
      ],
    );
  }

  /// 好友和私信
  Widget friendAndChat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// 加好友 已经是好友不显示
        state.userInfo.friendStatus == 2
            ? Container()
            : GestureDetector(
                onTap: logic.goToNonFriends,
                child: Image.asset(
                  "img/Icon/addFriends.png",
                  width: 186.dp,
                  height: 76.dp,
                ),
              ),

        state.userInfo.friendStatus == 2 ? Container() : SizedBox(width: 86.dp),

        /// 私信
        GestureDetector(
          onTap: logic.goToPrivateChat,
          child: Image.asset(
            "img/Icon/private_letter.png",
            width: 186.dp,
            height: 76.dp,
          ),
        ),
      ],
    );
  }

  /// 显示的地址处理
  String city() {
    String str = "";

    if (state.address.city == "黑龙江") {
      str = state.address.city;
    } else {
      str = state.address.city.substring(0, 2);
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {
    /// 背景图
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage("${RequestApi.imgBaseUrl}TopBack.png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),

          /// 更多
          actions: [
            GestureDetector(
              onTap: openMore,
              behavior: HitTestBehavior.translucent,
              child: Container(
                padding: EdgeInsets.all(40.dp),
                alignment: Alignment.center,
                child: Image.asset(
                  "img/Icon/more.png",
                  width: 44.dp,
                  height: 10.dp,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: GetBuilder<OthersLogic>(
            builder: (_) {
              return Column(
                children: [
                  /// 头像
                  Container(
                    width: 158.dp,
                    height: 158.dp,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.dp,
                        color: const Color.fromRGBO(108, 228, 203, 1),
                      ),
                      borderRadius: BorderRadius.circular(79.dp),
                    ),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70.dp),
                      child: CachedImage(
                        imgUrl: state.userInfo.avatarUrl == ""
                            ? "${RequestApi.baseUrl}/api/static/boy.png"
                            : state.userInfo.avatarUrl,
                        width: 140.dp,
                        height: 140.dp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.dp),

                  /// 名称和实名
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.userInfo.nickname,
                        style: TextStyle(
                          fontSize: 36.dp,
                        ),
                      ),

                      SizedBox(width: 8.dp),

                      Image.asset(
                        "img/Icon/${state.userInfo.authStatus == 0 ? "NotCertified" : "yishiming"}.png",
                        width: 34.dp,
                        height: 25.dp,
                      ),

                      SizedBox(width: 8.dp),

                      /// 实名
                      Text(
                        state.userInfo.authStatus == 0 ? "未实名" : "已实名",
                        style: TextStyle(
                          fontSize: 20.dp,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 25.dp),

                  /// 性别和地点
                  genderAndAddress(),

                  SizedBox(height: 20.dp),

                  /// 简介
                  state.userInfo.introduction == ""
                      ? Container()
                      : Text(
                          "简介：${state.userInfo.introduction}",
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 20.dp,
                          ),
                        ),

                  state.userInfo.userId == state.info.userId
                      ? Container()
                      : SizedBox(height: 50.dp),

                  /// 点赞部分  如果是自己不可见
                  state.userInfo.userId == state.info.userId
                      ? Container()
                      : fabulous(),

                  SizedBox(height: 45.dp),

                  /// 好友和私信  如果是自己不可见
                  state.userInfo.userId == state.info.userId
                      ? Container()
                      : friendAndChat(),

                  state.userInfo.userId == state.info.userId
                      ? Container()
                      : SizedBox(height: 40.dp),

                  /// 下划线
                  Divider(
                    height: 2.dp,
                    thickness: 2.dp,
                    color: lightBlackDivider,
                  ),

                  /// tab列表
                  SizedBox(
                    height: 600,

                    /// 自定义tab列表
                    child: TabList(
                      state: state,
                      logic: logic,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
