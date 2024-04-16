import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 隐私设置页面
class PrivacySetting extends StatelessWidget {
  PrivacySetting({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PrivacySettingLogic());

  /// 数据层
  final state = Get.find<PrivacySettingLogic>().state;

  /// 列
  Widget line(String title, String key, {String? subtitle}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.dp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 标题s
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 30.dp,
                    ),
                  ),

                  Visibility(
                    visible: subtitle != null,
                    child: SizedBox(height: 10.dp),
                  ),

                  /// 子标题
                  Visibility(
                    visible: subtitle != null,
                    child: Text(
                      subtitle ?? "",
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: darkGreyColor,
                      ),
                    ),
                  ),
                ],
              ),

              /// 开关
              GetBuilder<PrivacySettingLogic>(builder: (e) {
                return CupertinoSwitch(
                  value: state.info[key] == 1 ? true : false,
                  onChanged: (value) => logic.onChanged(value, key),
                  activeColor: paleGreenColor,
                  trackColor: const Color.fromRGBO(63, 70, 72, 1),
                  thumbColor: Colors.white,
                );
              }),
            ],
          ),
        ),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(34, 41, 43, 1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// 用户隐私保存
        await logic.userSettingSave();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
          title: const Text("隐私设置"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.dp),
          children: [
            /// 第一区域
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.dp),
              decoration: BoxDecoration(
                color: blackGrey,
                borderRadius: BorderRadius.circular(14.dp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.dp),
                  Text(
                    "可通过以下方式加我好友，关闭则不能通过以下方式添加",
                    style: TextStyle(
                      color: darkGreyColor,
                      fontSize: 24.dp,
                    ),
                  ),
                  line("附近推荐", "nearbyStatus"),
                  line("搜索添加", "searchStatus"),
                  line("个人二维码", "qrcodeStatus"),
                  // line("实时动态关闭或开启"),
                ],
              ),
            ),
            SizedBox(height: 30.dp),

            /// 其他隐私设置
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.dp),
              decoration: BoxDecoration(
                color: blackGrey,
                borderRadius: BorderRadius.circular(14.dp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.dp),
                  Text(
                    "其他隐私设置",
                    style: TextStyle(
                      color: darkGreyColor,
                      fontSize: 24.dp,
                    ),
                  ),
                  line("是否显示性别", "sexStatus", subtitle: "开启后个人主页显示性别，关闭则不显示"),
                  line("是否显示年龄", "ageStatus", subtitle: "开启后个人主页显示年龄，关闭则不显示"),
                  line("是否显示地区", "addressStatus",
                      subtitle: "开启后个人主页显示地区，关闭则不显示"),
                  line("个人主页是否显示分享按钮", "homeShareStatus",
                      subtitle: "开启后个人主页显示分享，关闭则不显示"),
                  line("我的发布是否显示分享按钮", "contentShareStatus",
                      subtitle: "开启后内容页显示分享按钮，关闭则不能分享"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
