import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 支付弹窗
class PaymentOrder extends StatefulWidget {
  const PaymentOrder(
      {Key? key,
      required this.money,
      required this.orderId,
      required this.module})
      : super(key: key);

  /// 所需圈达币
  final String money;

  /// 订单id
  final int orderId;

  /// 支付模块
  final String module;

  @override
  State<PaymentOrder> createState() => _PaymentOrderState();
}

class _PaymentOrderState extends State<PaymentOrder> {

  /// 选择的下标
  late int select = 0;

  /// 余额
  static double balance = 0;

  /// 列表
  late List<Item> list = [
    Item(icon: "img/Icon/WeChat.png", title: "微信支付"),
    Item(icon: "img/Icon/Alipay.png", title: "支付宝支付"),
    Item(icon: "img/Icon/GoldCoin.png", title: "账户余额支付（$balance）"),
  ];

  /// 选择下标
  void onSelect(int i) {
    setState(() {
      select = i;
    });
  }

  /// 支付
  pay() {
    /// 发起请求
    UserRequest.pay(
      module: widget.module,
      payType: select + 1,
      payId: widget.orderId.toString(),
      success: (data) {
        /// 获取个人信息  更新余额
        UserRequest.getUserInfo(
          success: (data) {
            Get.back(result: "success");
          },
          fail: (code, msg) {
            Get.back(result: "success");
          },
        );
      },
      fail: (code, msg) {
        Get.back();
      },
    );
  }

  /// 获取个人用户信息
  getInfo() async {
    var value = SpUtil.getUserInfo();
    if (value != null) {
      setState(() {
        balance = value.balance;
        list = [
          Item(icon: "img/Icon/WeChat.png", title: "微信支付"),
          Item(icon: "img/Icon/Alipay.png", title: "支付宝支付"),
          Item(icon: "img/Icon/GoldCoin.png", title: "账户余额支付（$balance）"),
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    /// 获取个人用户信息
    getInfo();
  }

  /// 列表item
  Widget item(Item item, int index) {
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        height: 96.dp,
        margin: EdgeInsets.only(bottom: 20.dp),
        padding: EdgeInsets.only(left: 30.dp, right: 50.dp),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(31, 41, 44, 1),
          borderRadius: BorderRadius.circular(10.dp),
        ),
        child: Row(
          children: [
            Image.asset(
              item.icon,
              width: 44.dp,
              height: 44.dp,
            ),
            SizedBox(width: 25.dp),
            Text(
              item.title,
              style: const TextStyle(
                color: greyColor,
              ),
            ),
            const Expanded(child: SizedBox()),
            select == index
                ? Image.asset(
                    "img/Icon/check_yes.png",
                    width: 36.dp,
                    height: 36.dp,
                  )
                : Image.asset(
                    "img/Icon/check_no.png",
                    width: 36.dp,
                    height: 36.dp,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 820.dp,
      padding: EdgeInsets.all(40.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "提交订单",
            style: TextStyle(
              fontSize: 36.dp,
            ),
          ),
          SizedBox(height: 30.dp),

          /// 圈达币和价格
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 圈达币
              Image.asset(
                "img/Icon/GoldCoin.png",
                width: 42.dp,
                height: 42.dp,
              ),
              SizedBox(width: 10.dp),

              /// 所需金额
              Text(
                widget.money,
                style: TextStyle(
                  fontSize: 66.dp,
                  fontFamily: "Rany",
                ),
              ),
            ],
          ),

          SizedBox(height: 50.dp),

          for (int i = 0; i < list.length; i++) item(list[i], i),

          SizedBox(height: 50.dp),

          /// 购买
          GestureDetector(
            onTap: pay,
            child: Container(
              height: 96.dp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.dp),
                color: paleGreenColor,
              ),
              alignment: Alignment.center,
              child: Text(
                "购买",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.dp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 列表item
class Item {
  /// 图标
  late String icon;

  /// 标题
  late String title;

  Item({required this.icon, required this.title});
}
