import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 选择生日 页面
class ChooseBirthday extends StatelessWidget {
  ChooseBirthday({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ChooseBirthdayLogic());

  /// 数据层
  final state = Get.find<ChooseBirthdayLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.dp, top: 30.dp),
              child: Text(
                "选择生日",
                style: TextStyle(
                  fontSize: 60.dp,
                ),
              ),
            ),
            SizedBox(height: 20.dp),
            Padding(
              padding: EdgeInsets.only(left: 30.dp),
              child: Text(
                "选择您的生日哦~",
                style: TextStyle(
                  fontSize: 28.dp,
                ),
              ),
            ),
            SizedBox(height: 250.dp),

            /// 选择性别
            GetBuilder<ChooseBirthdayLogic>(builder: (_) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center, children: []);
            }),

            /// 时间选择器
            SizedBox(
              height: 500.dp,
              /// 主题配置
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 36.dp,
                    )
                  ),
                ),
                child: CupertinoDatePicker(
                  /// 初始时间
                  initialDateTime: state.initTime,
                  /// 时间模式
                  mode: CupertinoDatePickerMode.date,
                  /// 最小年份
                  minimumYear: DateTime.now().year - 100,
                  /// 最大的时间
                  maximumDate: DateTime.now(),
                  /// 最大的年份
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime newTime) {
                    logic.change(newTime);
                    print("返回的时间$newTime");
                  },
                ),
              ),
            ),

            const Expanded(child: SizedBox()),

            /// 下一步
            GestureDetector(
              onTap: logic.goToChooseFigure,
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
    );
  }
}
