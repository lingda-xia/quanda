import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/publishPublic/view.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'state.dart';

/// 发布闲置 页面
class SetAside extends StatelessWidget {
  SetAside({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(SetAsideLogic());

  /// 数据层
  final state = Get.find<SetAsideLogic>().state;

  /// 价格输入框
  Widget priceInput() {
    return SizedBox(
      width: 380.dp,
      height: 70.dp,
      child: TextField(
        minLines: 1,

        controller: state.textController,

        /// 监听输入改变的时候
        onChanged: logic.priceChange,

        keyboardType: TextInputType.number,

        /// 输入的文本样式
        style: TextStyle(
          color: themeWhite,
          fontSize: 26.dp,
        ),

        /// 光标颜色
        cursorColor: themeWhite,

        /// 装饰
        decoration: InputDecoration(
          /// 未输入时提示的内容
          hintText: "想卖多少圈达币？不填表示免费",

          /// 提示的文本样式
          hintStyle: TextStyle(
            color: darkGreyColor,
            fontSize: 26.dp,
            fontFamily: "PingFang SC",
          ),

          /// 边框
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// 提取方式的item
  Widget listItem(int index) {
    return GestureDetector(
      onTap: () => logic.selectIndex(index),
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.dp),
        child: Row(
          children: [
            Stack(
              children: [
                /// 选中状态
                Visibility(
                  visible: state.extractType == index,
                  child: Container(
                    width: 24.dp,
                    height: 24.dp,
                    decoration: BoxDecoration(
                      color: paleGreenColor,
                      borderRadius: BorderRadius.circular(12.dp),
                    ),
                  ),
                ),

                /// 未选中状态
                Visibility(
                  visible: state.extractType != index,
                  child: Container(
                    width: 24.dp,
                    height: 24.dp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.dp),
                        border: Border.all(
                          width: 3.dp,
                          color: greyColor,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.dp),

            /// 提取方式
            Text(
              state.extractList[index],
              style: TextStyle(
                color: greyColor,
                fontSize: 26.dp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 提货地址
  Widget address() {
    return Visibility(
      visible: state.extractType == 0,
      child: GestureDetector(
        onTap: logic.goToAddressManage,
        behavior: HitTestBehavior.translucent,
        child: Row(
          children: [
            const Text("提货地址："),
            const Expanded(child: SizedBox()),

            /// 是否选择了地址
            state.address.id == 0
                ? Image.asset(
                    "img/Icon/addAddress.png",
                    width: 50.dp,
                    height: 50.dp,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${state.address.contact} ${phone()}",
                        style: TextStyle(
                          fontSize: 26.dp,
                        ),
                      ),
                      SizedBox(height: 10.dp),
                      Text(
                        state.address.areaAddress,
                        style: TextStyle(
                          fontSize: 22.dp,
                          color: greyColor,
                        ),
                      ),
                      SizedBox(height: 4.dp),
                      Text(
                        state.address.address,
                        style: TextStyle(
                          fontSize: 22.dp,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),

            SizedBox(width: 40.dp),

            Image.asset(
              "img/Icon/right.png",
              width: 16.dp,
              height: 26.dp,
            ),
          ],
        ),
      ),
    );
  }

  /// 手机号码显示处理
  String phone() {
    String str = "";

    str = state.address.phone.replaceRange(3, 7, "****");

    return str;
  }

  @override
  Widget build(BuildContext context) {
    /// 发布公用部分  自定义widget
    return PublishPublic(
      /// 发布
      release: (title, content, address, location, idList) =>
          logic.release(title, content, address, location, idList),

      /// 保存草稿
      saveDraft: (title, content, address, location, galleryItem, status) =>
          logic.saveDraft(
              title, content, address, location, galleryItem, status),

      /// 是否打开使用草稿对话框
      initDialog: () => logic.initDialog(),

      /// 使用草稿时为父组件设置参数
      setContent: (value) => logic.setContent(value),

      children: [
        SizedBox(height: 10.dp),

        /// 出售价格
        GestureDetector(
          onTap: () => {},
          child: Row(
            children: [
              /// 圈达币
              Image.asset(
                "img/Icon/GoldCoin.png",
                width: 30.dp,
                height: 30.dp,
              ),

              SizedBox(width: 8.dp),
              Text(
                "出售价格",
                style: TextStyle(
                  color: greyColor,
                  fontSize: 26.dp,
                ),
              ),
              const Expanded(child: SizedBox()),

              /// 价格输入框
              priceInput(),

              Image.asset(
                "img/Icon/right.png",
                width: 14.dp,
                height: 24.dp,
              ),
            ],
          ),
        ),

        SizedBox(height: 10.dp),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        SizedBox(height: 30.dp),

        /// 提取方式
        Row(
          children: [
            Image.asset(
              "img/Icon/extract.png",
              width: 26.dp,
              height: 30.dp,
            ),
            SizedBox(width: 10.dp),
            Text(
              "提取方式",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
          ],
        ),

        /// 选择提取方式
        GetBuilder<SetAsideLogic>(builder: (e) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < state.extractList.length; i++) listItem(i)
            ],
          );
        }),

        SizedBox(height: 30.dp),

        /// 提货地址 选择上门自提显示
        GetBuilder<SetAsideLogic>(builder: (_) {
          return state.extractType == 0 ? address() : Container();
        }),
      ],
    );
  }
}
