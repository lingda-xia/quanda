import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';
import 'widget/itemBox.dart';

/// 我的互动页面
class MyInteraction extends StatelessWidget {
  MyInteraction({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(MyInteractionLogic());

  /// 数据层
  final state = Get.find<MyInteractionLogic>().state;

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<MyInteractionLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if(state.reload) {
        reset();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("我的互动"),
      ),

      /// 刷新和加载组件  自定义widget
      body: RefreshLoad(
        /// 初始化请求
        init: (page) => logic.getList(0, page),
        /// 用于重置列表
        resetList: (reset) => reload(reset),

        /// 加载为空的提示
        emptyTips: "空空如也~",

        /// 加载为空的图片widget
        emptyWidget: Image.asset(
          "img/bigIcon/empty.png",
          width: 540.dp,
          height: 320.dp,
        ),

        child: GetBuilder<MyInteractionLogic>(builder: (_) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 35.dp),
            children: [
              for (int i = 0; i < state.list.length; i++)
                ItemBox(
                  state: state,
                  logic: logic,
                  index: i,
                ),
            ],
          );
        }),
      ),
    );
  }
}
