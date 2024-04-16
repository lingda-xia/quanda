import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 收货地址
class HarvestAddress extends StatelessWidget {
  const HarvestAddress({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  /// 数据源
  final PersonalDataState data;

  /// 点击事件
  final NoParameterCallback onTap;

  /// 手机号码显示处理
  String phone() {
    String str = "";

    str = data.info.addressInfo!.phone.replaceRange(3, 7, "****");

    return str;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.dp),
        decoration: BoxDecoration(
          color: blackGrey,
          borderRadius: BorderRadius.circular(14.dp),
        ),
        child: Column(
          children: [
            SizedBox(height: 32.dp),

            /// 收货地址
            GetBuilder<PersonalDataLogic>(builder: (_) {
              return Row(
                children: [
                  const Text("收货地址："),
                  const Expanded(child: SizedBox()),

                  /// 是否选择了地址
                  data.info.addressInfo == null
                      ? Image.asset(
                          "img/Icon/addAddress.png",
                          width: 50.dp,
                          height: 50.dp,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${data.info.addressInfo!.contact} ${phone()}",
                              style: TextStyle(
                                fontSize: 26.dp,
                              ),
                            ),
                            SizedBox(height: 10.dp),
                            Text(
                              data.info.addressInfo!.areaAddress,
                              style: TextStyle(
                                fontSize: 22.dp,
                                color: greyColor,
                              ),
                            ),
                            SizedBox(height: 4.dp),
                            Text(
                              data.info.addressInfo!.address,
                              style: TextStyle(
                                fontSize: 22.dp,
                                color: greyColor,
                              ),
                            ),
                          ],
                        ),

                  /// 右箭头
                  Icon(
                    Icons.chevron_right,
                    color: greyColor,
                    size: 40.dp,
                  ),
                ],
              );
            }),
            SizedBox(height: 32.dp),
          ],
        ),
      ),
    );
  }
}
