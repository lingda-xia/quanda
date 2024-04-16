import 'package:flutter/material.dart';
import 'dart:ui';

/// @description :页面适配
class ScreenAdapt {
  // 屏幕参数获取api
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(window);
  static double? screenWidth; //设备屏幕宽度width
  static double? screenHeight; //设备屏幕高度height
  static double? topHeight; //顶部空白高度
  static double? bottomHeight; //底部空白高度
  static double devicePixelRatio = mediaQuery.devicePixelRatio; //分辨比
  static var screenRatio; //屏幕宽比

  //初始化
  static initialize() {
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    int uiWidth = 750;        // ui设计图
    screenRatio = screenWidth! / uiWidth; //屏幕宽比  设备宽度 : ui设计图宽度
  }

  //实际填写长度
  static px(number) {
    if (!(screenRatio is double || screenRatio is int)) {
      ScreenAdapt.initialize();
    }
    return number * screenRatio; //返回处理好的长度数值
  }

  //获取设备屏幕宽度
  static getWidth() {
    screenWidth = mediaQuery.size.width;
    return screenWidth;
  }

  //获取设备屏幕高度
  static getHeight() {
    screenHeight = mediaQuery.size.height;
    return screenHeight;
  }

  //获取设备顶部空白高度
  static getTopHeight() {
    topHeight = mediaQuery.padding.top;
    return topHeight;
  }

  //获取设备底部空白高度
  static getBottomHeight() {
    bottomHeight = mediaQuery.padding.bottom;
    return bottomHeight;
  }
}

extension SizeExtension on num {
  double get dp => ScreenAdapt.px(this);
}
