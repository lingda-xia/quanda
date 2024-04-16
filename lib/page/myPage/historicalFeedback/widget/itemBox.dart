import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/FeedbackInfo.dart';
import 'package:quanda/router/router.dart';
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
  final HistoricalFeedbackState state;

  /// 数据源
  final HistoricalFeedbackLogic logic;

  /// 下标索引
  final int index;

  /// 展示图片列表
  Widget imgList(FeedbackInfo item) {
    return Wrap(
      spacing: 30.dp,
      children: [
        for (int i = 0; i < item.imageList.length; i++)
          ClipRRect(
            borderRadius: BorderRadius.circular(14.dp),
            child: CachedImage(
              imgUrl: item.imageList[i].filePath,
              width: 210.dp,
              height: 210.dp,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final FeedbackInfo item = state.list[index];

    return Container(
      margin: EdgeInsets.only(bottom: 30.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 图标和任务人数以及参与人数
          Row(
            children: [
              /// 头像
              CircleAvatar(
                radius: 50.dp,

                /// 为加载成功时显示的背景色
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(item.userInfo.avatarUrl),
              ),

              SizedBox(width: 20.dp),

              /// 名字和时间
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.userInfo.nickname,
                    style: TextStyle(
                      fontSize: 30.dp,
                    ),
                  ),
                  SizedBox(height: 8.dp),
                  Text(
                    item.createTime,
                    style: TextStyle(
                      color: darkGreyColor,
                      fontSize: 24.dp,
                    ),
                  ),
                ],
              ),

              const Expanded(child: SizedBox()),

              // Text("..."),
            ],
          ),
          SizedBox(height: 20.dp),

          /// 内容
          Text(
            item.content,
            style: TextStyle(
              fontSize: 30.dp,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

          SizedBox(height: 20.dp),

          /// 图片展示
          imgList(item),

          SizedBox(height: 20.dp),

          /// 回复
          Visibility(
            visible: item.replyContent.isNotEmpty,
            child: Container(
              padding: EdgeInsets.all(12.dp),
              color: blackGrey,
              child: Text(
                "回复：${item.replyContent}",
                style: TextStyle(
                  fontSize: 24.dp,
                  color: greyColor,
                ),
              ),
            ),
          ),

          SizedBox(height: 40.dp),

          /// 下划线
          Divider(
            height: 1.dp,
            thickness: 1.dp,
            color: const Color.fromRGBO(44, 48, 47, 1),
          ),
        ],
      ),
    );
  }
}
