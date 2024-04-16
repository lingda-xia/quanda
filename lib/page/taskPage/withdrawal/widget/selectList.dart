import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 选择列表
class SelectList extends StatelessWidget {
  const SelectList({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  /// 数据源
  final WithdrawalState data;

  /// 点击事件
  final AParameterCallback<int> onTap;

  /// 列表的item
  Widget listItem(int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Stack(
        children: [
          /// 选项框
          Container(
            width: 182.dp,
            height: 126.dp,
            decoration: BoxDecoration(
              color: blackGrey,
              borderRadius: BorderRadius.circular(10.dp),
            ),
            alignment: Alignment.center,
            child: Text(
              "￥ ${data.amountList[index]}",
              style: TextStyle(
                fontSize: 36.dp,
                fontWeight: FontWeight.bold,
                fontFamily: "Rany",
              ),
            ),
          ),

          /// 选中框
          Visibility(
            visible: data.selectIndex == index,
            child: Image.asset(
              "img/bigIcon/selectAmount.png",
              width: 182.dp,
              height: 126.dp,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 标题
          Text(
            "选择金额",
            style: TextStyle(
              fontSize: 36.dp,
            ),
          ),
          SizedBox(height: 50.dp),
          GetBuilder<WithdrawalLogic>(builder: (e) {
            return Wrap(
              runSpacing: 36.dp,
              spacing: 40.dp,
              children: [
                for (int i = 0; i < data.amountList.length; i++) listItem(i)
              ],
            );
          }),
        ],
      ),
    );
  }
}
