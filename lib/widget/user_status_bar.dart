import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/user/OthersInfo.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 用户信息状态栏 公用
class UserStatusBar extends StatelessWidget {
  const UserStatusBar({Key? key, required this.data}) : super(key: key);

  /// 用户数据
  final OthersInfo data;

  /// 地址显示处理
  String address() {
    String str = "";

    print("---------${data.address}");

    if(data.address.isNotEmpty) {
      List<String> list = data.address.split(",");
      print("$list-------------------");
      if(list[0] == "黑龙江") {
        str = "${list[0]} ${list[1].substring(0, 2)}";
      } else {
        str = "${list[0].substring(0, 2)} ${list[1].substring(0, 2)}";
      }
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.dp, vertical: 20.dp),
      child: Row(
        children: [
          /// 头像
          CircleAvatar(
            radius: 65.dp,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(data.avatarUrl == ""
                ? "${RequestApi.baseUrl}/api/static/boy.png"
                : data.avatarUrl),
          ),
          SizedBox(width: 15.dp),

          /// 名字等信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 名字和性别
                Row(
                  children: [
                    Text(
                      data.nickname,
                      style: TextStyle(
                        fontSize: 30.dp,
                      ),
                    ),
                    SizedBox(width: 5.dp),

                    /// 性别图标
                    Image.asset(
                      "img/Icon/${data.sex == 1 ? "xingbienan" : "xingbienv"}.png",
                      width: 30.dp,
                      height: 30.dp,
                    ),
                  ],
                ),
                SizedBox(height: 10.dp),

                /// 圈达号
                Text(
                  "圈达号：${data.userId}",
                  style: TextStyle(
                    fontSize: 24.dp,
                    color: darkGreyColor,
                  ),
                ),
                SizedBox(height: 10.dp),

                /// 地区以及实名
                Row(
                  children: [
                    /// 地区
                    Text(
                      "地区：${address()}",
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: darkGreyColor,
                      ),
                    ),
                    SizedBox(width: 25.dp),

                    /// 实名图标
                    Image.asset(
                      "img/Icon/${data.authStatus == 0 ? "NotCertified" : "yishiming"}.png",
                      width: 30.dp,
                      height: 30.dp,
                    ),
                    SizedBox(width: 10.dp),

                    /// 是否实名
                    Text(
                      data.authStatus == 0 ? "未实名" : "已实名",
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: data.authStatus == 0
                            ? darkGreyColor
                            : const Color.fromRGBO(246, 209, 60, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
