import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 选择性别 页面
class ChooseGender extends StatelessWidget {
  ChooseGender({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ChooseGenderLogic());

  /// 数据层
  final state = Get.find<ChooseGenderLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.dp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.dp, left: 30.dp),
                child: Text(
                  "选择性别",
                  style: TextStyle(
                    fontSize: 60.dp,
                  ),
                ),
              ),
              SizedBox(height: 40.dp),
              Padding(
                padding: EdgeInsets.only(left: 30.dp),
                child: Text(
                  "实名认证后将不可修改哦~",
                  style: TextStyle(
                    fontSize: 28.dp,
                  ),
                ),
              ),
              SizedBox(height: 280.dp),

              /// 选择性别
              GetBuilder<ChooseGenderLogic>(builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// 男
                    GestureDetector(
                      onTap: () => logic.change(1),
                      child: Container(
                        width: 115.dp,
                        height: 115.dp,
                        decoration: BoxDecoration(
                          color: state.select == 1
                              ? const Color.fromRGBO(136, 145, 146, 1)
                              : const Color.fromRGBO(48, 55, 56, 1),
                          borderRadius: BorderRadius.circular(60.dp),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "img/Icon/man.png",
                          width: 48.dp,
                          height: 48.dp,
                        ),
                      ),
                    ),
                    SizedBox(width: 90.dp),

                    /// 女
                    GestureDetector(
                      onTap: () => logic.change(2),
                      child: Container(
                        width: 115.dp,
                        height: 115.dp,
                        decoration: BoxDecoration(
                          color: state.select == 2
                              ? const Color.fromRGBO(136, 145, 146, 1)
                              : const Color.fromRGBO(48, 55, 56, 1),
                          borderRadius: BorderRadius.circular(60.dp),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "img/Icon/girl.png",
                          width: 48.dp,
                          height: 48.dp,
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 30.dp),

              GetBuilder<ChooseGenderLogic>(
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 男生
                      Container(
                        width: 115.dp,
                        alignment: Alignment.center,
                        child: Text(
                          "男生",
                          style: TextStyle(
                            fontSize: 28.dp,
                            color: state.select == 1
                                ? const Color.fromRGBO(136, 145, 146, 1)
                                : const Color.fromRGBO(80, 81, 86, 1),
                          ),
                        ),
                      ),
                      SizedBox(width: 90.dp),

                      /// 女生
                      Container(
                        width: 115.dp,
                        alignment: Alignment.center,
                        child: Text(
                          "女生",
                          style: TextStyle(
                            fontSize: 28.dp,
                            color: state.select == 2
                                ? const Color.fromRGBO(136, 145, 146, 1)
                                : const Color.fromRGBO(80, 81, 86, 1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const Expanded(child: SizedBox()),

              /// 下一步
              GestureDetector(
                onTap: logic.goToChooseBirthday,
                child: Container(
                  height: 96.dp,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/Icon/login_button.png")),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "下一步",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.dp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 100.dp),
            ],
          ),
        ),
      ),
    );
  }
}
