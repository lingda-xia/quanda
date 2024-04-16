import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';
import '../state.dart';

/// 底部弹出框
class BottomPopup extends StatelessWidget {
  const BottomPopup({
    Key? key,
    required this.data,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final IdleOrderDetailsState data;

  /// 逻辑层
  final IdleOrderDetailsLogic logic;

  /// 弹出框的文本
  Widget popupText(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 50.dp, right: 30.dp),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 30.dp,
        ),
      ),
    );
  }

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.dp)),
      borderSide: BorderSide(
        width: 2.dp,
        color: greyColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () => Get.back(),
        behavior: HitTestBehavior.translucent,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: 650.dp,
              decoration: BoxDecoration(
                color: blackGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.dp),
                  topRight: Radius.circular(40.dp),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70.dp),

                    /// 物流方式
                    Row(
                      children: [
                        /// 弹出框的文本
                        popupText("物流方式："),

                        /// 快递配送
                        Text(
                          "快递配送",
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 28.dp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.dp),

                    /// 快递方式
                    Row(
                      children: [
                        /// 弹出框的文本
                        popupText("快递方式："),

                        /// 快递选择
                        GestureDetector(
                          onTap: logic.goToExpress,
                          child: Container(
                            height: 76.dp,
                            padding: EdgeInsets.symmetric(horizontal: 20.dp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.dp),
                                border: Border.all(
                                  color: greyColor,
                                  width: 2.dp,
                                )),
                            child: Row(
                              children: [
                                /// 快递方式
                                GetBuilder<IdleOrderDetailsLogic>(builder: (_) {
                                  return Text(
                                    data.express.expressName,
                                    style: TextStyle(
                                      color: greyColor,
                                      fontSize: 26.dp,
                                    ),
                                  );
                                }),

                                SizedBox(width: 20.dp),

                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 40.dp,
                                  color: greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40.dp),

                    /// 快递单号
                    Row(
                      children: [
                        /// 弹出框的文本
                        popupText("快递单号："),

                        /// 输入框
                        SizedBox(
                          width: 460.dp,
                          height: 76.dp,
                          child: TextField(
                            /// 控制器
                            controller: data.textController,

                            /// 最大行数
                            maxLines: 1,

                            /// 键盘类型
                            keyboardType: TextInputType.number,

                            /// 监听输入改变的时候
                            onChanged: logic.onChanged,

                            /// 输入的文本样式
                            style: TextStyle(
                              color: const Color.fromRGBO(223, 226, 235, 1),
                              fontSize: 30.dp,
                            ),

                            /// 光标颜色
                            cursorColor: const Color.fromRGBO(223, 226, 235, 1),

                            /// 将确定按钮换为搜索
                            textInputAction: TextInputAction.search,

                            /// 装饰
                            decoration: InputDecoration(
                              /// 未输入时提示的内容
                              hintText: "请输入快递单号",

                              /// 提示的文本样式
                              hintStyle: TextStyle(
                                color: greyColor,
                                fontSize: 26.dp,
                                fontFamily: "PingFang SC",
                              ),

                              /// 内边距
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.dp, vertical: 10),

                              /// 边框
                              border: _getEditBorder(),

                              /// 边框
                              enabledBorder: _getEditBorder(),

                              /// 聚焦后的边框
                              focusedBorder: _getEditBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80.dp),

                    /// 确认发货
                    GestureDetector(
                      onTap: logic.idleOrderSendGoods,
                      child: Container(
                        height: 96.dp,
                        margin: EdgeInsets.symmetric(horizontal: 30.dp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(10.dp),
                        ),
                        child: Text(
                          "确认发货",
                          style: TextStyle(
                            fontSize: 36.dp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
