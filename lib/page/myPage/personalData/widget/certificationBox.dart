import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 功能栏
class CertificationBox extends StatelessWidget {
  const CertificationBox({
    Key? key,
    required this.data,
    required this.pageJump,
  }) : super(key: key);

  /// 数据源
  final PersonalDataState data;

  /// 点击事件
  final NoParameterCallback pageJump;

  /// 未实名状态
  Widget noRealName() {
    return Container(
      width: 690.dp,
      height: 400.dp,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage("${RequestApi.imgBaseUrl}NotCertifiedBack.png"),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 140.dp),

          /// 您尚未实名认证
          Padding(
            padding: EdgeInsets.only(left: 70.dp),
            child: Text(
              "您尚未实名认证",
              style: TextStyle(
                color: Colors.white,
                fontSize: 42.dp,
              ),
            ),
          ),

          SizedBox(height: 28.dp),

          /// 未认证图标
          Padding(
            padding: EdgeInsets.only(left: 75.dp),
            child: Image.asset(
              "img/Icon/NotCertified.png",
              width: 46.dp,
              height: 34.dp,
            ),
          ),
          SizedBox(height: 46.dp),

          /// 实名认证按钮
          GestureDetector(
            onTap: pageJump,
            child: Container(
              width: 188.dp,
              height: 70.dp,
              margin: EdgeInsets.only(left: 62.dp),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(233, 255, 251, 1),
                borderRadius: BorderRadius.circular(35.dp),
              ),
              child: Text(
                "+实名认证",
                style: TextStyle(
                  color: const Color.fromRGBO(36, 188, 161, 1),
                  fontSize: 30.dp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 已实名
  Widget realName() {
    return Container(
      width: 690.dp,
      height: 400.dp,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage("${RequestApi.imgBaseUrl}CertifiedBack.png"),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 140.dp),

          /// 您已实名认证
          Padding(
            padding: EdgeInsets.only(left: 70.dp),
            child: Text(
              "您已实名认证",
              style: TextStyle(
                color: const Color.fromRGBO(36, 144, 124, 1),
                fontSize: 42.dp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: 28.dp),

          /// 图标
          Padding(
            padding: EdgeInsets.only(left: 75.dp),
            child: Row(
              children: [
                Image.asset(
                  "img/Icon/NotCertified.png",
                  width: 46.dp,
                  height: 34.dp,
                ),
                SizedBox(width: 20.dp),
                Text(
                  data.info.authInfo["name"]!,
                  style: const TextStyle(
                    color: Color.fromRGBO(36, 144, 124, 1),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30.dp),

          /// 认证身份证
          Padding(
            padding: EdgeInsets.only(left: 75.dp),
            child: Text(
              data.info.authInfo["card"]!,
              style: const TextStyle(
                color: Color.fromRGBO(36, 144, 124, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalDataLogic>(builder: (_) {
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          /// 是否已实名
          data.info.authStatus == 0 ? noRealName() : realName(),

          /// 用户头像
          Positioned(
            top: -30.dp,
            child: CircleAvatar(
              radius: 59.dp,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(data.info.avatarUrl),
            ),
          ),
        ],
      );
    });
  }
}
