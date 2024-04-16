import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'state.dart';
import 'widget/DailyTasks.dart';
import 'widget/recommendTask.dart';

/// 任务 页面
class Task extends StatelessWidget {
  Task({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  late TaskLogic logic;

  /// 数据层
  late TaskState state;

  /// 头部内容
  Widget head() {
    return SizedBox(
      height: 410.dp,
      child: Stack(
        children: [
          /// 背景图
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 530.dp,
              height: 410.dp,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/Icon/task_bg.png"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            top: 142.dp,
            left: 0,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.dp),
              child: Column(
                children: [
                  /// 收益说明 现金收益
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("现金收益(元)"),

                      /// 收益说明
                      GestureDetector(
                        onTap: () => logic.goToIncomeStatement(),
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Image.asset(
                                "img/Icon/wenhao.png",
                                width: 28.dp,
                                height: 28.dp,
                              ),
                              SizedBox(width: 6.dp),
                              Text(
                                "收益说明",
                                style: TextStyle(
                                  fontSize: 24.dp,
                                  color: paleGreenColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.dp),

                  /// 提现和收益记录
                  Row(
                    children: [
                      GetBuilder<TaskLogic>(builder: (_) {
                        return Text(
                          state.data.balance.toString(),
                          style: TextStyle(fontSize: 60.dp, fontFamily: "Rany"),
                        );
                      }),

                      SizedBox(width: 2.dp),
                      Text(
                        "元",
                        style: TextStyle(
                          fontSize: 24.dp,
                          height: 2.6,
                        ),
                      ),

                      const Expanded(child: SizedBox()),

                      /// 提现按钮
                      GestureDetector(
                        onTap: () => logic.goToWithdrawal(),
                        child: Container(
                          width: 138.dp,
                          height: 60.dp,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("img/bigIcon/GradientBox.png"),
                            ),
                          ),
                          child: Text(
                            "提现",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.dp,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 22.dp),

                      /// 金币收益
                      GestureDetector(
                        onTap: () => logic.goToGoldIncome(),
                        child: Container(
                          width: 138.dp,
                          height: 60.dp,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("img/bigIcon/GradientBor.png"),
                            ),
                          ),
                          child: Text(
                            "金币收益",
                            style: TextStyle(
                              color: const Color.fromRGBO(155, 208, 114, 1),
                              fontSize: 24.dp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 60.dp),

                  /// 金币和提示
                  Row(
                    children: [
                      Image.asset(
                        "img/Icon/jin_bi.png",
                        width: 34.dp,
                        height: 34.dp,
                      ),
                      SizedBox(width: 10.dp),
                      GetBuilder<TaskLogic>(builder: (_) {
                        return Text(
                          state.data.gold.toString(),
                          style: TextStyle(
                            fontSize: 36.dp,
                            fontFamily: "Rany",
                          ),
                        );
                      }),
                      SizedBox(width: 8.dp),
                      Text(
                        "金币",
                        style: TextStyle(
                          fontSize: 36.dp,
                        ),
                      ),
                      SizedBox(width: 10.dp),
                      Text(
                        "（每天7点自动转换成现金）",
                        style: TextStyle(
                          fontSize: 24.dp,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// 下划线
          Positioned(
            top: 340.dp,
            width: Get.width,
            child: Divider(
              height: 1.dp,
              thickness: 1.dp,
              color: const Color.fromRGBO(44, 48, 47, 1),
            ),
          ),
        ],
      ),
    );
  }

  /// 签到部分
  Widget sign() {
    /// 签到背景
    return Container(
      height: 520.dp,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("img/bigIcon/sign_bg.png"))),
      child: Column(
        children: [
          SizedBox(height: 125.dp),

          /// 时间
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "签到5天必得5元",
                style: TextStyle(
                  fontSize: 36.dp,
                ),
              ),
              SizedBox(width: 4.dp),

              /// 限时
              GetBuilder<TaskLogic>(builder: (_) {
                return Container(
                  width: 138.dp,
                  height: 40.dp,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/Icon/time_box.png"))),
                  alignment: Alignment.center,
                  child: Text(
                    "限${state.timeLimit}",
                    style: TextStyle(
                      fontSize: 22.dp,
                    ),
                  ),
                );
              })
            ],
          ),

          SizedBox(height: 50.dp),

          /// 签到列表
          GetBuilder<TaskLogic>(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < state.signList.length; i++)
                  Container(
                    width: 98.dp,
                    height: 125.dp,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/bigIcon"
                            "${state.signList[i]?.status == 2 ? "sign_success" : "sign_no"}.png"),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 5.dp),
                        Text(
                          state.signTitle[i],
                          style: TextStyle(
                            fontSize: 20.dp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 60.dp),
                        Text(
                          state.signList[i]?.status == 2 ? "已签到" : "待签到",
                          style: TextStyle(
                            fontSize: 20.dp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),

          SizedBox(height: 40.dp),

          /// 立即签到
          GestureDetector(
            onTap: logic.signRedPackage,
            child: Container(
              width: 280.dp,
              height: 82.dp,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("img/Icon/li_ji.png"))),
              child: const Text(
                "立即签到",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 逻辑层
    logic = Get.put(TaskLogic());

    /// 数据层
    state = Get.find<TaskLogic>().state;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 头部内容
            head(),
            SizedBox(height: 45.dp),

            /// 主体内容
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.dp),
              child: Column(
                children: [
                  /// 签到部分  如果为空说明签到已经过期了
                  state.signList.isNotEmpty ? sign() : Container(),
                  SizedBox(height: 30.dp),

                  /// 体验提现
                  GetBuilder<TaskLogic>(builder: (_) {
                    return state.data.firstCashMoney == 0
                        ? Container()
                        : GestureDetector(
                            onTap: () => {},
                            child: Container(
                              height: 142.dp,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "${RequestApi.imgBaseUrl}poster_bg.png"),
                                ),
                              ),
                            ),
                          );
                  }),

                  SizedBox(height: 30.dp),

                  /// 日常任务
                  DailyTasks(
                    data: state,
                  ),

                  SizedBox(height: 30.dp),

                  /// 推荐任务
                  RecommendTasks(
                    data: state,
                  ),

                  SizedBox(height: 200.dp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
