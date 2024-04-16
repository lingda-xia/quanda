import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

/// 聊天页面的顶部tab 提醒
class RemindTabView extends StatelessWidget {
  const RemindTabView({Key? key}) : super(key: key);

  /// 评论列表的item
  Widget commentListItem() {
    /// 手势监控器
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(20.dp),
        margin: EdgeInsets.only(bottom: 20.dp),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(23, 31, 33, 1),
          borderRadius: BorderRadius.circular(10.dp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 头像名称
            Row(
              children: [
                /// 头像
                CachedImage(
                  imgUrl: "${RequestApi.baseUrl}/api/static/boy.png",
                  width: 80.dp,
                  height: 80.dp,
                ),
                SizedBox(width: 16.dp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        /// 名称
                        Text(
                          "南朝一梦",
                          style: TextStyle(
                            fontSize: 30.dp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(223, 226, 235, 1),
                          ),
                        ),
                        SizedBox(
                          width: 8.dp,
                        ),

                        /// 性别图标
                        Image.asset(
                          "img/Icon/xingbienv.png",
                          width: 30.dp,
                          height: 30.dp,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.dp),

                    /// 日期和时间
                    Row(
                      children: [
                        Text(
                          "2022/5/19 15:31 回复了你的评论",
                          style: TextStyle(
                            fontSize: 24.dp,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(115, 117, 124, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 35.dp),

            /// 评论和回复
            SizedBox(
              height: 180.dp,
              child: ListView(
                children: [
                  reply(),
                  comment(),
                  comment(),
                  comment(),
                  comment(),
                ],
              ),
            ),
            SizedBox(height: 30.dp),
            Container(
              width: 88.dp,
              height: 50.dp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(47, 53, 63, 1),
                borderRadius: BorderRadius.circular(10.dp),
              ),
              child: Text(
                "回复",
                style: TextStyle(
                  fontSize: 26.dp,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(223, 226, 235, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 回复
  Widget reply() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "回复：",
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(223, 226, 235, 1),
          ),
        ),
        SizedBox(height: 2.dp),
        Text(
          "成长是一个非常寂寞的过程，有时是因为不会做分数除法有时是走列队的时候手臂的姿势总也摆不对",
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(223, 226, 235, 1),
          ),
        ),
      ],
    );
  }

  /// 评论
  Widget comment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.dp),
        Text(
          "我的评论：",
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(132, 132, 142, 1),
          ),
        ),
        SizedBox(height: 2.dp),
        Text(
          "成长是一个非常寂寞的过程，有时是因为不会做分数除法有时是走列队的时候手臂的姿势总也摆不对",
          style: TextStyle(
            fontSize: 24.dp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(132, 132, 142, 1),
          ),
        ),
        SizedBox(height: 20.dp),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30.dp),
      children: [
        /// 评论列表的item  自定义widget
        commentListItem(),
        commentListItem(),
        commentListItem(),
      ],
    );
  }
}
