import 'package:flutter/material.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 公共部分  会话列表item
class ChatListView extends StatelessWidget {
  const ChatListView({
    Key? key,
    required this.onTap,
    required this.sessionInfo,
  }) : super(key: key);

  /// 跳转点击事件
  final NoParameterCallback onTap;

  /// 会话信息
  final Map<String, dynamic> sessionInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.dp),
        child: Row(
          children: [
            /// 头像
            CircleAvatar(
              radius: 50.dp,
              /// 为加载成功时显示的背景色
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(sessionInfo["imgUrl"]),
            ),
            SizedBox(width: 30.dp,),
            /// 会话标题和内容
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          sessionInfo["title"],
                          style: TextStyle(
                            fontSize: 30.dp,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Text(
                          "15:31",
                          style: TextStyle(
                            fontSize: 24.dp,
                            color: const Color.fromRGBO(64, 67, 73, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.dp),
                    Text(
                      "艾克西亚：不如就承认一下，我们没有那样坚强",
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: const Color.fromRGBO(64, 67, 73, 1),
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 30.dp),
                    /// 下划线
                    Divider(
                      height: 1.dp,
                      color: const Color.fromRGBO(22, 28, 30, 1),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
