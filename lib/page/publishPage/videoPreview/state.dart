import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// 发布闲置 的数据层
class VideoPreviewState {

  /// 视频播放控制器
  late VideoPlayerController video;

  /// 初始化 构造函数
  VideoPreviewState() {
    video = VideoPlayerController.network("");
  }
}
