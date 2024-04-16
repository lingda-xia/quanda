import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:quanda/model/ImgEntity.dart';

/// 多图片选择器
class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  /// 加载器
  final LoadingBuilder? loadingBuilder;
  /// 背景修饰器
  final BoxDecoration? backgroundDecoration;
  /// 最小缩放
  final dynamic minScale;
  /// 最大缩放
  final dynamic maxScale;
  /// 选择的图片下标
  final int initialIndex;
  /// 控制器
  final PageController pageController;
  /// 图片列表
  final List<ImgEntity> galleryItems;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              /// 允许滚动偏移超出内容边界但随后将内容反弹回这些边界边缘的环境的滚动物理。
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              /// 加载
              loadingBuilder: widget.loadingBuilder,
              /// 背景修饰器
              backgroundDecoration: widget.backgroundDecoration,
              /// 控制器
              pageController: widget.pageController,
              /// 当图片切换之后触发
              onPageChanged: onPageChanged,
            ),
          ],
        ),
      ),
    );
  }

  /// 图片渲染
  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final ImgEntity item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.filePath),
      /// 初始缩放
      initialScale: PhotoViewComputedScale.contained,
      /// 最小缩放
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      /// 最大缩放
      maxScale: PhotoViewComputedScale.covered * 4.1,
      /// 英雄动画
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
