import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'state.dart';
import 'widget/imgStatus.dart';
import 'widget/mainContent.dart';
import 'widget/videoStatus.dart';

/// 查看详情 页面
class SeeDetails extends StatefulWidget {
  const SeeDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<SeeDetails> createState() => _SeeDetailsState();
}

class _SeeDetailsState extends State<SeeDetails> {
  /// 逻辑层
  final SeeDetailsLogic logic = Get.put(SeeDetailsLogic());

  /// 数据层
  late SeeDetailsState state = Get.find<SeeDetailsLogic>().state;

  @override
  void initState() {
    super.initState();
    state.id = Get.parameters["id"]!;
    if (Get.parameters["close"] != null) {
      state.close = true;
    } else {
      state.close = false;
    }

    /// 页面加载完成
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 获取详情信息
      logic.getDetailsInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 私聊按钮
  Widget chatButton() {
    return GestureDetector(
      onTap: logic.goToPrivateChat,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.dp),
        alignment: Alignment.center,
        child: Image.asset(
          "img/Icon/privateLetter.png",
          width: 60.dp,
          height: 60.dp,
        ),
      ),
    );
  }

  /// 头部标题栏  视频状态
  _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.width,
      pinned: true,
      leading: const BackButton(),

      /// 右边区域
      actions: [
        GestureDetector(
          onTap: () => {},
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "···",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 40.dp,
              ),
            ),
          ),
        ),
        SizedBox(width: 40.dp),
      ],

      /// 拉伸区域  视频播放
      flexibleSpace: VideoStatus(
        state: state,
        logic: logic,
      ),
    );
  }

  /// 头部标题栏 图片状态
  _buildSliverAppBarImg(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.width,
      pinned: true,
      leading: const BackButton(),
      title: GestureDetector(
        onTap: () => logic.goToOthers(state.details.userId.toString()),
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: [
            /// 头像
            ClipRRect(
              borderRadius: BorderRadius.circular(35.dp),
              child: CachedImage(
                imgUrl: state.details.userInfo.avatarUrl == ""
                    ? "${RequestApi.baseUrl}/api/static/boy.png"
                    : state.details.userInfo.avatarUrl,
                width: 70.dp,
                height: 70.dp,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 20.dp),
            Text(
              state.details.userInfo.nickname,
              style: TextStyle(fontSize: 30.dp),
            ),
          ],
        ),
      ),
      centerTitle: false,
      backgroundColor: const Color.fromRGBO(7, 17, 20, 1),

      /// 右边区域
      actions: [
        /// 如果查看的是自己的发布  不显示私聊
        state.userInfo.userId == state.details.userId
            ? Container()

            /// 私聊
            : GestureDetector(
                onTap: () => {},
                behavior: HitTestBehavior.translucent,
                child: Container(
                  alignment: Alignment.center,
                  child: chatButton(),
                ),
              ),
        SizedBox(width: 50.dp),
        GestureDetector(
          onTap: () => {},
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "···",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 40.dp,
              ),
            ),
          ),
        ),
        SizedBox(width: 40.dp),
      ],

      /// 拉伸区域
      flexibleSpace: ImgStatus(
        state: state,
        logic: logic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SeeDetailsLogic>(
        builder: (_) {
          return Stack(
            children: [
              /// 主体部分
              CustomScrollView(
                slivers: <Widget>[
                  /// 头部标题栏
                  state.notVideo

                      /// 图片状态
                      ? _buildSliverAppBarImg(context)

                      /// 视频状态
                      : _buildSliverAppBar(context),

                  /// 主题内容 自定义widget
                  MainContent(
                    state: state,
                    getLogic: logic,
                  )
                ],
              ),

              /// 底部悬浮栏
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140.dp,
                  padding: EdgeInsets.only(top: 30.dp),
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                      width: 1.dp,
                      color: lightBlackDivider,
                    )),
                    color: const Color.fromRGBO(7, 17, 20, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(width: 30.dp),

                      // /// 评论框
                      // SizedBox(
                      //   width: 264.dp,
                      //   height: 64.dp,
                      //   child: TextField(
                      //     /// 最大行数
                      //     maxLines: 1,
                      //
                      //     /// 监听输入改变的时候
                      //     onChanged: logic.onInput,
                      //
                      //     /// 输入的文本样式
                      //     style: TextStyle(
                      //       color: const Color.fromRGBO(223, 226, 235, 1),
                      //       fontSize: 22.dp,
                      //     ),
                      //
                      //     /// 光标颜色
                      //     cursorColor: const Color.fromRGBO(223, 226, 235, 1),
                      //
                      //     /// 装饰
                      //     decoration: InputDecoration(
                      //       /// 未输入时提示的内容
                      //       hintText: "说点什么...",
                      //
                      //       /// 提示的文本样式
                      //       hintStyle: TextStyle(
                      //         color: darkGreyColor,
                      //         fontSize: 22.dp,
                      //         fontFamily: "PingFang SC",
                      //       ),
                      //
                      //       /// 左侧图标
                      //       prefixIcon: Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 20.dp),
                      //         child: Image.asset(
                      //           "img/Icon/edit.png",
                      //           width: 22.dp,
                      //           height: 24.dp,
                      //         ),
                      //       ),
                      //
                      //       prefixIconConstraints: BoxConstraints(
                      //         maxHeight: 50.dp,
                      //         maxWidth: 60.dp,
                      //       ),
                      //
                      //       /// 内边距
                      //       contentPadding: EdgeInsets.only(left: 30.dp),
                      //
                      //       /// 是否填充
                      //       filled: true,
                      //
                      //       /// 填充的颜色  类似背景颜色
                      //       fillColor: blackGrey,
                      //
                      //       /// 边框
                      //       enabledBorder: _getEditBorder(),
                      //
                      //       /// 聚焦后的边框
                      //       focusedBorder: _getEditBorder(),
                      //     ),
                      //   ),
                      // ),

                      // SizedBox(width: 20.dp),

                      /// 点赞
                      state.details.giveStatus == 0

                          /// 未点赞
                          ? GestureDetector(
                              onTap: logic.giveRelease,
                              behavior: HitTestBehavior.translucent,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.dp),
                                child: Image.asset(
                                  "img/Icon/no_fabulous.png",
                                  width: 46.dp,
                                  height: 46.dp,
                                ),
                              ),
                            )

                          /// 已点赞
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.dp),
                              child: Image.asset(
                                "img/Icon/dibu_good.png",
                                width: 46.dp,
                                height: 46.dp,
                              ),
                            ),

                      /// 点赞数
                      Text(
                        state.details.giveNumber.toString(),
                        style: TextStyle(
                          fontSize: 34.dp,
                        ),
                      ),

                      SizedBox(width: 100.dp),

                      /// 收藏
                      state.details.collectStatus == 0

                          /// 未收藏
                          ? GestureDetector(
                              onTap: logic.collectRelease,
                              behavior: HitTestBehavior.translucent,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 16.dp),
                                child: Image.asset(
                                  "img/Icon/no_collection.png",
                                  width: 46.dp,
                                  height: 46.dp,
                                ),
                              ),
                            )

                          /// 已收藏
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.dp),
                              child: Image.asset(
                                "img/Icon/collection.png",
                                width: 46.dp,
                                height: 46.dp,
                              ),
                            ),

                      /// 收藏数
                      Text(
                        state.details.collectNumber.toString(),
                        style: TextStyle(
                          fontSize: 34.dp,
                        ),
                      ),
                      // SizedBox(width: 10.dp),

                      /// 评论
                      // GestureDetector(
                      //   onTap: () => {},
                      //   behavior: HitTestBehavior.translucent,
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 16.dp),
                      //     child: Image.asset(
                      //       "img/Icon/news.png",
                      //       width: 36.dp,
                      //       height: 36.dp,
                      //     ),
                      //   ),
                      // ),

                      /// 评论数
                      // Text(
                      //   state.details.commentNumber.toString(),
                      //   style: TextStyle(
                      //     fontSize: 24.dp,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
