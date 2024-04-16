import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 收益说明 页面
class IncomeStatement extends StatelessWidget {
  const IncomeStatement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("收益说明"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 35.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 下划线
            Divider(
              height: 20.dp,
              thickness: 20.dp,
              color: darkBlackDivider,
            ),
            SizedBox(height: 35.dp),
            Text(
              "金币说明~",
              style: TextStyle(
                fontSize: 34.dp,
              ),
            ),
            SizedBox(height: 30.dp),
            const Text(
              "1.每日凌晨金币会自动兑换成现金，现金可随时提现。",
              style: TextStyle(
                color: greyColor,
              ),
            ),
            const Text(
              "2.每天都可以登录看广告，或完成其他任务得奖励。",
              style: TextStyle(
                color: greyColor,
              ),
            ),

            SizedBox(height: 100.dp),

            Text(
              "规则明细~",
              style: TextStyle(
                fontSize: 34.dp,
              ),
            ),
            SizedBox(height: 30.dp),
            const Text(
              "1.你可以完成本APP提供的任务来赚取金币、现金，具体的任务请参见本活动规则为准。",
              style: TextStyle(
                color: greyColor,
              ),
            ),
            SizedBox(height: 30.dp),
            const Text(
              "2金币每晚凌晨后会自动兑换成现金，金币与现金的兑换比率大约为1000:1该比率受每日广告收益的影响，会有浮动。",
              style: TextStyle(
                color: greyColor,
              ),
            ),

            SizedBox(height: 30.dp),
            const Text(
              "3.如果您连续30日未登陆本APP，那么此前本APP发放给用户的现金将会过期，逾期未提现则视为用户自愿放弃提现的权利，现金金额将被清零。",
              style: TextStyle(
                color: greyColor,
              ),
            ),
            SizedBox(height: 30.dp),
            const Text(
              "4.本APP发放的金币用于再符合本规则的前提下在本app兑换现金，以鼓励用户使用本APP，金币不可以用于买卖、交换、支付等其他用途。",
              style: TextStyle(
                color: greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
