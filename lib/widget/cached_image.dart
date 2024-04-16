import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 缓存网络图片
class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.width,
    this.height,
    required this.imgUrl,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  /// 图片宽度
  final double width;

  /// 图片高度
  final double? height;

  /// 图片地址
  final String imgUrl;

  /// 图片放入模式
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,

      /// 占位符   CircularProgressIndicator  创建循环进度指示器。
      // progressIndicatorBuilder: (context, url, downloadProgress) =>
      //     CircularProgressIndicator(value: downloadProgress.progress, color: paleGreenColor),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: width,
      height: height,
      fit: fit,
    );
  }
}
