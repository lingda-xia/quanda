import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/task/DailyTask.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 日常任务
class DailyTasks extends StatelessWidget {
  const DailyTasks({
    Key? key,
    required this.data,
  }) : super(key: key);

  /// 数据源
  final TaskState data;

  /// 列表item
  Widget listItem(DailyTask item, int i) {
    return Column(
      children: [
        SizedBox(height: 35.dp),
        Row(
          children: [
            /// 需求和数量
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.dailyTaskTitle[i]),
                SizedBox(height: 18.dp),
                Text(
                  "每日可领${item.count}次（${item.number}/${item.count}）",
                  style: TextStyle(
                    fontSize: 24.dp,
                    color: greyColor,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Image.asset(
              "img/Icon/jin_bi.png",
              width: 24.dp,
              height: 24.dp,
            ),
            SizedBox(width: 10.dp),
            Text(
              "${item.gold}金币",
              style: TextStyle(
                fontSize: 24.dp,
                color: const Color.fromRGBO(247, 198, 78, 1),
              ),
            ),
            SizedBox(width: 25.dp),

            /// 领取
            GestureDetector(
              onTap: () => {},
              child: Container(
                width: 140.dp,
                height: 66.dp,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/Icon/ling_qu.png"))),
                alignment: Alignment.center,
                child: Text(
                  data.tips[i],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.dp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 35.dp),

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.dp),
          topLeft: Radius.circular(20.dp),
        ),
        color: blackGrey,
      ),
      padding: EdgeInsets.all(35.dp),
      child: GetBuilder<TaskLogic>(builder: (_) {
        return Column(
          children: [
            /// 日常任务标题
            Row(
              children: [
                Image.asset(
                  "img/Icon/rcrw.png",
                  width: 48.dp,
                  height: 48.dp,
                ),
                SizedBox(width: 15.dp),
                Image.asset(
                  "img/Icon/rcrw_text.png",
                  width: 148.dp,
                  height: 36.dp,
                ),
              ],
            ),

            SizedBox(height: 10.dp),

            for (int i = 0; i < data.dailyTaskList.length; i++)
              listItem(data.dailyTaskList[i], i),
          ],
        );
      }),
    );
  }
}
