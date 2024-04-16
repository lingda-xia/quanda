import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/interaction.dart';
import 'package:quanda/model/personal/ExpressEntity.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 快递选择 页面
class Express extends StatefulWidget {
  const Express({
    Key? key,
  }) : super(key: key);

  @override
  State<Express> createState() => _ExpressState();
}

class _ExpressState extends State<Express> {
  /// 选择的快递
  late int select = 1;

  /// 快递列表
  late List<ExpressEntity> list = [];

  @override
  void initState() {
    super.initState();

    /// 页面加载完成
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 获取快递列表
      expressList();

      setState(() {
        select = Get.arguments;
      });
    });
  }

  /// 获取快递列表
  expressList() {
    /// 发起请求
    InteractionRequest.expressList(
      success: (data) {
        setState(() {
          list = data;
        });
      },
      fail: (code, msg) {},
    );
  }

  /// 列表item
  Widget item(ExpressEntity item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          select = item.id;
        });
        Get.back(result: item);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 100.dp,
        padding: EdgeInsets.only(left: 40.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  /// 快递名称
                  Text(
                    item.expressName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Expanded(child: SizedBox()),

                  Stack(
                    children: [
                      Visibility(
                        visible: select == item.id,
                        child: Image.asset(
                          "img/Icon/check_yes.png",
                          width: 32.dp,
                          height: 32.dp,
                        ),
                      ),
                      Visibility(
                        visible: select != item.id,
                        child: Image.asset(
                          "img/Icon/check_no.png",
                          width: 32.dp,
                          height: 32.dp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 60.dp),
                ],
              ),
            ),

            /// 下划线
            Divider(
              height: 1.dp,
              thickness: 1.dp,
              color: const Color.fromRGBO(22, 28, 30, 1),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("快递选择"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [for (int i = 0; i < list.length; i++) item(list[i])],
        ),
      ),
    );
  }
}
