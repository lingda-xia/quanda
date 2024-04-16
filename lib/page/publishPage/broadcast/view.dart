import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/publishPublic/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/customSlider.dart';

import 'logic.dart';
import 'state.dart';

/// 发布广播页面
class Broadcast extends StatelessWidget {
  Broadcast({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(BroadcastLogic());

  /// 数据层
  final state = Get.find<BroadcastLogic>().state;

  /// 滑块展示是数值
  Widget displayValues(String left, String middle, String right) {
    return GetBuilder<BroadcastLogic>(builder: (e) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.dp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 最小公里数
            Expanded(
              child: Text(
                left,
                style: TextStyle(
                  color: greyColor,
                  fontSize: 24.dp,
                ),
              ),
            ),

            /// 选中的公里数
            Expanded(
              child: Text(
                middle,
                style: TextStyle(
                  color: greyColor,
                  fontSize: 24.dp,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            /// 最大公里数
            Expanded(
              child: Text(
                right,
                style: TextStyle(
                  color: greyColor,
                  fontSize: 24.dp,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      );
    });
  }

  /// 标题
  Widget title(String img, String title, String tip) {
    return Row(
      children: [
        Image.asset(
          img,
          width: 36.dp,
          height: 36.dp,
        ),
        SizedBox(width: 10.dp),
        Text(
          title,
          style: TextStyle(
            fontSize: 30.dp,
          ),
        ),
        SizedBox(width: 4.dp),
        Text(
          tip,
          style: TextStyle(
            fontSize: 24.dp,
            color: darkGreyColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 发布公用部分  自定义widget
    return PublishPublic(

      /// 发布
      release: (title, content, address, location, idList) =>
          logic.release(title, content, address, location, idList),

      /// 保存草稿
      saveDraft: (title, content, address, location, galleryItem, status) =>
          logic.saveDraft(title, content, address, location, galleryItem, status),

      /// 是否打开使用草稿对话框
      initDialog: () => logic.initDialog(),

      /// 使用草稿时为父组件设置参数
      setContent: (value) => logic.setContent(value),

      children: [
        SizedBox(height: 40.dp),

        /// 多少公里内的人可以看到该广播
        title(
          "img/Icon/kilometre.png",
          "多少公里内的人可以看到该广播？",
          "(1公里=1元)",
        ),

        /// 公里数滑块
        GetBuilder<BroadcastLogic>(builder: (e) {
          return Stack(
            children: [
              /// 自定义滑块  自定义widget
              CustomSlider(
                value: state.kilometers,
                min: 1.0,
                max: 1000.0,
                divisions: 200,
                onChange: logic.kilometersChange,
              ),

              /// 头部固定正方形
              Positioned(
                top: 35.dp,
                left: 34.dp,
                child: Container(
                  width: 30.dp,
                  height: 30.dp,
                  color: const Color.fromRGBO(127, 235, 214, 1),
                ),
              ),
            ],
          );
        }),

        /// 公里数值
        displayValues("1k", "${state.kilometers.round()}k", "1000k"),

        SizedBox(height: 30.dp),

        /// 该任务展示的时长
        title(
          "img/Icon/time.png",
          "该任务展示的时长？",
          "(1分=0.1元)",
        ),

        /// 时长数滑块
        GetBuilder<BroadcastLogic>(builder: (e) {
          return Stack(
            children: [
              /// 自定义滑块  自定义widget
              CustomSlider(
                value: state.times,
                min: 24.0,
                max: 72.0,
                divisions: 48,
                onChange: logic.timesChange,
              ),

              /// 头部固定正方形
              Positioned(
                top: 35.dp,
                left: 34.dp,
                child: Container(
                  width: 30.dp,
                  height: 30.dp,
                  color: const Color.fromRGBO(127, 235, 214, 1),
                ),
              ),
            ],
          );
        }),

        /// 时长数值
        displayValues("24h", "${state.times.round()}h", "72h"),

        SizedBox(height: 30.dp),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        SizedBox(height: 20.dp),

        /// 所需圈达币
        Row(
          children: [
            /// 圈达币
            Image.asset(
              "img/Icon/GoldCoin.png",
              width: 42.dp,
              height: 42.dp,
            ),
            SizedBox(width: 14.dp),
            Text(
              "所需圈达币",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              height: 60.dp,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.dp),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.dp, color: orange),
                  borderRadius: BorderRadius.circular(
                    10.dp,
                  )),
              child: GetBuilder<BroadcastLogic>(builder: (e) {
                return Text(
                  "${state.payMoney}币",
                  style: TextStyle(
                    fontSize: 30.dp,
                    color: orange,
                  ),
                );
              }),
            ),
          ],
        ),

        SizedBox(height: 300.dp),
      ],
    );
  }
}
