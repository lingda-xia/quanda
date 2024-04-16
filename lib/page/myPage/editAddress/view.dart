import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 编辑地址页面
class EditAddress extends StatelessWidget {
  EditAddress({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(EditAddressLogic());

  /// 数据层
  final state = Get.find<EditAddressLogic>().state;

  /// 底部区域
  Widget bottomArea() {
    return GestureDetector(
      onTap: logic.userDeliverySave,
      child: Container(
        height: 96.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.dp),
          color: paleGreenColor,
        ),
        child: Text(
          "确认",
          style: TextStyle(fontSize: 36.dp, color: Colors.white),
        ),
      ),
    );
  }

  /// 输入区域
  Widget itemBox(String title, String tips, TextEditingController controller,
      AParameterCallback<String> onChange) {
    return Row(
      children: [
        SizedBox(
          width: 190.dp,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30.dp,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            /// 控制器
            controller: controller,
            minLines: 1,

            maxLines: 4,

            /// 监听输入改变的时候
            onChanged: onChange,

            /// 输入的文本样式
            style: TextStyle(
              color: greyColor,
              fontSize: 26.dp,
            ),

            /// 光标颜色
            cursorColor: themeWhite,

            /// 装饰
            decoration: InputDecoration(
              /// 未输入时提示的内容
              hintText: tips,

              /// 提示的文本样式
              hintStyle: TextStyle(
                color: const Color.fromRGBO(118, 122, 134, 1),
                fontSize: 26.dp,
                fontFamily: "PingFang SC",
              ),

              /// 边框
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  /// 选择地区
  Widget selectRegion(BuildContext context) {
    return GestureDetector(
      onTap: () => logic.selectCity(context),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: 90.dp,
        child: Row(
          children: [
            SizedBox(
              width: 190.dp,
              child: Text(
                "所在地区",
                style: TextStyle(
                  fontSize: 30.dp,
                ),
              ),
            ),
            Expanded(
              child: Text(
                state.areaAddress,
                style: TextStyle(
                  fontSize: 26.dp,
                  color: greyColor,
                ),
              ),
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
        title: const Text("编辑地址"),

        /// 右侧区域
        actions: [
          GestureDetector(
            onTap: () => {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 30.dp),
              child: Text(
                "···",
                style: TextStyle(
                  fontSize: 60.dp,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.dp),
            children: [
              /// 地址编辑区域
              Container(
                padding: EdgeInsets.only(left: 40.dp, right: 50.dp),
                decoration: BoxDecoration(
                  color: blackGrey,
                  borderRadius: BorderRadius.circular(14.dp),
                ),
                child: GetBuilder<EditAddressLogic>(
                  builder: (_) {
                    return Column(
                      children: [
                        SizedBox(height: 40.dp),
                        itemBox("收货人", "请填写名称", state.nController,
                            logic.contactChange),
                        itemBox("联系电话", "请填写联系电话", state.pController,
                            logic.phoneChange),

                        /// 选择地区
                        selectRegion(context),

                        itemBox("详细地址", "请填写详细地址", state.aController,
                            logic.addressChange),
                        SizedBox(height: 40.dp),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 30.dp),

              /// 设为默认
              Container(
                height: 96.dp,
                padding: EdgeInsets.symmetric(horizontal: 30.dp),
                decoration: BoxDecoration(
                  color: blackGrey,
                  borderRadius: BorderRadius.circular(14.dp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "设为默认",
                      style: TextStyle(
                        fontSize: 30.dp,
                      ),
                    ),

                    /// 开关
                    GetBuilder<EditAddressLogic>(builder: (e) {
                      return CupertinoSwitch(
                        value: state.isChecked,
                        onChanged: logic.onChanged,
                        activeColor: paleGreenColor,
                        trackColor: const Color.fromRGBO(63, 70, 72, 1),
                        thumbColor: Colors.white,
                      );
                    })
                  ],
                ),
              ),
            ],
          ),

          /// 底部区域
          Positioned(
            width: 690.dp,
            bottom: 80.dp,
            left: 30.dp,

            /// 底部区域
            child: bottomArea(),
          ),
        ],
      ),
    );
  }
}
