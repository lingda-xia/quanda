import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 列表的item
class ItemBox extends StatelessWidget {
  const ItemBox({
    Key? key,
    required this.state,
    required this.logic,
    required this.index,
  }) : super(key: key);

  /// 数据源
  final MyInteractionState state;

  /// 逻辑层
  final MyInteractionLogic logic;

  /// 列表索引
  final int index;

  /// 灰色按钮
  Widget greyButton(String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 58.dp,
        padding: EdgeInsets.symmetric(horizontal: 16.dp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: greyColor,
            width: 2.dp,
          ),
          borderRadius: BorderRadius.circular(29.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: greyColor,
            fontSize: 26.dp,
          ),
        ),
      ),
    );
  }

  /// 按钮区域
  Widget buttonArea(ReleaseList item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /// 任务类型 显示 结束任务
        item.type == 3 && item.status != 4
            ? greyButton("结束任务", () => logic.releaseTaskEnd(item.id))
            : Container(),

        SizedBox(width: 35.dp),

        /// 任务类型 显示 任务人列表
        item.type == 3
            ? greyButton("任务人列表", () => logic.goToTaskList(item.id))
            : Container(),

        /// 闲置类型 显示 订单详情  详情允许可见
        item.type == 4 && item.idleOrderStatus
            ? greyButton("订单详情", () => logic.goToIdleOrderDetails(item.id))
            : Container(),

        item.type == 4 ? SizedBox(width: 35.dp) : Container(),

        /// 闲置类型 显示 删除闲置
        item.type == 4
            ? greyButton("删除闲置", () => logic.openDeleteDialog(item.id))
            : Container(),

        SizedBox(width: 35.dp),

        /// 任务和闲置类型 显示 核验  已结束不显示
        item.type == 3 || item.type == 4 && item.status != 4
            ? GestureDetector(
                onTap: logic.verification,
                child: Container(
                  height: 58.dp,
                  padding: EdgeInsets.symmetric(horizontal: 16.dp),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/Icon/Verification.png")),
                  ),
                  child: Text(
                    "${state.typeNameList[item.type]}核验",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.dp,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  /// 展示图片列表
  Widget imgList(List<ImgEntity> imgList) {
    if (imgList.length > 3) {
      imgList.removeRange(2, imgList.length - 1);
    }
    return Wrap(
      spacing: 20.dp,
      children: [
        for (int i = 0; i < imgList.length; i++)
          ClipRRect(
            borderRadius: BorderRadius.circular(14.dp),
            child: CachedImage(
              imgUrl: imgList[i].fileVideoPath == null
                  ? imgList[i].filePath
                  : imgList[i].fileVideoPath ?? "",
              width: 200.dp,
              height: 200.dp,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  /// 公里维度
  Widget dimension(int rangeKm) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.dp),
      child: Text(
        "公里维度：$rangeKm",
        style: TextStyle(
          color: greyColor,
          fontSize: 24.dp,
        ),
      ),
    );
  }

  /// 发布时间
  Widget releaseTime(ReleaseList item) {
    return Text(
      "发布日期：${item.createTime}",
      style: TextStyle(
        color: darkGreyColor,
        fontSize: 22.dp,
      ),
    );
  }

  /// 瞬间和广播 底部
  Widget bottom(ReleaseList item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 瞬间类型 显示 发布时间
        item.type == 1 ? releaseTime(item) : Container(),

        /// 删除广播
        greyButton("删除${state.typeNameList[item.type]}",
            () => logic.openDeleteDialog(item.id)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 列表的item
    ReleaseList item = state.list[index];

    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.only(
            left: 20.dp, right: 20.dp, top: 20.dp, bottom: 30.dp),
        margin: EdgeInsets.only(bottom: 30.dp),
        decoration: BoxDecoration(
          color: blackGrey,
          borderRadius: BorderRadius.circular(14.dp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 图标和任务人数以及参与人数
            Row(
              children: [
                Image.asset(
                  "img/Icon/${state.typeList[item.type]}.png",
                  width: 200.dp,
                  height: 67.dp,
                ),

                const Expanded(child: SizedBox()),

                /// 任务类型显示
                item.type == 3 && (item.status == 1 || item.status == 5)
                    ? Text(
                        "任务人数：${item.personNumber}  当前参与 ${item.currentNumber}",
                        style: TextStyle(
                          color: const Color.fromRGBO(246, 209, 60, 1),
                          fontSize: 26.dp,
                        ),
                      )
                    : Container(),

                /// 任务类型显示  任务结束
                Visibility(
                  visible: item.type == 3 && item.status == 4,
                  child: Text(
                    "任务结束",
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 24.dp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.dp),

            /// 下划线
            Divider(
              height: 1.dp,
              thickness: 1.dp,
              color: const Color.fromRGBO(44, 48, 47, 1),
            ),
            SizedBox(height: 20.dp),

            /// 标题   闲置 可点击标题前往闲置详情
            GestureDetector(
              onTap: () => logic.goToSeeDetails(item.id.toString()),
              behavior: HitTestBehavior.translucent,
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 30.dp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: 20.dp),

            /// 图片展示
            imgList(item.mediaList),

            SizedBox(height: 30.dp),

            /// 瞬间类别 不显示 圈达币
            item.type == 1
                ? Container()
                : Row(
                    children: [
                      Text(
                        "圈达币：",
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 28.dp,
                        ),
                      ),
                      Text(
                        item.payMoney.toString(),
                        style: TextStyle(
                          color: const Color.fromRGBO(246, 209, 60, 1),
                          fontSize: 36.dp,
                          fontFamily: "Rany",
                        ),
                      ),
                    ],
                  ),

            SizedBox(height: 18.dp),

            /// 广播类型 显示公里维度
            item.type == 2 ? dimension(item.rangeKm) : Container(),

            /// 瞬间类型 不显示  发布日期和结束时间
            item.type == 1 ? Container() : releaseTime(item),

            SizedBox(height: 30.dp),

            /// 任务和闲置类型 显示的底部
            item.type == 3 || item.type == 4 ? buttonArea(item) : Container(),

            /// 瞬间和广播s类型 显示的底部
            item.type == 1 || item.type == 2 ? bottom(item) : Container(),
          ],
        ),
      ),
    );
  }
}
