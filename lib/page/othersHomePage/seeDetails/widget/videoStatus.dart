import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:video_player/video_player.dart';
import '../logic.dart';
import '../state.dart';

/// 视频状态
class VideoStatus extends StatelessWidget {
  const VideoStatus({Key? key, required this.state, required this.logic})
      : super(key: key);

  /// 逻辑层
  final SeeDetailsLogic logic;

  /// 数据层
  final SeeDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedImage(
          imgUrl: state.details.mediaList[0].fileVideoPath ?? "",
          width: 750.dp,
          height: 750.dp,
          fit: BoxFit.cover,
        ),

        /// 播放键
        Positioned(
          width: 750.dp,
          height: 750.dp,
          child: GestureDetector(
            onTap: logic.goToVideoPreview,
            behavior: HitTestBehavior.translucent,
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
      ],
    );
  }
}
