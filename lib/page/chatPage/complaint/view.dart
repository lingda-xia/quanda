import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 投诉页面
class Complaint extends StatelessWidget {
  Complaint({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ComplaintLogic());

  /// 数据层
  final state = Get.find<ComplaintLogic>().state;

  /// 输入框
  Widget inputBox() {
    return Stack(
      children: [
        Container(
          height: 360.dp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.dp),
          ),

          /// 裁剪
          clipBehavior: Clip.hardEdge,
          child: TextField(
            /// 控制器
            controller: state.textController,

            /// 填充满父级元素所需要求
            maxLines: null,

            /// 填充满父级元素所需要求
            minLines: null,

            /// 是否填充满父级元素
            expands: true,

            /// 最大输入长度
            maxLength: 200,

            /// 监听输入改变的时候
            onChanged: logic.onSearch,

            /// 输入的文本样式
            style: TextStyle(
              color: themeWhite,
              fontSize: 30.dp,
            ),

            /// 光标颜色
            cursorColor: themeWhite,

            /// 将确定按钮换为完成
            textInputAction: TextInputAction.done,

            /// 装饰
            decoration: InputDecoration(
              /// 未输入时提示的内容
              hintText: "请描述您的问题...",

              /// 提示的文本样式
              hintStyle: TextStyle(
                color: greyColor,
                fontSize: 28.dp,
                fontFamily: "PingFang SC",
              ),

              /// 内边距
              contentPadding: EdgeInsets.all(30.dp),

              /// 计数文本样式
              counterStyle: const TextStyle(color: Colors.transparent),

              /// 是否填充
              filled: true,

              /// 类似背景颜色
              fillColor: blackGrey,

              /// 边框
              border: InputBorder.none,
            ),
          ),
        ),
        Positioned(
          right: 30.dp,
          bottom: 60.dp,
          child: Text(
            "200字以内",
            style: TextStyle(
              color: const Color.fromRGBO(153, 153, 153, 1),
              fontSize: 24.dp,
            ),
          ),
        ),
      ],
    );
  }

  /// 分类标签Item
  Widget itemBuilder(int index) {
    return GestureDetector(
      onTap: () => logic.updateCheck(index),
      child: Container(
        width: 200.dp,
        height: 64.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.dp),
          color: state.labelList[index].isCheck ? paleGreenColor : blackGrey,
        ),
        child: Text(
          state.labelList[index].title,
          style: TextStyle(
            fontSize: 26.dp,
            color: state.labelList[index].isCheck ? Colors.white : greyColor,
          ),
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
        title: const Text("投诉"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.dp),
        child: ListView(
          children: [
            /// 分类标签
            Text(
              "分类标签",
              style: TextStyle(
                fontSize: 36.dp,
              ),
            ),
            SizedBox(height: 30.dp),

            /// 分类标签列表
            GetBuilder<ComplaintLogic>(builder: (e) {
              return Wrap(
                runSpacing: 20.dp,
                spacing: 45.dp,
                children: [
                  for (int i = 0; i < state.labelList.length; i++)
                    itemBuilder(i),
                ],
              );
            }),

            SizedBox(height: 60.dp),

            /// 简单描述
            Text(
              "简单描述",
              style: TextStyle(
                fontSize: 36.dp,
              ),
            ),
            SizedBox(height: 30.dp),

            /// 输入框
            inputBox(),

            SizedBox(height: 120.dp),

            /// 提交按钮
            SizedBox(
              width: double.infinity,
              height: 96.dp,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(paleGreenColor), //背景颜色
                  side: MaterialStateProperty.all(BorderSide.none), //边框
                ),
                onPressed: () {},
                child: Text(
                  "提交",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.dp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
