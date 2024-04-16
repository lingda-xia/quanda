import 'package:flutter/material.dart';

/// 好友的数据层
class FriendsState {
  /// 好友列表
  late List<Friends> friendsList;

  /// 初始化 构造函数
  FriendsState() {
    /// 好友列表
    friendsList = [
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/women/27.jpg',
          name: 'Lina',
          indexLetter: 'L'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/women/17.jpg',
          name: '菲儿',
          indexLetter: 'F'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/women/16.jpg',
          name: '安莉',
          indexLetter: 'A'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/men/31.jpg',
          name: '阿贵',
          indexLetter: 'A'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/women/22.jpg',
          name: '贝拉',
          indexLetter: 'B'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/women/37.jpg',
          name: 'Lina',
          indexLetter: 'L'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/men/31.jpg',
          name: '阿贵',
          indexLetter: 'A'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/women/22.jpg',
          name: '贝拉',
          indexLetter: 'B'),
      Friends(
          imageUrl: 'https://randomuser.me/api/portraits/women/37.jpg',
          name: 'Lina',
          indexLetter: 'L'),
    ];
  }
}

/// model
class Friends {
  final String imageUrl; // 图片 URL
  final String name; // 好友名称
  final String indexLetter; // 索引字母(组头)
  late bool isChecked;
  //构造方法
  Friends({required this.imageUrl,required this.name,required this.indexLetter, this.isChecked = false});
}
