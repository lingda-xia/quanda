import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 选择形象 页面
class ChooseFigure extends StatelessWidget {
  ChooseFigure({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ChooseFigureLogic());

  /// 数据层
  final state = Get.find<ChooseFigureLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.dp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.dp, top: 30.dp),
                child: Text(
                  "选择您的形象",
                  style: TextStyle(
                    fontSize: 60.dp,
                  ),
                ),
              ),
              SizedBox(height: 20.dp),
              Padding(
                padding: EdgeInsets.only(left: 30.dp),
                child: Text(
                  "生成后也可以换装修改哦~",
                  style: TextStyle(
                    fontSize: 28.dp,
                  ),
                ),
              ),
              SizedBox(height: 80.dp),

              /// 选择形象
              GetBuilder<ChooseFigureLogic>(builder: (_) {
                return Container(
                  alignment: Alignment.center,

                  /// 人物模型
                  child: CachedImage(
                    imgUrl: "${RequestApi.imgBaseUrl}renwu.png",
                    width: 350.dp,
                    height: 750.dp,
                  ),
                );
              }),

              const Expanded(child: SizedBox()),

              /// 选择形象
              GetBuilder<ChooseFigureLogic>(builder: (_) {
                return Row(
                  children: [
                    /// 选择男
                    GestureDetector(
                      onTap: () => logic.change("1"),
                      child: Container(
                        width: 80.dp,
                        height: 80.dp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.dp),
                          color: const Color.fromRGBO(45, 49, 50, 1),
                          border: Border.all(
                            width: 3.dp,
                            color: state.select == "1"
                                ? const Color.fromRGBO(159, 209, 109, 1)
                                : const Color.fromRGBO(45, 49, 50, 1),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 50.dp),

                    /// 选择女
                    GestureDetector(
                      onTap: () => logic.change("2"),
                      child: Container(
                        width: 80.dp,
                        height: 80.dp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.dp),
                          color: const Color.fromRGBO(45, 49, 50, 1),
                          border: Border.all(
                            width: 3.dp,
                            color: state.select == "2"
                                ? const Color.fromRGBO(159, 209, 109, 1)
                                : const Color.fromRGBO(45, 49, 50, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 50.dp),

              /// 下一步
              GestureDetector(
                onTap: logic.goToChooseName,
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
