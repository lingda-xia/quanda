import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/task/RecommendTask.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 推荐任务
class RecommendTasks extends StatelessWidget {
  const RecommendTasks({
    Key? key,
    required this.data,
  }) : super(key: key);

  /// 数据源
  final TaskState data;

  /// 列表item
  Widget listItem(RecommendTask item) {
    return Column(
      children: [
        SizedBox(height: 20.dp),
        Row(
          children: [
            /// 需求和数量
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 440.dp,
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10.dp),
                SizedBox(
                  width: 322.dp,
                  child: Text(
                    item.content,
                    style: TextStyle(
                      fontSize: 24.dp,
                      color: greyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 15.dp),

                /// 距离
                Container(
                  width: 118.dp,
                  height: 34.dp,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(53, 59, 60, 1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(14.dp),
                      topLeft: Radius.circular(14.dp),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    item.distance,
                    style: TextStyle(
                      fontSize: 20.dp,
                    ),
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              children: [
                /// 任务得到的奖励
                Row(
                  children: [
                    Image.asset(
                      "img/Icon/jin_bi.png",
                      width: 24.dp,
                      height: 24.dp,
                    ),
                    SizedBox(width: 10.dp),
                    Text(
                      item.gold.toString(),
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: const Color.fromRGBO(247, 198, 78, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.dp),

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
                      "接任务",
                      style: TextStyle(
                        fontSize: 26.dp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.dp),

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
      child: GetBuilder<TaskLogic>(
        builder: (_) {
          return Column(
            children: [
              /// 日常任务标题
              Row(
                children: [
                  Image.asset(
                    "img/Icon/fu_jin.png",
                    width: 48.dp,
                    height: 48.dp,
                  ),
                  SizedBox(width: 15.dp),
                  Image.asset(
                    "img/Icon/zuan_qian_task.png",
                    width: 260.dp,
                    height: 34.dp,
                  ),
                ],
              ),

              SizedBox(height: 25.dp),

              for(int i = 0; i < data.recommendList.length; i++)
                listItem(data.recommendList[i]),
            ],
          );
        },
      ),

    );
  }
}
