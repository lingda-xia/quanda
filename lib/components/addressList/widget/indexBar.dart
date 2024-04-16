import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';
import '../state.dart';

/// 好友列表的索引栏
class IndexBar extends StatelessWidget {
  const IndexBar({
    Key? key,
    required this.indexBarCallBack,
    required this.data,
    required this.updateData,
    required this.endUpdate,
  }) : super(key: key);

  /// 滑动后的回调函数
  final void Function(String str)? indexBarCallBack;

  /// 数据源
  final AddressListState data;

  /// 垂直向下拖拽时回调
  final AParameterCallback updateData;

  /// 垂直向下拖拽结束回调
  final NoParameterCallback endUpdate;

  /// 获取屏幕高度
  double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// 获取当前组名所在的index
  int getIndexItem(BuildContext context, Offset globalPosition) {
    //拿到当前盒子
    RenderBox box = context.findRenderObject() as RenderBox;
    //拿到y值，当前位置到部件原点(部件左上角)的距离(x,y)
    var y = box.globalToLocal(globalPosition).dy;

    //算出字符高度
    var itemHeight = 814.dp / data.INDEX_WORDS.length;
    int index =
        y ~/ itemHeight.clamp(0, data.INDEX_WORDS.length - 1); //~取整,设置取整范围clamp
    // 限制index的范围
    if (index > data.INDEX_WORDS.length - 1) {
      index = data.INDEX_WORDS.length - 1;
    } else if (index < 0) {
      index = 0;
    }
    print("得到的$index");
    return index;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> words = []; //字母索引
    for (int i = 0; i < data.INDEX_WORDS.length; i++) {
      words.add(GetBuilder<AddressListLogic>(builder: (res) {
        return Container(
          width: 30.dp,
          height: 30.dp,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            /// 跟选择的组名相同则改变颜色
            color: data.INDEX_WORDS[i] == data.indicatorText
                ? data.backColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15.dp),
          ),
          child: Text(
            data.INDEX_WORDS[i],
            style: TextStyle(
              fontSize: 24.dp,

              /// 跟选择的组名相同则改变颜色
              color: data.INDEX_WORDS[i] == data.indicatorText
                  ? data.textColor
                  : const Color.fromRGBO(115, 117, 124, 1),
            ),
          ),
        );
      }));
    }

    return Positioned(
      right: 0.0,
      top: screenHeight(context) / 10,
      height: 814.dp,
      width: 240.dp,
      child: Row(
        children: [
          /// 指示器
          GetBuilder<AddressListLogic>(builder: (res) {
            return Container(
              alignment: Alignment(0, data.indicatorY),
              width: 200.dp,
              child: data.indicatorHidden
                  ? null
                  : Stack(
                      alignment: const Alignment(-0.2, 0),
                      children: [
                        Image.asset("img/Icon/qipao.png", width: 120.dp),
                        Text(
                          data.indicatorText,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
            );
          }),

          /// 索引栏
          GestureDetector(
            /// 垂直向下拖拽时
            onVerticalDragDown: (DragDownDetails details) {
              int index = getIndexItem(context, details.globalPosition);
              indexBarCallBack!(data.INDEX_WORDS[index]);

              updateData(index);
            },

            /// 垂直向下拖拽结束
            onVerticalDragEnd: (DragEndDetails details) {
              endUpdate();
            },

            /// 垂直拖动更新时
            onVerticalDragUpdate: (DragUpdateDetails details) {
              int index = getIndexItem(context, details.globalPosition);
              indexBarCallBack!(data.INDEX_WORDS[index]);

              updateData(index);
            },
            child: SizedBox(
              width: 40.dp,
              child: Column(
                children: words,
              ),
            ),
          )
        ],
      ),
    );
  }
}
