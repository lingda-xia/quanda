import 'package:flutter/material.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:get/get.dart';
import 'logic.dart';
import 'widget/noticeBox.dart';

/// 系统通知页面
class SystemNotice extends StatelessWidget {
  SystemNotice({Key? key}) : super(key: key);

  /// 逻辑层
  final logic = Get.put(NoticeLogic());
  /// 数据层
  final state = Get.find<NoticeLogic>().state;

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<NoticeLogic>(builder: (_) {
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
      appBar: AppBar(title: const Text("系统通知")),
      /// 刷新和加载组件  自定义widget
      body: RefreshLoad(
        /// 初始化请求
        init: (page) => logic.getList(page),
        /// 用于重置列表
        resetList: (reset) => reload(reset),
        /// 加载为空的提示
        emptyTips: "您还没有收到任何消息哦~",

        /// 加载为空的图片widget
        emptyWidget: Image.asset(
          "img/bigIcon/hollow.png",
          width: 540.dp,
          height: 364.dp,
        ),
        child: GetBuilder<NoticeLogic>(builder: (_) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 35.dp),
            children: [
              SizedBox(height: 30.dp),

              for (int i = 0; i < state.list.length; i++)
                NoticeBox(
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
