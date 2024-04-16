import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// tab列表
class More extends StatelessWidget {
  const More({
    Key? key,
    required this.logic,
    required this.state,
  }) : super(key: key);

  /// 数据源
  final OthersState state;

  /// 逻辑层
  final OthersLogic logic;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 445.dp,
      child: Column(
        children: [
          SizedBox(height: 70.dp),

          Row(
            children: [
              SizedBox(width: 80.dp),

              /// 拉黑  如果是自己不可见
              state.userInfo.userId == state.info.userId
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        /// 拉黑
                        logic.blackmailUsers();
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "img/Icon/lahei.png",
                            width: 108.dp,
                            height: 108.dp,
                          ),
                          SizedBox(height: 30.dp),
                          Text(
                            "拉黑",
                            style: TextStyle(
                              fontSize: 26.dp,
                            ),
                          ),
                        ],
                      ),
                    ),

              state.userInfo.userId == state.info.userId
                  ? Container()
                  : SizedBox(width: 54.dp),

              /// 分享
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Image.asset(
                      "img/Icon/fenxiang.png",
                      width: 108.dp,
                      height: 108.dp,
                    ),
                    SizedBox(height: 30.dp),
                    Text(
                      "分享",
                      style: TextStyle(
                        fontSize: 26.dp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 40.dp),

          /// 下划线
          Divider(
            height: 2.dp,
            thickness: 2.dp,
            color: const Color.fromRGBO(28, 38, 40, 1),
          ),

          SizedBox(height: 50.dp),

          /// 取消
          GestureDetector(
            onTap: () => Get.back(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "取消",
                style: TextStyle(
                  fontSize: 32.dp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
