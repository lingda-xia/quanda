import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'state.dart';

/// 发布闲置 的逻辑层
class VideoPreviewLogic extends GetxController {
  VideoPreviewState state = VideoPreviewState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    state.video = VideoPlayerController.network(Get.arguments)
      ..initialize().then((_) {
        update();
      });
  }

  @override
  void onClose() {
    super.onClose();
    state.video.dispose();
  }

  /// 播放或者暂停
  playOrPause() {
    state.video.value.isPlaying ? state.video.pause() : state.video.play();
    update();
  }
}
