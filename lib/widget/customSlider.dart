import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 自定义单滑块
class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChange,
  }) : super(key: key);

  /// 滑动的值
  final double value;

  /// 滑动最小值
  final double min;

  /// 滑动最大值
  final double max;

  /// 划分成几份
  final int divisions;

  /// 滑动变化时触发
  final AParameterCallback<double> onChange;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
          /// 自定义拇指
          thumbShape: LineSliderThumbShape(),
        ),
        child: Slider(
          value: value,
          max: max,
          min: min,

          /// 未激活时的颜色
          inactiveColor: themeWhite,

          /// 激活后的颜色
          activeColor: paleGreenColor,

          /// 分层多少等分
          divisions: divisions,
          label: value.round().toString(),
          onChanged: onChange,
        ));
  }
}

/// 滑块拇指自定义
class LineSliderThumbShape extends SliderComponentShape {
  /// 定义大小
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(100.dp, 100.dp);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {

    /// 制作画笔
    Paint _paint = Paint()
      ..color = const Color.fromRGBO(127, 235, 214, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    /// 定义画线
    var _path = Path()
      ..moveTo(center.dx - 15.dp, center.dy - 15.dp)
      ..lineTo(center.dx + 15.dp, center.dy - 15.dp)
      ..lineTo(center.dx + 15.dp, center.dy + 15.dp)
      ..lineTo(center.dx + 15.dp, center.dy + 15.dp)
      ..lineTo(center.dx, center.dy + 22.dp)
      ..lineTo(center.dx - 15.dp, center.dy + 15.dp)
      ..close();
    context.canvas.drawPath(_path, _paint);
  }
}
