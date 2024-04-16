import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/wallet.dart';
import 'widget/interaction.dart';

/// 个人主页页面
class MyPage extends StatelessWidget {
  MyPage({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(MyLogic());

  /// 数据层
  final state = Get.find<MyLogic>().state;

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
    print("我的页面构建了");

    /// 页面重构完成回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 获取用户主页信息
      logic.personHomePage();
    });

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          shadowColor: Colors.transparent,

          centerTitle: false,

          /// 加好友
          title: GestureDetector(
            onTap: logic.goToPersonalQRCode,
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                SizedBox(width: 30.dp),
                Image.asset(
                  "img/Icon/QRcode.png",
                  width: 30.dp,
                  height: 30.dp,
                ),
                SizedBox(width: 15.dp),
                Text(
                  "加好友",
                  style: TextStyle(
                    fontSize: 26.dp,
                  ),
                ),
              ],
            ),
          ),

          actions: [
            /// 二维码
            GestureDetector(
              onTap: logic.scanQRCode,
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.dp),
                child: Image.asset(
                  "img/Icon/saoma.png",
                  width: 32.dp,
                  height: 32.dp,
                ),
              ),
            ),

            /// 侧边栏
            GestureDetector(
              onTap: () {
                /// 打开侧边栏
                Scaffold.of(context).openEndDrawer();
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.dp),
                child: Image.asset(
                  "img/Icon/gengduo.png",
                  width: 30.dp,
                  height: 30.dp,
                ),
              ),
            ),
            SizedBox(width: 40.dp),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.dp),
          child: GetBuilder<MyLogic>(
            builder: (_) {
              return Column(
                children: [
                  SizedBox(height: 30.dp),

                  /// 头部个人信息
                  Row(
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
                            imgUrl: state.userInfo.avatarUrl == ""
                                ? "${RequestApi.baseUrl}/api/static/boy.png"
                                : state.userInfo.avatarUrl,
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
                          /// 名称和实名
                          Row(
                            children: [
                              /// 名称
                              Text(
                                state.userInfo.nickname,
                                style: TextStyle(
                                  fontSize: 36.dp,
                                ),
                              ),

                              SizedBox(width: 14.dp),

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
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.dp),

                          /// 性别和地点
                          Row(
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
                            ],
                          ),

                          SizedBox(height: 20.dp),

                          /// 个人简介
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 420.dp,
                            ),
                            child: Text(
                              state.userInfo.introduction,
                              style: TextStyle(
                                fontSize: 20.dp,
                                color: greyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 50.dp),

                  /// 我的钱包  自定义widget
                  Wallet(
                    /// 数据源
                    data: state,

                    /// 点击事件
                    onTap: () => logic.goToMyWallet(),
                  ),

                  SizedBox(height: 90.dp),

                  /// 互动和发布互动
                  Row(
                    children: [
                      /// 我的互动
                      GestureDetector(
                        onTap: logic.goToMyInteraction,
                        behavior: HitTestBehavior.translucent,
                        child: const Text("我的互动"),
                      ),

                      SizedBox(width: 12.dp),

                      Image.asset(
                        "img/Icon/back.png",
                        width: 12.dp,
                        height: 20.dp,
                      ),

                      const Expanded(child: SizedBox()),

                      Image.asset(
                        "img/Icon/classification.png",
                        width: 26.dp,
                        height: 26.dp,
                      ),

                      SizedBox(width: 7.dp),

                      /// 发布互动
                      GestureDetector(
                        onTap: logic.goToPublish,
                        behavior: HitTestBehavior.translucent,
                        child: Text(
                          "发布互动",
                          style: TextStyle(
                            fontSize: 24.dp,
                            color: paleGreenColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// 互动列表  自定义widget
                  Container(
                    height: MediaQuery.of(context).size.height - 150,
                    padding: EdgeInsets.only(top: 30.dp),
                    child: Interaction(
                      state: state,
                      logic: logic,
                    ),
                  ),

                  SizedBox(height: 60.dp),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
