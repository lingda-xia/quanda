import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';
import 'widget/newFriendItem.dart';

/// 新的朋友页面
class NewFriends extends StatelessWidget {
  NewFriends({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(NewFriendLogic());

  /// 数据层
  final state = Get.find<NewFriendLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("新的朋友"),
      ),
      /// 刷新加载组件
      body: GetBuilder<NewFriendLogic>(
        builder: (_){
          return ListView(
            padding: EdgeInsets.all(30.dp),
            children: [
              for(int i = 0; i < state.list.length; i++)
              /// 新朋友列表item
                NewFriendItem(
                  /// 跳转到加好友验证页面
                  onTap: (id ,type) => logic.goToFriendVerification(id, type),
                  data: state.list[i],
                ),
            ],
          );
        },
      ),
    );
  }
}
