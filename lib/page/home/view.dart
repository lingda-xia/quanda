import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/page/chatPage/chat/view.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/page/index/index/view.dart';
import 'package:quanda/page/myPage/My/view.dart';
import 'package:quanda/page/publishPage/publish/view.dart';
import 'package:quanda/page/taskPage/task/view.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 主页  底部导航栏
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /// 逻辑层
  final logic = Get.put(HomePageLogic());

  /// 数据层
  final state = Get.find<HomePageLogic>().state;

  int tabIndex = 0;

  /// 腾讯im
  final tim = Get.find<TencentImLogic>();

  final List<String> tabImages = [
    'img/bottomNavigation/quanda_no.png',
    'img/bottomNavigation/task_no.png',
    'img/bottomNavigation/release.png',
    'img/bottomNavigation/chat_no.png',
    'img/bottomNavigation/my.png',
  ];

  final List<String> tabSelectedImages = [
    'img/bottomNavigation/quanda.png',
    'img/bottomNavigation/task.png',
    'img/bottomNavigation/release.png',
    'img/bottomNavigation/chat.png',
    'img/bottomNavigation/my.png',
  ];

  /// 控制器
  late TabController tabController;

  /// 用户信息
  late UserInfo? userInfo = UserInfo(0, "", 0, 0, "", 0, 1, "", "", "", 0);

  /// 更换图标
  String getImageUrl(int index) {
    if (index == state.tabIndex) {
      return tabSelectedImages[index];
    } else {
      return tabImages[index];
    }
  }

  /// 获取用户信息
  getUserInfo() async {
    /// 发起请求
    UserRequest.getUserInfo(
      loading: false,
      success: (data) {
        setState(() {
          userInfo = data;
        });
      },
      fail: (code, msg) {},
    );
  }

  @override
  void initState() {
    super.initState();

    /// 获取用户信息
    getUserInfo();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  Widget _buildItem(String icon, String title, String linkTo) => ListTile(
        dense: true,
        minLeadingWidth: 0,
        leading: Image.asset(
          "img/Icon/$icon.png",
          width: 40.dp,
          height: 40.dp,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 30.dp,
            color: themeWhite,
          ),
        ),
        trailing: Image.asset(
          "img/Icon/back.png",
          width: 14.dp,
          height: 24.dp,
        ),
        onTap: () async {
          await Get.toNamed(linkTo);

          /// 用于返回更新名称等信息
          if (linkTo == RouteConfig.systemSetting) {
            /// 获取用户信息
            getUserInfo();
          }
        },
      );

  /// 侧边栏
  Widget _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: blackGrey,
      width: 530.dp,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 80.dp),

          /// 关闭侧边栏
          GestureDetector(
            onTap: () {
              Get.back();
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.all(30.dp),
              alignment: Alignment.centerRight,
              child: Image.asset(
                "img/Icon/chacha.png",
                width: 44.dp,
                height: 44.dp,
              ),
            ),
          ),

          /// 头部个人信息
          GestureDetector(
            onTap: () async {
              await Get.toNamed(RouteConfig.personalData);

              /// 获取用户信息
              getUserInfo();
            },
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                SizedBox(width: 30.dp),

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
                      imgUrl: userInfo!.avatarUrl == ""
                          ? "${RequestApi.baseUrl}/api/static/boy.png"
                          : userInfo!.avatarUrl,
                      width: 140.dp,
                      height: 140.dp,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 20.dp),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 名称
                    SizedBox(
                      width: 272.dp,
                      child: Text(
                        userInfo!.nickname,
                        style: TextStyle(
                          fontSize: 36.dp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: 20.dp),

                    /// 实名
                    Row(
                      children: [
                        Image.asset(
                          "img/Icon/${userInfo?.authStatus == 0 ? "NotCertified" : "yishiming"}.png",
                          width: 34.dp,
                          height: 25.dp,
                        ),

                        SizedBox(width: 8.dp),

                        /// 实名
                        Text(
                          userInfo?.authStatus == 0 ? "未实名" : "已实名",
                          style: TextStyle(
                            fontSize: 20.dp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Image.asset(
                  "img/Icon/back.png",
                  width: 14.dp,
                  height: 24.dp,
                ),
              ],
            ),
          ),

          SizedBox(height: 50.dp),

          /// 下划线
          Divider(
            height: 1.dp,
            thickness: 1.dp,
            endIndent: 40.dp,
            indent: 40.dp,
            color: const Color.fromRGBO(44, 48, 47, 1),
          ),

          SizedBox(height: 40.dp),

          _buildItem("my_order", "我的订单", RouteConfig.myOrder),
          _buildItem("my_collection", "我的收藏", RouteConfig.myCollection),
          _buildItem("my_interaction", "我的互动", RouteConfig.myInteraction),
          SizedBox(height: 100.dp),
          _buildItem("privacy_settings", "隐私设置", RouteConfig.privacySetting),
          _buildItem("system_settings", "系统设置", RouteConfig.systemSetting),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 右侧抽屉
      endDrawer: _drawer(context),

      /// 是否允许手势滑动显示侧边栏
      endDrawerEnableOpenDragGesture: false,
      body: Stack(
        children: [
          TabBarView(
            /// 不允许滑动
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: <Widget>[
              /// 首页
              Index(),

              /// 任务页面
              Task(),

              /// 发布页面
              Publish(),

              /// 聊天
              const ChatPage(),

              /// 我的
              MyPage(),
            ],
          ),

          /// 底部导航栏
          Positioned(
            bottom: 0,
            height: 180.dp,
            width: 750.dp,
            child: Container(
              height: 120.dp,
              margin: EdgeInsets.only(bottom: 60.dp, left: 35.dp, right: 35.dp),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(12, 22, 25, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(60.0),
                ),
                border: Border.fromBorderSide(
                  BorderSide(
                    width: 0.5,
                    color: Color.fromRGBO(50, 53, 62, 1),
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: GetBuilder<HomePageLogic>(
                builder: (_) {
                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 10.dp),
                        labelStyle: TextStyle(
                          fontSize: 20.dp,
                        ),

                        splashBorderRadius:
                        const BorderRadius.all(Radius.circular(60.0)),

                        /// 指示器大小
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: const Color.fromRGBO(12, 22, 25, 1),

                        /// 指示器的宽度
                        indicatorWeight: 0.1,

                        /// 激活后的文本颜色
                        labelColor: const Color.fromRGBO(223, 226, 235, 1),

                        /// 未激活的文本颜色
                        unselectedLabelColor: const Color.fromRGBO(80, 83, 92, 1),
                        controller: tabController,
                        onTap: (index) {
                          if (index == 2) return;
                          if (state.tabIndex == index) return;
                          logic.selectIndex(index);
                        },
                        tabs: [
                          Tab(
                            text: "圈达",
                            iconMargin: EdgeInsets.only(bottom: 4.dp),
                            icon: Image.asset(
                              getImageUrl(0),
                              width: 50.dp,
                              height: 50.dp,
                            ),
                          ),
                          Tab(
                            text: "任务",
                            iconMargin: EdgeInsets.only(bottom: 4.dp),
                            icon: Image.asset(
                              getImageUrl(1),
                              width: 50.dp,
                              height: 50.dp,
                            ),
                          ),
                          Tab(
                            child: Image.asset(
                              getImageUrl(2),
                              width: 127.dp,
                              height: 127.dp,
                            ),
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Tab(
                                text: "聊天",
                                iconMargin: EdgeInsets.only(bottom: 4.dp),
                                icon: Image.asset(
                                  getImageUrl(3),
                                  width: 50.dp,
                                  height: 50.dp,
                                ),
                              ),

                              /// 未读消息数
                              Positioned(
                                top: 2.dp,
                                right: -10.dp,
                                child: GetBuilder<TencentImLogic>(
                                  builder: (_) {
                                    return tim.state.unreadMsgSum == 0
                                        ? Container()
                                        : Container(
                                      width: 34.dp,
                                      height: 34.dp,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(17.dp),
                                        color: const Color.fromRGBO(
                                            255, 77, 96, 1),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        tim.state.unreadMsgSum.toString(),
                                        style: TextStyle(
                                          fontSize: 24.dp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Tab(
                            text: "我的",
                            iconMargin: EdgeInsets.only(bottom: 4.dp),
                            icon: Image.asset(
                              getImageUrl(4),
                              width: 50.dp,
                              height: 50.dp,
                            ),
                          ),
                        ],
                      ),

                      /// 障眼法  底部导航栏的中间按钮  前往发布页面
                      Positioned(
                        bottom: 0.dp,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteConfig.publish);
                          },
                          child: Image.asset(
                            getImageUrl(2),
                            width: 125.dp,
                            height: 125.dp,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
