import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 地球
class Earth extends StatefulWidget {
  const Earth({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  /// 数据源
  final IndexState data;

  /// 点击事件
  final AParameterCallback<int> onTap;

  @override
  State<Earth> createState() => _EarthState();
}

class _EarthState extends State<Earth> with TickerProviderStateMixin {
  /// 动画时长
  final Duration animDuration = const Duration(milliseconds: 2000);

  /// 动画时长
  final Duration time = const Duration(milliseconds: 2000);

  /// 动画控制器
  late AnimationController controller;

  /// 动画控制器
  late AnimationController long;

  void initState() {
    super.initState();
    // 1. 声明动画器对象
    controller = AnimationController(vsync: this, duration: animDuration);
    long = AnimationController(vsync: this, duration: time);
    controller.repeat(
      reverse: true,
    );
    long.repeat(
      reverse: true,
    );
  }

  @override
  void dispose() {
    // 1. 销毁动画器
    controller.dispose();
    long.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 750.dp,
      height: 700.dp,
      child: GetBuilder<IndexLogic>(builder: (_) {
        return Stack(
          alignment: Alignment.center,
          children: [
            /// 地球
            Image.asset(
              "img/Icon/earth.png",
              width: 400.dp,
              height: 400.dp,
            ),
            for (int i = 0; i < widget.data.areaList.length; i++)
              widget.data.list.isNotEmpty
                  ? Positioned(
                      top: (widget.data.list[i].dy).dp,
                      left: (widget.data.list[i].dx).dp,
                      child: AnimatedBuilder(
                        animation: i.isOdd ? controller : long,
                        builder: (_, __) {
                          return Transform.translate(
                            offset: i.isOdd
                                ? Offset(0.0, (10 * controller.value))
                                : Offset(0.0, (-10 * long.value)),
                            child: Column(
                              children: [
                                /// 当前地区
                                Visibility(
                                  visible: widget.data.areaList[i].stress,
                                  child: Column(
                                    children: [
                                      CachedImage(
                                        imgUrl:
                                            "${RequestApi.imgBaseUrl}yellow_coordinate.png",
                                        width: 75.dp,
                                        height: 75.dp,
                                      ),
                                      SizedBox(height: 5.dp),
                                      Text(
                                        widget.data.areaList[i].name,
                                        style: TextStyle(
                                          color: orange,
                                          fontSize: 22.dp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// 非当前地区
                                Visibility(
                                  visible: !widget.data.areaList[i].stress,
                                  child: Column(
                                    children: [
                                      CachedImage(
                                        imgUrl:
                                            "${RequestApi.imgBaseUrl}coordinate.png",
                                        width: 68.dp,
                                        height: 68.dp,
                                      ),
                                      SizedBox(height: 5.dp),
                                      Text(
                                        widget.data.areaList[i].name,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              69, 250, 220, 1),
                                          fontSize: 20.dp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
          ],
        );
      }),
    );
  }
}
