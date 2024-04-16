import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 列表的item
class ItemBox extends StatelessWidget {
  const ItemBox({
    Key? key,
    required this.data,
    required this.onTap,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final GiftsState data;

  /// 逻辑层
  final GiftsLogic logic;

  /// 点击事件
  final NoParameterCallback onTap;

  /// 背景按钮
  Widget bgButton(String title) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: 106.dp,
        height: 54.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: paleGreenColor,
          borderRadius: BorderRadius.circular(27.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.dp,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.dp),
      margin: EdgeInsets.only(bottom: 20.dp),
      child: Row(
        children: [
          /// 头像
          CircleAvatar(
            radius: 55.dp,

            /// 为加载成功时显示的背景色
            backgroundColor: Colors.white,
            backgroundImage:
                const NetworkImage("${RequestApi.baseUrl}/api/static/boy.png"),
          ),
          SizedBox(width: 15.dp),

          Expanded(
            child: Column(
              children: [
                SizedBox(height: 20.dp),
                Row(
                  children: [
                    /// 礼物名称和价格
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 礼物名称
                        Text(
                          "星猫造型",
                          style: TextStyle(
                            fontSize: 30.dp,
                          ),
                        ),
                        SizedBox(height: 16.dp),

                        /// 价格
                        Row(
                          children: [
                            Text(
                              "价格：",
                              style: TextStyle(
                                fontSize: 22.dp,
                                color: greyColor,
                              ),
                            ),
                            /// 圈达币
                            Image.asset(
                              "img/Icon/GoldCoin.png",
                              width: 20.dp,
                              height: 20.dp,
                            ),
                            SizedBox(width: 5.dp),
                            Text(
                              "6",
                              style: TextStyle(
                                fontSize: 24.dp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(width: 70.dp),

                    /// 赠礼人
                    Text(
                      "深圳一哥赠",
                      style: TextStyle(
                        fontSize: 30.dp,
                        color: greyColor,
                      ),
                    ),

                    const Expanded(child: SizedBox()),

                    /// 回礼
                    bgButton("回礼"),
                  ],
                ),
                SizedBox(height: 20.dp),
                /// 下划线
                Divider(
                  height: 1.dp,
                  thickness: 1.dp,
                  color: lightBlackDivider,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
