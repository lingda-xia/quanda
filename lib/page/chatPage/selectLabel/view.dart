import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/model/chat/LabelEntity.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/Input_box.dart';

import 'logic.dart';

/// 选择标签页面
class SelectLabel extends StatelessWidget {
  SelectLabel({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(SelectLabelLogic());

  /// 数据层
  final state = Get.find<SelectLabelLogic>().state;

  /// 标签列表的item
  Widget labelListItem(LabelEntity item) {
    return InkWell(
      /// 点击复选框
      onTap: () => logic.onChanged(item),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.dp),
        margin: EdgeInsets.only(top: 30.dp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 标签和数量
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 30.dp,
                      ),
                    ),
                    SizedBox(height: 10.dp),
                    Text(
                      item.friendCount.toString(),
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),

                /// 复选框
                Stack(
                  children: [
                    Visibility(
                      visible: state.select == item,
                      child: Image.asset(
                        "img/Icon/check_yes.png",
                        width: 40.dp,
                        height: 40.dp,
                      ),
                    ),
                    Visibility(
                      visible: state.select != item,
                      child: Image.asset(
                        "img/Icon/check_no.png",
                        width: 40.dp,
                        height: 40.dp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.dp),

            /// 下划线
            Divider(
              height: 1.dp,
              thickness: 1.dp,
              color: lightBlackDivider,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("选择标签"),
        actions: [
          /// 确认按钮
          GetBuilder<SelectLabelLogic>(builder: (_) {
            return Visibility(
              visible: state.select.id != 0,
              child: GestureDetector(
                onTap: logic.determine,
                child: Container(
                  width: 128.dp,
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(right: 40.dp, top: 24.dp, bottom: 24.dp),
                  decoration: BoxDecoration(
                    color: paleGreenColor,
                    borderRadius: BorderRadius.circular(10.dp),
                  ),
                  child: Text(
                    "确认",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.dp,
                    ),
                  ),
                ),
              ),
            );
          })
        ],
      ),
      body: GetBuilder<SelectLabelLogic>(
        builder: (_) {
          return ListView(
            padding: EdgeInsets.all(30.dp),
            children: [
              SizedBox(height: 10.dp),
              for (int i = 0; i < state.list.length; i++)
                labelListItem(state.list[i]),
            ],
          );
        },
      ),
    );
  }
}
