import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';
import 'widget/detailBox.dart';

/// 闲置订单详情页面
class IdleOrderDetails extends StatelessWidget {
  IdleOrderDetails({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(IdleOrderDetailsLogic());

  /// 数据层
  final state = Get.find<IdleOrderDetailsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("闲置订单详情"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.dp),
        child: Column(
          children: [
            /// 详情部分
            GetBuilder<IdleOrderDetailsLogic>(builder: (_) {
              return DetailBox(
                state: state,

                logic: logic,
              );
            }),
          ],
        ),
      ),
    );
  }
}
