import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'logic.dart';
import 'widget/certificationBox.dart';
import 'widget/information.dart';
import 'widget/harvestAddress.dart';

/// 个人资料页面
class PersonalData extends StatelessWidget {
  PersonalData({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PersonalDataLogic());

  /// 数据层
  final state = Get.find<PersonalDataLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// 用户信息保存
        await logic.userInfoSave();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
          title: const Text("个人信息"),
        ),
        body: ListView(
          padding: EdgeInsets.all(30.dp),
          children: [
            /// 实名认证区域  自定义widget
            CertificationBox(
              /// 数据源
              data: state,

              /// 点击事件
              pageJump: logic.goToCertification,
            ),

            SizedBox(height: 30.dp),

            /// 个人信息区域
            Information(
              /// 数据源
              state: state,

              /// 逻辑层
              logic: logic,
            ),

            SizedBox(height: 30.dp),

            /// 收货地址
            HarvestAddress(
              /// 数据源
              data: state,

              /// 点击事件
              onTap: logic.goToAddressManage,
            ),
          ],
        ),
      ),
    );
  }
}
