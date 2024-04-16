import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 通讯录功能区域
class Functional extends StatelessWidget {
  const Functional(
      {Key? key, required this.functionalList, required this.onTap})
      : super(key: key);

  /// 功能区域列表
  final List<FunctionalInfo> functionalList;

  /// 点击跳转事件
  final AParameterCallback onTap;

  /// 功能区域单个Item
  Widget functionalItem(FunctionalInfo viewInfo) {
    return GestureDetector(
      onTap: () => onTap(viewInfo.goToPage),
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 335.dp,
        padding: EdgeInsets.symmetric(vertical: 10.dp, horizontal: 30.dp),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(28, 34, 36, 1),
          borderRadius: BorderRadius.circular(10.dp),
        ),
        child: Row(
          children: [
            Stack(
              /// 不裁剪超出的部分
              clipBehavior: Clip.none,
              children: [
                CachedImage(
                  imgUrl: viewInfo.imgUrl,
                  width: 68.dp,
                  height: 68.dp,
                ),

                // /// 红点
                // GetBuilder<MailListLogic>(
                //   builder: (logic) {
                //     /// 是否隐藏红点
                //     return Visibility(
                //       /// 根据是否为空隐藏或显示
                //       visible: true,
                //
                //       /// 定位搜索图标
                //       child: Positioned(
                //         top: -4.dp,
                //         right: -4.dp,
                //         child: Container(
                //           width: 20.dp,
                //           height: 20.dp,
                //           decoration: BoxDecoration(
                //             color: const Color.fromRGBO(255, 77, 96, 1),
                //             borderRadius: BorderRadius.circular(10.dp),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
            SizedBox(width: 30.dp),

            /// 内容部分
            Text(
              viewInfo.textInfo,
              style: TextStyle(
                fontSize: 30.dp,
                fontFamily: "PingFang SC",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      /// 左右边距
      spacing: 20.dp,

      /// 上下边距
      runSpacing: 20.dp,
      children: [
        for (FunctionalInfo item in functionalList) functionalItem(item)
      ],
    );
  }
}
