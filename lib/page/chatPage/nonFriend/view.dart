import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/function_event.dart';
import 'package:quanda/widget/user_status_bar.dart';

import 'logic.dart';

/// 查看非好友状态页面
class NonFriends extends StatelessWidget {
  NonFriends({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(NonFriendLogic());

  /// 数据层
  final state = Get.find<NonFriendLogic>().state;

  /// 个人主页照片
  Widget photos(String img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60.dp),
      child: CachedImage(
        imgUrl: img,
        width: 118.dp,
        height: 118.dp,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
      ),
      body: GetBuilder<NonFriendLogic>(
        builder: (_) {
          return Column(
            children: [
              /// 用户信息状态栏  自定义widget
              UserStatusBar(
                data: state.othersInfo,
              ),

              /// 下划线
              Divider(
                height: 10.dp,
                thickness: 10.dp,
                color: darkBlackDivider,
              ),

              /// 状态栏
              Column(
                children: [
                  /// 简介
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 96.dp,
                          padding: EdgeInsets.symmetric(horizontal: 40.dp),
                          child: Row(
                            children: [
                              /// 标签
                              Text(
                                "简介",
                                style: TextStyle(
                                  fontSize: 28.dp,
                                ),
                              ),
                              SizedBox(width: 25.dp),

                              /// 信息说明
                              Expanded(
                                child: Text(
                                  state.othersInfo.introduction == ""
                                      ? "暂无简介"
                                      : state.othersInfo.introduction,
                                  style: TextStyle(
                                    color: greyColor,
                                    fontSize: 28.dp,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  // maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// 下划线
                      Divider(
                        height: 1.dp,
                        thickness: 1.dp,
                        color: lightBlackDivider,
                      ),
                    ],
                  ),

                  /// 来源
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 96.dp,
                          padding: EdgeInsets.symmetric(horizontal: 40.dp),
                          child: Row(
                            children: [
                              /// 标签
                              Text(
                                "来源",
                                style: TextStyle(
                                  fontSize: 28.dp,
                                ),
                              ),
                              SizedBox(width: 25.dp),

                              /// 信息说明
                              Expanded(
                                child: Text(
                                  state.othersInfo.source,
                                  style: TextStyle(
                                    color: greyColor,
                                    fontSize: 28.dp,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  // maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// 下划线
                      Divider(
                        height: 1.dp,
                        thickness: 1.dp,
                        color: lightBlackDivider,
                      ),
                    ],
                  ),

                  /// 个人主页
                  GestureDetector(
                    onTap: logic.goToOthers,
                    behavior: HitTestBehavior.translucent,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.dp, vertical: 20.dp),
                            child: Row(
                              children: [
                                /// 标签
                                Text(
                                  "个人主页",
                                  style: TextStyle(
                                    fontSize: 28.dp,
                                  ),
                                ),
                                SizedBox(width: 50.dp),

                                /// 信息说明
                                Expanded(
                                  child: Wrap(
                                    spacing: 30.dp,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              state
                                                  .othersInfo.momentList.length;
                                          i++)
                                        photos(state.othersInfo.momentList[i]),
                                    ],
                                  ),
                                ),

                                /// 右箭头
                                Icon(
                                  Icons.chevron_right,
                                  color: greyColor,
                                  size: 40.dp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /// 下划线
              Divider(
                height: 10.dp,
                thickness: 10.dp,
                color: darkBlackDivider,
              ),

              /// 添加到通讯录
              FunctionEvent(
                onTap: () {
                  logic.goToAddFriends();
                },
                title: "添加到通讯录",
              ),
            ],
          );
        },
      ),
    );
  }
}
