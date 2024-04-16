import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/photo_Gallery.dart';
import '../logic.dart';
import '../state.dart';

///图片状态
class ImgStatus extends StatelessWidget {
  const ImgStatus({Key? key, required this.state, required this.logic})
      : super(key: key);

  /// 逻辑层
  final SeeDetailsLogic logic;

  /// 数据层
  final SeeDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 180.dp, left: 30.dp, right: 30.dp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.dp),
               /// 延迟构建
        child: FutureBuilder<String>(
          future: Future.delayed(const Duration(milliseconds: 500), () => ""),
          builder: (context, v) {
            if(v.hasData) {
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  /// 点击预览图片
                  return GestureDetector(
                    onTap: () => {
                      Get.to(
                        /// 多图片选择器  自定义widget
                        GalleryPhotoViewWrapper(
                          /// 图片列表
                          galleryItems: state.details.mediaList,

                          /// 选择的当前图片下标
                          initialIndex: index,

                          /// 背景修饰器
                          backgroundDecoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    },
                    child: CachedImage(
                      imgUrl: state.details.mediaList[index].filePath,
                      width: 150.dp,
                      height: 150.dp,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: state.details.mediaList.length,

                /// 自动播放
                autoplay: true,
                index: 0,
                controller: state.controller,
                pagination: const SwiperPagination(
                  margin: EdgeInsets.all(10),
                  builder: DotSwiperPaginationBuilder(
                    color: greyColor,
                    activeColor: paleGreenColor,
                    size: 7,
                    activeSize: 7,
                  ),
                ),
                // control: SwiperControl(),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
