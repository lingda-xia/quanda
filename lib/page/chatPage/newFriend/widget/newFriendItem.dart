import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_application.dart';

/// 新的朋友列表item
class NewFriendItem extends StatelessWidget {
  const NewFriendItem({
    Key? key,
    required this.onTap,
    required this.data,
  }) : super(key: key);

  /// 跳转点击事件
  final TwoParameterCallback onTap;

  /// 会话信息
  final V2TimFriendApplication? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.dp),
      child: Row(
        children: [
          /// 头像
          CircleAvatar(
            radius: 50.dp,

            /// 为加载成功时显示的背景色
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(data!.faceUrl == ""
                ? "${RequestApi.baseUrl}/api/static/boy.png"
                : data!.faceUrl ?? ""),
          ),
          SizedBox(
            width: 25.dp,
          ),

          /// 好友名字和验证信息
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /// 名字和验证信息区域
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 名字
                            Text(
                              data!.nickname == ""
                                  ? "用户名称"
                                  : data!.nickname ?? "",
                              style: TextStyle(
                                fontSize: 30.dp,
                              ),
                            ),
                            data!.addWording != "" ? SizedBox(height: 10.dp) : Container(),

                            /// 验证信息
                            Visibility(
                              visible: data!.addWording != "",
                              child: Text(
                                data!.addWording ?? "",
                                style: TextStyle(
                                  fontSize: 24.dp,
                                  color: const Color.fromRGBO(64, 67, 73, 1),
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 按钮区域
                      /// type为1 表示是新朋友  type为2 表示加他人等待他人同意
                      GestureDetector(
                        onTap: () => onTap(data?.userID, data?.type),
                        child: Container(
                          width: 128.dp,
                          height: 60.dp,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: paleGreenColor,
                            borderRadius: BorderRadius.circular(10.dp),
                          ),
                          child: Text(
                            data!.type == 1 ? "查看" : "等待验证",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.dp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.dp),

                  /// 下划线
                  Divider(
                    height: 1.dp,
                    color: const Color.fromRGBO(22, 28, 30, 1),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
