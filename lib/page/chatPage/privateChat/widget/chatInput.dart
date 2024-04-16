import 'package:flutter/material.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';
import '../state.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({
    Key? key,
    required this.data,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final PrivateChatState data;

  /// 逻辑层
  final PrivateChatLogic logic;

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(40.dp)),
      borderSide: BorderSide(
        width: 1.dp,
        color: const Color.fromRGBO(50, 53, 62, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 80.dp,top: 20.dp),
      padding: EdgeInsets.symmetric(horizontal: 30.dp),
      child: Row(
        children: [
          SizedBox(
            width: 520.dp,
            height: 80.dp,
            child: TextField(

              /// 控制器
              controller: data.textController,

              /// 最大行数
              maxLines: 1,

              /// 焦点控制
              focusNode: data.focusNode,

              /// 监听输入改变的时候
              onChanged: logic.onInput,

              onTap: () {
                logic.jumpTo(0);
              },

              /// 当按下键盘的发送按钮时触发
              onSubmitted: (value) {
                /// 发送消息
                logic.sendTextMessage();
              },

              /// 输入的文本样式
              style: TextStyle(
                color: const Color.fromRGBO(223, 226, 235, 1),
                fontSize: 30.dp,
              ),

              /// 光标颜色
              cursorColor: const Color.fromRGBO(223, 226, 235, 1),

              /// 将确定按钮换为发送
              textInputAction: TextInputAction.send,

              /// 装饰
              decoration: InputDecoration(
                /// 未输入时提示的内容
                hintText: "点击输入文字",

                /// 提示的文本样式
                hintStyle: TextStyle(
                  color: const Color.fromRGBO(132, 132, 142, 1),
                  fontSize: 30.dp,
                  fontFamily: "PingFang SC",
                ),

                /// 内边距
                contentPadding: EdgeInsets.symmetric(horizontal: 45.dp, vertical: 0),

                /// 是否填充
                filled: true,

                /// 填充的颜色  类似背景颜色
                fillColor: const Color.fromRGBO(28, 34, 36, 1),

                /// 边框
                border: _getEditBorder(),

                enabledBorder: _getEditBorder(),

                focusedBorder: _getEditBorder(),

              ),
            ),
          ),
          SizedBox(width: 20.dp),
          /// 发送按钮
          GestureDetector(
            onTap: logic.sendImageMessage,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.dp),
              alignment: Alignment.center,
              child: Image.asset(
                "img/Icon/send.png",
                width: 80.dp,
                height: 80.dp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

