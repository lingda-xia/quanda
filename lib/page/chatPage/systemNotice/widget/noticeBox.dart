import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/chat/SystemMsg.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 系统通知框
class NoticeBox extends StatelessWidget {
  const NoticeBox(
      {Key? key, required this.state, required this.logic, required this.index})
      : super(key: key);

  /// 逻辑层
  final NoticeLogic logic;

  /// 数据层
  final NoticeState state;

  /// 列表索引
  final int index;

  /// 系统通知时间转换
  String change(String data) {
    String str = "";

    if(data.isNotEmpty) {
      int value = DateTime.parse(data).millisecondsSinceEpoch;

      final time = DateTime.fromMillisecondsSinceEpoch(value);

      str = "${time.hour}:${time.minute}";
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {

    final SystemMsg item = state.list[index];

    return Container(
      margin: EdgeInsets.only(bottom: 30.dp),
      child: Row(
        children: [
          /// 通知图标
          Image.asset(
            "img/Icon/system_notification.png",
            width: 88.dp,
            height: 88.dp,
          ),
          SizedBox(width: 8.dp),

          /// 三角形
          CustomPaint(
            painter: Triangle(),
            size: Size.square(30.dp),
          ),

          /// 通知框
          Expanded(
            child: Container(
              width: 556.dp,
              padding: EdgeInsets.symmetric(vertical: 15.dp, horizontal: 25.dp),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(104, 210, 188, 1),
                borderRadius: BorderRadius.circular(20.dp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 系统通知
                  Row(
                    children: [
                      Text(
                        "系统通知",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.dp,
                        ),
                      ),

                      const Expanded(child: SizedBox()),

                      Text(
                        change(item.createTime),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.dp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.dp),

                  /// 通知内容
                  Text(
                    item.msgInfo.info,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.dp,
                    ),
                    maxLines: state.num,
                    overflow: TextOverflow.ellipsis,
                  ),

                  /// 点击查看
                  GestureDetector(
                    onTap: logic.seeMore,
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: EdgeInsets.only(top: 10.dp, left: 10.dp),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "点击查看",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.dp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /// 制作画笔
    Paint _paint = Paint()
      ..color = const Color.fromRGBO(104, 210, 188, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    /// 定义画线
    var _path = Path()
      ..moveTo(0, 8)
      ..lineTo(30, -16)
      ..lineTo(30, 18)
      ..close();

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

}
