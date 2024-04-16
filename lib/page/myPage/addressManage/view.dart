import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/model/personal/ReceivingEntity.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 地址管理页面
class AddressManage extends StatelessWidget {
  AddressManage({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AddressManageLogic());

  /// 数据层
  final state = Get.find<AddressManageLogic>().state;

  /// 地址显示处理
  String handle(String value) {
    String str = "";

    List<String> list = value.split(",");

    str = list[0] + list[1] + list[2];

    return str;
  }

  /// 手机号码显示处理
  String phone(String value) {
    String str = "";

    str = value.replaceRange(3, 7, "****");

    return str;
  }

  /// 底部区域
  Widget bottomArea() {
    return GestureDetector(
      /// 前往编辑地址页面
      onTap: () => logic.goToEditAddress(),
      child: Container(
        height: 96.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.dp),
          color: paleGreenColor,
        ),
        child: Text(
          "新增收货地址",
          style: TextStyle(fontSize: 36.dp, color: Colors.white),
        ),
      ),
    );
  }

  /// 收货地址
  Widget listItem(ReceivingEntity item, int index) {
    return GestureDetector(
      onTap: () => logic.select(item.id),
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          color: blackGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.dp),
            topRight: Radius.circular(14.dp),
            bottomRight:
                Radius.circular(index == state.list.length - 1 ? 14.dp : 0),
            bottomLeft:
                Radius.circular(index == state.list.length - 1 ? 14.dp : 0),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 30.dp),

            /// 复选框
            Stack(
              children: [
                Visibility(
                  visible: item.id == state.selectId,
                  child: Image.asset(
                    "img/Icon/check_yes.png",
                    width: 40.dp,
                    height: 40.dp,
                  ),
                ),
                Visibility(
                  visible: item.id != state.selectId,
                  child: Image.asset(
                    "img/Icon/check_no.png",
                    width: 40.dp,
                    height: 40.dp,
                  ),
                ),
              ],
            ),
            SizedBox(width: 25.dp),

            /// 地址信息和个人信息
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 30.dp),
                  Row(
                    children: [
                      /// 地址和电话号码
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.address,
                              style: TextStyle(
                                fontSize: 30.dp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10.dp),
                            Text(
                              "${item.contact} ${phone(item.phone)}",
                              style: TextStyle(
                                fontSize: 26.dp,
                                color: greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 编辑地址
                      GestureDetector(
                        /// 前往编辑地址页面
                        onTap: () => logic.goToEditAddress(item.id),
                        child: Container(
                          height: 120.dp,
                          padding: EdgeInsets.only(left: 40.dp, right: 40.dp),
                          child: Image.asset(
                            "img/Icon/edit.png",
                            width: 30.dp,
                            height: 34.dp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.dp),

                  /// 下划线
                  index == state.list.length - 1
                      ? Container()
                      : Divider(
                          height: 1.dp,
                          thickness: 1.dp,
                          color: const Color.fromRGBO(34, 41, 43, 1),
                        ),
                ],
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
        title: const Text("地址管理"),

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
          /// 收货地址列表
          GetBuilder<AddressManageLogic>(builder: (_) {
            return ListView(
              padding: EdgeInsets.all(30.dp),
              children: [
                for (int i = 0; i < state.list.length; i++)
                  listItem(state.list[i], i),
              ],
            );
          }),

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
