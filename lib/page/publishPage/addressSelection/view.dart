import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';
import 'state.dart';

/// 地址选择 页面
class AddressSelect extends StatelessWidget {
  AddressSelect({Key? key}) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AddressSelectLogic());

  /// 数据层
  final state = Get.find<AddressSelectLogic>().state;

  /// 地址输入框
  Widget titleInput(BuildContext context) {
    return Stack(
      children: [
        /// 输入框
        Container(
          height: 76.dp,
          margin: EdgeInsets.symmetric(horizontal: 30.dp),
          child: TextField(
            minLines: 1,

            /// 监听输入改变的时候
            onChanged: logic.inputChange,

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
              hintText: "输入地址",

              /// 提示的文本样式
              hintStyle: TextStyle(
                color: darkGreyColor,
                fontSize: 30.dp,
                fontFamily: "PingFang SC",
              ),

              /// 内边距
              contentPadding: EdgeInsets.only(left: 150.dp, right: 30.dp),

              /// 是否填充
              filled: true,

              /// 填充的颜色  类似背景颜色
              fillColor: blackGrey,

              /// 边框
              focusedBorder: _getEditBorder(),

              /// 边框
              enabledBorder: _getEditBorder(),
            ),
          ),
        ),

        /// 城市选择
        Positioned(
          height: 76.dp,
          top: 0.dp,
          left: 50.dp,
          child: GestureDetector(
            onTap: () => logic.selectCity(context),
            behavior: HitTestBehavior.translucent,
            child: Row(
              children: [
                /// 市
                GetBuilder<AddressSelectLogic>(builder: (e) {
                  return SizedBox(
                    width: 80.dp,
                    child: Text(
                      state.selectCity,
                      style: TextStyle(
                        fontSize: 26.dp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
                Icon(
                  Icons.arrow_drop_down,
                  size: 45.dp,
                  color: themeWhite,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 列表item
  Widget listItem(int i) {
    return GestureDetector(
      onTap: () => logic.selectItem(state.searchList[i]),
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(top: 20.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.searchList[i].name),
            SizedBox(height: 12.dp),
            Text(
              state.searchList[i].district + state.searchList[i].address,
              style: TextStyle(
                color: darkGreyColor,
                fontSize: 26.dp,
              ),
            ),
            SizedBox(height: 20.dp),
            /// 下划线
            Divider(
              height: 1.dp,
              thickness: 1.dp,
              color: const Color.fromRGBO(44, 48, 47, 1),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(38.dp)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("地址选择"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            /// 标题输入框
            titleInput(context),
            SizedBox(height: 30.dp),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.dp),
                child: GetBuilder<AddressSelectLogic>(builder: (e) {
                  return ListView(
                    children: [
                      for (int i = 0; i < state.searchList.length; i++)
                        listItem(i)
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
