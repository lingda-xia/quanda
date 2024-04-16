import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';
import '../state.dart';

/// 输入框
class TextFieldBox extends StatelessWidget {
  const TextFieldBox({
    Key? key,
    required this.state,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final SearchState state;

  /// 逻辑层
  final SearchLogic logic;

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(38.dp)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 输入框
    return SizedBox(
      width: 580.dp,
      height: 76.dp,
      child: TextField(

        /// 控制器
        controller: state.textController,

        /// 最大行数
        maxLines: 1,

        focusNode: state.focusNode,

        /// 监听输入改变的时候
        onChanged: logic.onChanged,

        /// 按下搜索键时
        onEditingComplete: logic.friendSearchList,

        /// 输入的文本样式
        style: TextStyle(
          color: const Color.fromRGBO(223, 226, 235, 1),
          fontSize: 32.dp,
        ),

        /// 光标颜色
        cursorColor: const Color.fromRGBO(223, 226, 235, 1),

        /// 光标的高度
        cursorHeight: 20.0,

        /// 将确定按钮换为搜索
        textInputAction: TextInputAction.search,

        /// 装饰
        decoration: InputDecoration(
          /// 未输入时提示的内容
          hintText: "圈达号/手机号/名称",

          /// 提示的文本样式
          hintStyle: TextStyle(
            color: const Color.fromRGBO(118, 122, 134, 1),
            fontSize: 24.dp,
            fontFamily: "PingFang SC",
          ),

          /// 左侧搜索图标
          prefixIcon: Icon(
            Icons.search,
            color: const Color.fromRGBO(118, 122, 134, 1),
            size: 40.dp,
          ),

          /// 内边距
          contentPadding: EdgeInsets.symmetric(horizontal: 45.dp, vertical: 5),

          /// 是否填充
          filled: true,

          /// 填充的颜色  类似背景颜色
          fillColor: const Color.fromRGBO(28, 34, 36, 1),

          /// 边框
          border: _getEditBorder(),

          /// 聚焦后的边框
          focusedBorder: _getEditBorder(),

        ),
      ),
    );
  }
}
