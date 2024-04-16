import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:video_player/video_player.dart';

import 'logic.dart';
import 'state.dart';

/// 视频预览 页面
class VideoPreview extends StatelessWidget {
  VideoPreview({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(VideoPreviewLogic());

  /// 数据层
  final state = Get.find<VideoPreviewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: GetBuilder<VideoPreviewLogic>(
        builder: (_) {
          return Center(
            child: Hero(
              tag: "video",
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// 视频播放器
                  state.video.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: state.video.value.aspectRatio,

                          /// 点击屏幕可暂停
                          child: GestureDetector(
                            onTap: logic.playOrPause,
                            child: VideoPlayer(
                              state.video,
                            ),
                          ),
                        )
                      : Container(),

                  /// 播放键
                  state.video.value.isInitialized
                      ? Positioned(
                          child: GetBuilder<VideoPreviewLogic>(builder: (_) {
                            return state.video.value.isPlaying
                                ? const SizedBox()
                                : GestureDetector(
                                    onTap: logic.playOrPause,
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 80,
                                    ),
                                  );
                          }),
                        )
                      : Container(),

                  /// 进度条
                  state.video.value.isInitialized
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 10,
                            child: VideoProgressIndicator(
                              state.video,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: paleGreenColor,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
