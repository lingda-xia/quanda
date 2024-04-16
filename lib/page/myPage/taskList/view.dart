import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/itemBox.dart';

/// 任务人列表页面
class TaskList extends StatelessWidget {
  TaskList({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(TaskListLogic());

  /// 数据层
  final state = Get.find<TaskListLogic>().state;

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<TaskListLogic>(builder: (_) {
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
        title: const Text("任务人列表"),
      ),

      /// 刷新和加载组件  自定义widget
      body: RefreshLoad(
        /// 初始化请求
        init: (page) => logic.getList(page),
        /// 用于重置列表
        resetList: (reset) => reload(reset),
        child: GetBuilder<TaskListLogic>(builder: (_) {
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
