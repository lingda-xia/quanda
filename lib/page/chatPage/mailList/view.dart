import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/Input_box.dart';
import 'logic.dart';
import 'widget/functional.dart';

/// 通讯录页面
class MailList extends StatelessWidget {
  MailList({Key? key}) : super(key: key);

  /// 逻辑层
  final logic = Get.put(MailListLogic());

  /// 数据层
  final state = Get
      .find<MailListLogic>()
      .state;

  /// 通讯录列表头部widget
  Widget headWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.dp),
      child: Column(
        children: [
          /// 输入框 自定义widget
          InputBox(
            onTap: () => logic.goToSearchPage(),
            title: "圈达号/手机号/名称",
          ),
          SizedBox(height: 30.dp),
          /// 功能区域  自定义widget
          Functional(
            functionalList: state.functionalList,
            onTap: (str) => logic.goToPage(str),
          ),
          SizedBox(height: 30.dp),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        /// 回退键
        leading: const BackButton(),
        title: const Text("通讯录"),

        /// 右边区域
        actions: [
          /// 黑名单小人图标
          InkWell(
            onTap: () {
              /// 前往黑名单页面
              logic.goToBlacklist();
            },
            child: Padding(
              padding: EdgeInsets.all(10.dp),
              child: Image.asset(
                "img/Icon/blacklist.png",
                width: 37.dp,
                height: 39.dp,
              ),
            ),
          ),
          SizedBox(width: 40.dp),
        ],
      ),

      /// 通讯录列表  自定义widget
      body: GetBuilder<MailListLogic>(
        builder: (_){
          // return Container();
          return AddressList(
            headWidget: headWidget(),
            /// 好友列表
            friendList: state.friendList,
            /// 每一个组头距离顶部的距离
            groupOffsetMap: state.groupOffsetMap,
            /// 好友item点击事件  前往查看好友状态页面
            itemOnTap: (item) => logic.goToViewFriends(item),
          );
        },
      ),
    );
  }
}
