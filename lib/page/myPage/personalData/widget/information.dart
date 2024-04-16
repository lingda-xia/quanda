import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';
import '../state.dart';

/// 个人信息
class Information extends StatelessWidget {
  const Information({
    Key? key,
    required this.state,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final PersonalDataState state;

  /// 逻辑层
  final PersonalDataLogic logic;

  /// 每一列的信息  不可输入的
  Widget line(String title, String info) {
    return Column(
      children: [
        SizedBox(height: 32.dp),
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
            const Expanded(child: SizedBox()),

            /// 约束框
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 454.dp,
              ),
              child: Text(
                info,
                style: TextStyle(
                  fontSize: 28.dp,
                  color: greyColor,
                ),
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
        SizedBox(height: 32.dp),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(34, 41, 43, 1),
        ),
      ],
    );
  }

  /// 名字输入
  Widget name() {
    return Column(
      children: [
        SizedBox(height: 15.dp),
        Row(
          children: [
            Text(
              "昵称",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),

            const Expanded(child: SizedBox()),

            /// 输入框
            SizedBox(
              width: 450.dp,
              height: 75.dp,
              child: TextField(
                /// 控制器
                controller: state.nController,

                minLines: 1,

                maxLength: 8,

                textAlign: TextAlign.end,

                /// 监听输入改变的时候
                onChanged: logic.nameChange,

                /// 输入的文本样式
                style: TextStyle(
                  color: greyColor,
                  fontSize: 28.dp,
                ),

                /// 光标颜色
                cursorColor: themeWhite,

                /// 装饰
                decoration: InputDecoration(
                  /// 未输入时提示的内容
                  hintText: "请输入名称",

                  /// 提示的文本样式
                  hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 28.dp,
                    fontFamily: "PingFang SC",
                  ),

                  /// 输入字数的文本
                  counterText: "",

                  /// 边框
                  border: InputBorder.none,
                ),
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
        SizedBox(height: 15.dp),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(34, 41, 43, 1),
        ),
      ],
    );
  }

  /// 简介输入
  Widget introduction() {
    return Column(
      children: [
        SizedBox(height: 6.dp),
        Row(
          children: [
            Text(
              "简介",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),

            const Expanded(child: SizedBox()),

            /// 输入框
            SizedBox(
              width: 450.dp,
              child: TextField(
                /// 控制器
                controller: state.jController,

                minLines: 1,

                maxLines: 4,

                /// 监听输入改变的时候
                onChanged: logic.onChange,

                /// 输入的文本样式
                style: TextStyle(
                  color: greyColor,
                  fontSize: 28.dp,
                ),

                /// 光标颜色
                cursorColor: themeWhite,

                /// 装饰
                decoration: InputDecoration(
                  /// 未输入时提示的内容
                  hintText: "请输入简介",

                  /// 提示的文本样式
                  hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 28.dp,
                    fontFamily: "PingFang SC",
                  ),

                  /// 边框
                  border: InputBorder.none,
                ),
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

        SizedBox(height: 6.dp),

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
      padding: EdgeInsets.symmetric(horizontal: 30.dp),
      decoration: BoxDecoration(
        color: blackGrey,
        borderRadius: BorderRadius.circular(14.dp),
      ),
      child: GetBuilder<PersonalDataLogic>(
        builder: (_) {
          return Column(
            children: [
              /// 昵称
              name(),
              line("性别", state.info.sex == 1 ? "男" : "女"),
              line("年龄", state.info.age.toString()),
              line("生日", state.info.birthday),
              /// 简介
              introduction(),
            ],
          );
        },
      ),
    );
  }
}
