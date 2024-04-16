import 'package:flutter/material.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 通讯录列表的数据层
class AddressListState {

  /// 滚动控制器
  final ScrollController scrollController = ScrollController();

  // ignore: constant_identifier_names
  List<String> INDEX_WORDS = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '#'
  ];

  ///
  double indicatorY = 0.0;
  /// 是否隐藏指示器
  bool indicatorHidden = true;
  /// 当前选择的组名
  String indicatorText = 'A';
  /// 当前选中索引的文本颜色
  Color textColor = const Color.fromRGBO(115, 117, 124, 1);
  /// 当前选中索引的背景颜色
  Color backColor = Colors.transparent;

}


