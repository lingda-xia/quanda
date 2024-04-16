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
  final MyWalletState data;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 金币图标和金额
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// 圈达币
                    Image.asset(
                      "img/Icon/GoldCoin.png",
                      width: 30.dp,
                      height: 30.dp,
                    ),
                    SizedBox(width: 5.dp),
                    Text(
                      data.amountList[index],
                      style: TextStyle(
                        fontSize: 36.dp,
                        fontFamily: "Rany",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.dp),

                /// 所需金额
                Text(
                  "${data.amountList[index]}元",
                  style: TextStyle(
                    fontSize: 24.dp,
                    color: greyColor,
                    fontFamily: "Rany",
                  ),
                ),
              ],
            ),
          ),
          /// 选中框
          Visibility(
            visible: data.selectIndex == index,
            child: CachedImage(
               imgUrl: "${RequestApi.imgBaseUrl}selectAmount.png",
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
          GetBuilder<MyWalletLogic>(builder: (e) {
            return Text(
              data.statusValue ? "充值金额" : "提现金额",
              style: TextStyle(
                fontSize: 36.dp,
              ),
            );
          }),
          SizedBox(height: 50.dp),
          GetBuilder<MyWalletLogic>(builder: (e) {
            return Wrap(
              runSpacing: 36.dp,
              spacing: 40.dp,
              children: [
                for(int i = 0; i < data.amountList.length; i++)
                  listItem(i)
              ],
            );
          }),
        ],
      ),
    );
  }
}
