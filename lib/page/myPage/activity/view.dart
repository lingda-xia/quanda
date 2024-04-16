import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/// 活动页面
class Activity extends StatelessWidget {
  Activity({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ActivityLogic());

  /// 数据层
  final state = Get.find<ActivityLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("热门活动"),
      ),
      body: ListView(),
    );
  }
}
