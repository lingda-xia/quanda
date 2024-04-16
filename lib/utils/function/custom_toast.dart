import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 提示框
class CustomToast {
  /// 展示提示框
  static showToast(String msg, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: msg,

      /// 显示的时间长短
      toastLength: Toast.LENGTH_SHORT,

      /// 显示的位置
      gravity: ToastGravity.CENTER,

      /// 适用于 ios 和 web）
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
