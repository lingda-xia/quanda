import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import '../logic.dart';
import '../state.dart';

/// 详情的主体内容
class MainContent extends StatelessWidget {
  const MainContent({Key? key, required this.state, required this.getLogic})
      : super(key: key);

  /// 逻辑层
  final SeeDetailsLogic getLogic;

  /// 数据层
  final SeeDetailsState state;

  /// 私聊按钮
  Widget chatButton() {
    return GestureDetector(
      onTap: getLogic.goToPrivateChat,
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

  /// 评论
  Widget comment() {
    return Row(
      children: [
        /// 头像
        CircleAvatar(
          radius: 35.dp,

          /// 为加载成功时显示的背景色
          backgroundColor: Colors.white,
          backgroundImage:
              const NetworkImage("${RequestApi.baseUrl}/api/static/boy.png"),
        ),
        SizedBox(width: 25.dp),

        /// 名称时间和内容
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "咸菜一号 · 5月16",
              style: TextStyle(
                color: darkGreyColor,
                fontSize: 20.dp,
              ),
            ),
            SizedBox(height: 10.dp),
            Text(
              "在哪在哪，多大尺寸，新衣服吗",
              style: TextStyle(
                fontSize: 28.dp,
              ),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),

        /// 点赞
        Column(
          children: [
            Stack(
              children: [
                Visibility(
                  visible: true,
                  child: Image.asset(
                    "img/Icon/good.png",
                    width: 36.dp,
                    height: 36.dp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.dp),
            Text(
              "25",
              style: TextStyle(
                fontSize: 18.dp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 内容展示处理
  String processing() {
    late String str = "";

    int length = state.details.content.length;

    if(length > 100 && !state.develop) {
      str = state.details.content.substring(0, 100);
    } else {
      str = state.details.content;
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 信息详情以及购买按钮
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 头像和名字区域
                !state.notVideo

                    /// 视频状态
                    ? GestureDetector(
                        onTap: () => getLogic
                            .goToOthers(state.details.userId.toString()),
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          children: [
                            /// 头像
                            CircleAvatar(
                              radius: 35.dp,

                              /// 为加载成功时显示的背景色
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  state.details.userInfo.avatarUrl == ""
                                      ? "${RequestApi.baseUrl}/api/static/boy.png"
                                      : state.details.userInfo.avatarUrl),
                            ),
                            SizedBox(width: 20.dp),
                            Text(
                              state.details.userInfo.nickname,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const Expanded(child: SizedBox()),

                            /// 私聊按钮   如果查看的是自己的发布  不显示
                            state.userInfo.userId == state.details.userId
                                ? Container()
                                : chatButton(),
                          ],
                        ),
                      )

                    /// 图片状态
                    : Container(),

                SizedBox(height: 30.dp),

                /// 标题
                Text(state.details.title),

                SizedBox(height: 15.dp),

                /// 内容展示
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: processing(),
                        style: TextStyle(fontSize: 24.dp, color: greyColor),
                      ),
                      state.details.content.length > 100
                          ? TextSpan(
                              text: state.develop ? "收起" : "展开全部",
                              style: TextStyle(
                                  fontSize: 24.dp, color: paleGreenColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => getLogic.open(),
                            )
                          : const TextSpan(),
                    ],
                  ),
                ),

                SizedBox(height: 40.dp),

                /// 到店奖励 男女不限  任务类型展示
                Visibility(
                  visible: state.details.type == 3,
                  child: Row(
                    children: [
                      Text(
                        "#${state.taskType[state.details.taskType]}#",
                        style: TextStyle(
                          color: paleGreenColor,
                          fontSize: 24.dp,
                        ),
                      ),
                      SizedBox(width: 10.dp),
                      Text(
                        "#${state.sexType[state.details.sex]}#",
                        style: TextStyle(
                          color: paleGreenColor,
                          fontSize: 24.dp,
                        ),
                      ),
                      SizedBox(width: 10.dp),
                      Text(
                        "#任务耗时${state.details.taskTime}分钟#",
                        style: TextStyle(
                          color: paleGreenColor,
                          fontSize: 24.dp,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 包邮到家 闲置类型展示
                Visibility(
                  visible: state.details.type == 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "img/Icon/mail.png",
                        width: 20.dp,
                        height: 20.dp,
                      ),
                      SizedBox(width: 8.dp),
                      Text(
                        state.extract[state.details.extractType],
                        style: TextStyle(
                          fontSize: 22.dp,
                          color: paleGreenColor,
                        ),
                      ),
                    ],
                  ),
                ),

                /// 招募中  任务类型展示   任务审核通过  1 或者 任务进行中  5 展示
                Visibility(
                  visible: state.details.type == 3 &&
                      (state.details.status == 1 || state.details.status == 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "img/Icon/mail.png",
                        width: 20.dp,
                        height: 20.dp,
                      ),
                      SizedBox(width: 8.dp),
                      Text(
                        "招募中",
                        style: TextStyle(
                          fontSize: 22.dp,
                          color: paleGreenColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.dp),

                /// 地点
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    state.details.address,
                    style: TextStyle(
                      fontSize: 20.dp,
                      color: darkGreyColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),

                /// 时间
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    state.details.createTime,
                    style: TextStyle(
                      fontSize: 20.dp,
                      color: darkGreyColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),

                SizedBox(height: 40.dp),

                /// 所需圈达币
                Visibility(
                  visible: state.details.type == 4 || state.details.type == 3,
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            '${state.details.type == 3 ? "该任务可赚圈达币" : "该闲置需要圈达币"}：',
                        style: TextStyle(fontSize: 24.dp, color: greyColor),
                        children: <TextSpan>[
                          TextSpan(
                            text: state.details.payMoney.toString(),
                            style: const TextStyle(color: orange),
                          ),
                          const TextSpan(text: '  个'),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.dp),

                /// 闲置类型  可购买  如果查看的是自己的发布  不显示
                Visibility(
                  visible: state.details.type == 4 &&
                      state.details.buyStatus &&
                      state.userInfo.userId != state.details.userId,
                  child: GestureDetector(
                    onTap: getLogic.goToConfirmOrder,
                    child: Container(
                      height: 96.dp,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("img/Icon/purchase_button.png"),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "我要这个闲置",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                /// 闲置类型  不可购买  如果查看的是自己的发布  不显示
                Visibility(
                  visible: state.details.type == 4 &&
                      !state.details.buyStatus &&
                      state.userInfo.userId != state.details.userId,
                  child: Container(
                    height: 96.dp,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(48, 55, 56, 1),
                      borderRadius: BorderRadius.circular(48.dp),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "已被其他人抢走",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                /// 任务类型  可接任务  如果查看的是自己的发布  不显示
                Visibility(
                  visible: state.details.type == 3 &&
                      state.details.repayShortNumber != 0 &&
                      state.userInfo.userId != state.details.userId,
                  child: GestureDetector(
                    onTap: getLogic.openTips,
                    child: Container(
                      height: 96.dp,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("img/Icon/purchase_button.png"),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "当前还差${state.details.repayShortNumber}人（接下任务）",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                /// 任务类型  不可接任务  如果查看的是自己的发布  不显示
                Visibility(
                  visible: state.details.type == 3 &&
                      state.details.repayShortNumber == 0 &&
                      state.userInfo.userId != state.details.userId,
                  child: Container(
                    height: 96.dp,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(48, 55, 56, 1),
                      borderRadius: BorderRadius.circular(48.dp),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "已招募完成",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.dp),

                /// 任务类型展示
                state.details.type == 3
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          "该任务需要${state.details.personNumber}人当前已有${state.details.personNumber - (state.details.repayShortNumber ?? 0)}人报名",
                          style: TextStyle(
                            fontSize: 24.dp,
                          ),
                        ),
                      )
                    : Container(),

                /// 闲置类型展示
                state.details.type == 4 && state.userInfo.userId != state.details.userId
                    ? Align(
                        alignment: Alignment.center,
                        child: Text(
                          "若抢下该闲置但未付款致订单超时您将不能再次购买",
                          style: TextStyle(
                            fontSize: 24.dp,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),

          // Container(
          //   height: 14.dp,
          //   color: darkBlackDivider,
          // ),

          /// 评论区
          // Padding(
          //   padding: EdgeInsets.all(35.dp),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "共567条评论",
          //         style: TextStyle(
          //           fontSize: 24.dp,
          //           color: Colors.white,
          //         ),
          //       ),
          //       SizedBox(height: 35.dp),
          //       comment(),
          //     ],
          //   ),
          // ),

          SizedBox(height: 180.dp),
        ],
      ),
    );
  }
}
