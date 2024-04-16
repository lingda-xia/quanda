import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'request_api.dart';

/// 请求接口管理
import 'http_request.dart';

/// dio请求实例
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// loading

/// 使用此方法
/// Request.get("/login",{"userName": 'admin', "pwd": '123456'} ,success: (data) {
///
/// } , fail: (code , msg){
///
/// });
///
/// @description :请求发起
class Request {
  /// 发起GET请求
  /// [url] 请求url
  /// [data] 请求参数
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static Future get<T>(
    String url,
    dynamic data, {
    bool loading = true,
    bool toast = true,
    Success<T>? success,
    Fail? fail,
  }) async {
    await _request(Method.GET, url, data,
        loading: loading, toast: toast, success: success, fail: fail);
  }

  /// 发起POST请求
  /// [url] 请求url
  /// [data] 请求参数
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static Future post<T>(
    String url,
    dynamic data, {
    bool loading = true,
    bool toast = true,
    Success<T>? success,
    Fail? fail,
  }) async {
    await _request(Method.POST, url, data,
        loading: loading, toast: toast, success: success, fail: fail);
  }

  /// 发起请求
  /// [method] 请求类型
  /// [url] 请求url
  /// [data] 请求参数
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  static Future _request<T>(
    Method method,
    String url,
    dynamic data, {
    bool loading = true,
    bool toast = true,
    Success<T>? success,
    Fail? fail,
  }) async {
    /// 是否打开loading
    if (loading) {
      ///  Get.isDialogOpen 检查对话框是否打开
      if (Get.isDialogOpen != null && Get.isDialogOpen!) {
        Get.back();
      }

      /// 打开loading
      Get.dialog(
        /// loading 组件
        const SpinKitSpinningLines(
          color: Colors.white,
          size: 50,
        ),

        /// 打开蒙层
        barrierDismissible: false,
      );
    }
    debugPrint("请求的地址是 ==============> ${RequestApi.baseUrl}$url");

    /// 开启请求
    HttpRequest.request(method, url, data, success: (res) {
      /// 请求成功之后关闭loading
      if (loading) {
        if (Get.isDialogOpen != null && Get.isDialogOpen!) {
          Get.back();
        }
      }

      /// 显示提示框
      if (toast) {
        /// 自定义提示框
        CustomToast.showToast(res.message, const Color.fromRGBO(104, 210, 188, 1));
      }
      if (success != null) {
        debugPrint("request success 请求成功 =======>${res}");
        success(res.data);
      }
    }, fail: (code, msg) {
      debugPrint("code ===>$code 请求失败 =======>$msg");

      /// 请求失败之后关闭loading
      if (loading) {
        if (Get.isDialogOpen != null && Get.isDialogOpen!) {
          Get.back();
        }
      }

      /// 显示提示框  自定义
      CustomToast.showToast(msg, const Color.fromRGBO(255, 77, 96, 1));

      /// 并将错误返回
      if (fail != null) {
        fail(code, msg);
      }
    });
  }
}
