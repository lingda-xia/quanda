import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; /// 检测网络状态
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'httpModel.dart';
import 'request_api.dart';                  /// 请求接口管理
import 'http_Error.dart';                   /// 错误消息处理

/// 连接超时时间
const int _connectTimeout = 10000;

/// 接收超时时间
const int _receiveTimeout = 10000;

/// 发送超时时间
const int _sendTimeout = 10000;

/// Dart中一切皆对象，函数也是对象。每个对象都有自己的类型，函数的类型是Function，
/// typedef就是给Function取个别名。
typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

/// @description :dio请求
class HttpRequest {

  /// token
  static late dynamic token;

  ///全局Dia对象
  static Dio? _dio;

  /// 创建dio实例
  static Dio createInstance() {

    /// 请求配置
    var options = BaseOptions(
      /// 提交方式：1.表单提交 2.JSON方式提交
      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]就会自动编码请求体.
      baseUrl: RequestApi.baseUrl,
      sendTimeout: _sendTimeout,            /// 发送超时时间
      connectTimeout: _connectTimeout,      /// 连接超时时间
      receiveTimeout: _receiveTimeout,      /// 接收超时时间
      contentType: Headers.jsonContentType,
      validateStatus: (status) {
        ///“validateStatus”定义对于给定的
        ///HTTP响应状态代码。如果validateStatus返回true，
        ///请求将被视为成功；否则，视为失败。
        ///
        /// 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },

    );
    /// 给予实例
    _dio = Dio(options);
    return _dio!;
  }

  /// 请求，返回参数为 T
  /// [method]：请求方法，Method.POST等
  /// [url]：请求地址
  /// [data]：请求参数
  /// [success]：请求成功回调
  /// [error]：请求失败回调
  static Future request<T>(
    Method method,
    String url,
    dynamic data,
    {
      Success? success,
      required Fail? fail,
    }
  ) async {
    try {
      ///请求前先检查网络连接
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        _onError(HttpError.netError, '网络异常，请检查你的网络！', fail);
        return;
      }
      /// 创建dio实例
      Dio dio = createInstance();

      /// 获取token
      token = await SpUtil.getToken();

      /// 添加拦截器
      dio.interceptors.add(ResponseInterceptor());

      /// token值
      dynamic tokenValue;

      print("token是什么值$token");
      print("data是什么值$data");
      if(token != null){
        tokenValue = jsonDecode(token);
      }
      /// 发起请求
      dio.request(
        url,
        data: _methodValues[method] == "post" ? data : null,
        queryParameters: _methodValues[method] == "get" ? data : null,
        options: Options(
          /// 因为创建实例时无法获取到 method 所以现在在加上
          method: _methodValues[method],
          headers: {
            "token": tokenValue,
          }
        ),
      ).then((response) async {
        /// 请求接口成功
        if(response.data.code == 200){
          if (success != null) {
            /// 返回请求成功的信息
            success(response.data);
          }
        } else {
          if (fail != null) {
            /// 返回请求成功的信息
            fail(response.data.code, response.data.message);
          }
          /// token过期了
          if(response.data.code == 400) {
            /// 删除用户信息
            await SpUtil.deleteUserInfo();
            /// 删除token的值
            await SpUtil.deleteToken();
            /// 进入到登录页面
            Future.delayed(const Duration(milliseconds: 1000), () {
              Get.offAllNamed(RouteConfig.verifyLogin);
            });
          }
        }
      }).catchError((onError){
        print("请求发生了错误 =======>$onError");
        /// 获取错误
        final NetError netError = HttpError.handleException(onError);
        _onError(netError.code, netError.msg, fail);
      }).whenComplete(() {
        print("请求已完成");
      });

    } on DioError catch(e) {
      /// 请求发生未知错误
      final NetError netError = HttpError.handleException(e);
      _onError(netError.code, netError.msg, fail);
      debugPrint("请求出现异常=====>$e");
    }
  }
}

/// 定义一个拦截器
class ResponseInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// 请求的体积过大
    if(response.statusCode == 413) {
      /// 自定义错误
      DioError error = DioError(
        requestOptions: response.requestOptions,
        type: DioErrorType.response,
        response: response,
        error: "文件过大",
      );
      handler.reject(error);
    } else if(response.statusCode == 200) {
      /// 转换
      Result res = Result.fromJson(response.data);
      response.data = res;
      handler.next(response);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('出错了[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    handler.next(err);
  }
}

/// 错误回调
/// [code] 错误代码
/// [msg] 错误信息
/// [fail] 错误回调
void _onError(int code, String msg, Fail? fail) {
  if (code == 0) {
    code = HttpError.unknownError;
    msg = '未知异常';
  }

  /// 返回请求失败
  if (fail != null) {
    fail(code, msg);
  }
}

///请求类型枚举
enum Method { GET, POST, DELETE, PUT, PATCH, HEAD }

///请求类型值
const _methodValues = {
  Method.GET: "get",
  Method.POST: "post",
  Method.DELETE: "delete",
  Method.PUT: "put",
  Method.PATCH: "patch",
  Method.HEAD: "head",
};
