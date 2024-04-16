import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 选择名称 页面
class ChooseName extends StatelessWidget {
  ChooseName({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ChooseNameLogic());

  /// 数据层
  final state = Get.find<ChooseNameLogic>().state;

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(45.dp)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 30.dp, top: 30.dp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.dp),
                child: Text(
                  "起个名字吧",
                  style: TextStyle(
                    fontSize: 60.dp,
                  ),
                ),
              ),
              SizedBox(height: 20.dp),
              Padding(
                padding: EdgeInsets.only(left: 30.dp),
                child: Text(
                  "名字可以多次修改哦~",
                  style: TextStyle(
                    fontSize: 28.dp,
                  ),
                ),
              ),
              SizedBox(height: 100.dp),

              Stack(
                children: [
                  /// 输入框
                  SizedBox(
                    height: 90.dp,
                    child: TextField(

                      /// 焦点控制
                      focusNode: state.focusNode,

                      /// 监听输入改变
                      onChanged: logic.change,
                      /// 最大个数
                      maxLength: 8,

                      /// 输入的文本样式
                      style: TextStyle(
                        color: themeWhite,
                        fontSize: 30.dp,
                      ),

                      /// 光标颜色
                      cursorColor: themeWhite,

                      /// 装饰
                      decoration: InputDecoration(
                        /// 未输入时提示的内容
                        hintText: "起个好听的名字吧~",

                        /// 提示的文本样式
                        hintStyle: TextStyle(
                          color: const Color.fromRGBO(187, 187, 187, 1),
                          fontSize: 30.dp,
                        ),

                        counterText: "",

                        /// 内边距
                        contentPadding: EdgeInsets.symmetric(horizontal: 45.dp),

                        /// 是否填充
                        filled: true,

                        /// 填充的颜色  类似背景颜色
                        fillColor: blackGrey,

                        /// 聚焦后的边框
                        focusedBorder: _getEditBorder(),
                        enabledBorder: _getEditBorder(),
                      ),

                    ),
                  ),

                  Positioned(
                    top: 24.dp,
                    right: 50.dp,
                    child: Text(
                      "8字",
                      style: TextStyle(
                        fontSize: 30.dp,
                        color: const Color.fromRGBO(187, 187, 187, 1),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 60.dp),

              /// 下一步
              GestureDetector(
                onTap: () => logic.confirm(),
                child: Container(
                  height: 96.dp,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/Icon/login_button.png")),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "确认",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.dp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 100.dp),
            ],
          ),
        ),
      ),
    );
  }
}
