import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/photo_Gallery.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

/// 左边聊天框
class LeftChatBox extends StatelessWidget {
  const LeftChatBox({Key? key, required this.data}) : super(key: key);

  /// 聊天数据
  final V2TimMessage? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.dp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 头像
          ClipRRect(
            borderRadius: BorderRadius.circular(40.dp),
            child: CachedImage(
              imgUrl: data?.faceUrl == ""
                  ? "${RequestApi.baseUrl}/api/static/boy.png"
                  : data?.faceUrl ?? "${RequestApi.baseUrl}/api/static/boy.png",
              width: 80.dp,
              height: 80.dp,
            ),
          ),

          SizedBox(width: 20.dp),

          /// 文本消息
          Visibility(
            visible: data?.textElem != null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 15.dp),

              /// 约束最大宽度
              constraints: BoxConstraints(
                maxWidth: 476.dp,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(38, 39, 44, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.dp),
                  bottomRight: Radius.circular(20.dp),
                  topRight: Radius.circular(20.dp),
                  topLeft: Radius.circular(4.dp),
                ),
              ),
              child: Text(
                data?.textElem?.text ?? "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.dp,
                ),
              ),
            ),
          ),

          /// 图片消息
          Visibility(
            visible: data?.imageElem != null,
            child: GestureDetector(
              onTap: () => {
                Get.to(
                  PhotoView(
                    imageProvider:
                        NetworkImage(data?.imageElem?.imageList?[0]?.url ?? ""),
                  ),
                ),
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.dp),
                child: CachedImage(
                  imgUrl: data?.imageElem?.imageList?[0]?.url ?? "",
                  width: 200.dp,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
