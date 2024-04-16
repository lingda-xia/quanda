import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 账单页面
class Bill extends StatelessWidget {
  Bill({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(BillLogic());

  /// 数据层
  final state = Get.find<BillLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("账单"),
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
      body: ListView(
        children: [
          /// 组头
          Container(
            height: 76.dp,
            color: darkBlackDivider,
            padding: EdgeInsets.symmetric(horizontal: 45.dp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 月份
                Text(
                  "02月",
                  style: TextStyle(
                    fontSize: 30.dp,
                  ),
                ),
                Expanded(child: Container()),
                /// 支出和收入
                Text(
                  "支出：99",
                  style: TextStyle(
                    fontSize: 26.dp,
                  ),
                ),
                SizedBox(width: 25.dp),
                Text(
                  "收入：98",
                  style: TextStyle(
                    fontSize: 26.dp,
                  ),
                ),
              ],
            ),
          ),
          /// 列表item
          Container(
            padding: EdgeInsets.only(left: 45.dp, top: 30.dp),
            child: Column(
              children: [
                /// 来源说明和时间以及来源金额
                Row(
                  children: [
                    /// 来源说明和时间
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "任务收入",
                          style: TextStyle(
                            fontSize: 30.dp,
                          ),
                        ),
                        SizedBox(height: 10.dp),
                        Text(
                          "2028\02\02 18:26",
                          style: TextStyle(
                            fontSize: 24.dp,
                            color: darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    /// 来源金额
                    Text(
                      "+45",
                      style: TextStyle(
                        fontSize: 30.dp,
                        color: orange,
                      ),
                    ),
                    SizedBox(width: 45.dp),
                  ],
                ),
                SizedBox(height: 20.dp),
                /// 下划线
                Divider(
                  height: 1.dp,
                  thickness: 1.dp,
                  color: const Color.fromRGBO(32, 37, 36, 1),
                ),
              ],
            ),
          ),
          /// 组头
          Container(
            height: 76.dp,
            color: darkBlackDivider,
            padding: EdgeInsets.symmetric(horizontal: 45.dp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 月份
                Text(
                  "02月",
                  style: TextStyle(
                    fontSize: 30.dp,
                  ),
                ),
                Expanded(child: Container()),
                /// 支出和收入
                Text(
                  "支出：99",
                  style: TextStyle(
                    fontSize: 26.dp,
                  ),
                ),
                SizedBox(width: 25.dp),
                Text(
                  "收入：98",
                  style: TextStyle(
                    fontSize: 26.dp,
                  ),
                ),
              ],
            ),
          ),
          /// 列表item
          Container(
            padding: EdgeInsets.only(left: 45.dp, top: 30.dp),
            child: Column(
              children: [
                /// 来源说明和时间以及来源金额
                Row(
                  children: [
                    /// 来源说明和时间
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "任务收入",
                          style: TextStyle(
                            fontSize: 30.dp,
                          ),
                        ),
                        SizedBox(height: 10.dp),
                        Text(
                          "2028\02\02 18:26",
                          style: TextStyle(
                            fontSize: 24.dp,
                            color: darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    /// 来源金额
                    Text(
                      "+45",
                      style: TextStyle(
                        fontSize: 30.dp,
                        color: orange,
                      ),
                    ),
                    SizedBox(width: 45.dp),
                  ],
                ),
                SizedBox(height: 20.dp),
                /// 下划线
                Divider(
                  height: 1.dp,
                  thickness: 1.dp,
                  color: const Color.fromRGBO(32, 37, 36, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}








// import 'dart:math';
// class Bill extends StatelessWidget {
//   Bill({Key? key}) : super(key: key);
//
//   final List<Color> data = [
//     Colors.purple[50]!,
//     Colors.purple[100]!,
//     Colors.purple[200]!,
//     Colors.purple[300]!,
//     Colors.purple[400]!,
//     Colors.purple[500]!,
//     Colors.purple[600]!,
//     Colors.purple[700]!,
//     Colors.purple[800]!,
//     Colors.purple[900]!,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//       appBar: AppBar(
//         /// 回退键
//         leading: const BackButton(),
//         title: const Text("账单"),
//         /// 右侧区域
//         actions: [
//           GestureDetector(
//             onTap: () => {},
//             child: Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.only(right: 30.dp),
//               child: Text(
//                 "···",
//                 style: TextStyle(
//                   fontSize: 60.dp,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//      body:SizedBox(
//       height: 1000,
//       child: CustomScrollView(
//         slivers: <Widget>[
//           _buildPersistentHeader('袅缈岁月，青丝银发',const Color(0xffe7fcc9)),
//           _buildSliverList(),
//           _buildPersistentHeader('以梦为马，不负韶华',const Color(0xffcca4ff)),
//           _buildSliverList(),
//           _buildPersistentHeader('第三个，不负韶华',const Color(0xffcca4ff)),
//           _buildSliverList(),
//         ],
//       ),
//     ),
//         );
//   }
//
//
//   Widget _buildPersistentHeader(String text,Color color) => SliverPersistentHeader(
//       pinned: true,
//       delegate: _SliverDelegate(
//         minHeight: 40.0,
//         maxHeight: 40.0,
//         child: Container(
//             color: color,
//             child: Center(
//               child: Text(text, style: const TextStyle(
//                   fontSize: 18,
//                   shadows: [Shadow(color: Colors.white, offset: Offset(1, 1))]),
//               ),
//             )),
//       ));
//
//   Widget _buildSliverList() => SliverList(
//     delegate: SliverChildBuilderDelegate(
//             (_, int index) => Container(
//           alignment: Alignment.center,
//           width: 100,
//           height: 60,
//           color: data[index],
//           child: Text(
//             colorString(data[index]),
//             style: const TextStyle(color: Colors.white, shadows: [
//               Shadow(
//                   color: Colors.black,
//                   offset: Offset(.5, .5),
//                   blurRadius: 2)
//             ]),
//           ),
//         ),
//         childCount: data.length),
//   );
//
//   String colorString(Color color) =>
//       "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
// }
//
//
// class _SliverDelegate extends SliverPersistentHeaderDelegate {
//   _SliverDelegate({
//     required this.minHeight,
//     required this.maxHeight,
//     required this.child,
//   });
//
//   final double minHeight; //最小高度
//   final double maxHeight; //最大高度
//   final Widget child; //孩子
//
//   @override
//   double get minExtent => minHeight;
//
//   @override
//   double get maxExtent => max(maxHeight, minHeight);
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }
//
//   @override //是否需要重建
//   bool shouldRebuild(_SliverDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }