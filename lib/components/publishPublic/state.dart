import 'package:flutter/material.dart';
import 'package:quanda/http/request_api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/location/SearchResult.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:video_player/video_player.dart';

/// 发布公用部分 的数据层
class PublishPublicState {
  /// 标题 输入框控制器
  late TextEditingController titleController;

  /// 内容 输入框控制器
  late TextEditingController contentController;

  /// 标题聚焦
  late FocusNode focusNode;

  /// 内容聚焦
  late FocusNode cFocusNode;

  /// 是否保存过草稿
  late bool saved;

  /// 标题
  late String title;

  /// 内容
  late String content;

  /// 图片选择器
  late ImagePicker picker;

  /// 视频播放控制器
  late VideoPlayerController video;

  /// 图片列表
  late List<ImgEntity> galleryItems;

  /// 选择的是图片还是视频 或者没选择  0 未选择 1 选择图片 2 选择视频
  late int status;

  /// 接口所需的图片id列表
  late List<String> idList;

  /// 定位信息
  /// [name] 详细信息
  /// [street]大街
  /// [country] 国家
  /// [province] 省份
  /// [city] 城市
  /// [district] 区县
  /// [latitude] 经度
  /// [longitude] 纬度
  late Address address;

  /// 显示的位置
  late String displayedLocation;

  /// 显示位置的经纬度
  late String positional;

  /// 选择返回的地址
  late SearchResult returnedAddress;

  /// 初始化 构造函数
  PublishPublicState() {
    saved = false;
    title = "";
    content = "";
    titleController = TextEditingController();
    contentController = TextEditingController();
    picker = ImagePicker();
    galleryItems = [];
    video = VideoPlayerController.network("");
    idList = [];
    status = 0;
    focusNode = FocusNode();
    cFocusNode = FocusNode();
    address = Address("", "", "", "", "", "", 0, 0, "");
    displayedLocation = "";
    returnedAddress = SearchResult(

        /// 区
        district: '',

        /// 店名
        name: '',

        /// 城市名字
        city: '',

        /// 地址
        address: '',

        /// 经纬度
        location: '',

        /// 距离 m
        distance: '');
  }
}
