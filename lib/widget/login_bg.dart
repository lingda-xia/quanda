import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

/// 登陆页背景
class LoginBG extends StatelessWidget {
  const LoginBG({
    Key? key,
    required this.children,
  }) : super(key: key);

  /// 主体内容
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    /// 背景图
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage("${RequestApi.imgBaseUrl}login_bg.png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 240.dp),

              /// logo 和 appName
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// logo
                  CachedImage(
                    imgUrl: "${RequestApi.imgBaseUrl}logo.png",
                    width: 108.dp,
                    height: 108.dp,
                  ),
                  SizedBox(width: 30.dp),

                  /// 圈达
                  CachedImage(
                    imgUrl: "${RequestApi.imgBaseUrl}quan_da.png",
                    width: 152.dp,
                    height: 74.dp,
                  ),
                ],
              ),
              SizedBox(height: 40.dp),
              Text(
                "世界这么大 我要有个圈",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.dp,
                ),
                textAlign: TextAlign.center,
              ),

              for (int i = 0; i < children.length; i++) children[i]
            ],
          ),
        ),
      ),
    );
  }
}
