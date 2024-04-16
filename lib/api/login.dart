import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'dart:convert';

/// 登录的接口仓库
class LoginRequest {
  /// 密码登录
  /// [phone] 账号
  /// [password] 密码   密码登录
  /// [smsCode] 验证码  验证码登录
  /// [loginKey] 验证码  一键登录
  /// [type] 登录类型1=手机验证码登陆2=一键登陆3=账号密码登陆
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static login({
    required int type,
    required String phone,
    String? password,
    String? smsCode,
    String? loginKey,
    Success<String>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/login",
        {
          "type": type,
          "phone": phone,
          "password": password,
          "smsCode": smsCode,
          "loginKey": loginKey,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${jsonEncode(data)}");

      /// jsonEncode 转换object为 JSON 字符串。
      var value = jsonEncode(data);

      /// 保存token
      await SpUtil.saveToken(value);

      if (success != null) {
        /// 请求成功回调
        success(value);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 短信验证码
  /// [phone] 手机号码
  /// [type] 1=手机登录验证码 2=注销账号3=短信修改密码或找回密码4=修改手机号
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static getSmsCode({
    required String phone,
    required int type,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/getSmsCode",
        {
          "type": type,
          "phone": phone,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      if (success != null) {
        /// 请求成功回调
        success(data);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 检验短信验证码
  /// [phone] 手机号码
  /// [code] 验证码
  /// [type] 1=手机登录验证码 2=注销账号3=短信修改密码或找回密码4=修改手机号
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static smsCheck({
    required String phone,
    required String code,
    required int type,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/smsCheck",
        {
          "type": type,
          "code": code,
          "phone": phone,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      if (success != null) {
        /// 请求成功回调
        success(data);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 检测手机号
  /// [phone] 手机号码
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static authPhone({
    required String phone,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>(
        "/api/authPhone",
        {
          "phone": phone,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      if (success != null) {
        /// 请求成功回调
        success(data);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 修改手机号
  /// [phone] 手机号码
  /// [smsCode] 验证码
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static editPhone({
    required String phone,
    required String smsCode,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.get<dynamic>(
        "/api/editPhone",
        {
          "phone": phone,
          "smsCode": smsCode,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      if (success != null) {
        /// 请求成功回调
        success(data);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 设置密码(修改密码)
  /// [phone] 手机号
  /// [smsCode] 验证码
  /// [password] 密码
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static editPass({
    required String phone,
    required String smsCode,
    required String password,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/editPass",
        {
          "phone": phone,
          "smsCode": smsCode,
          "password": password,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      if (success != null) {
        /// 请求成功回调
        success(data);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 找回密码
  /// [phone] 手机号
  /// [smsCode] 验证码
  /// [password] 密码
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static retrievePassword({
    required String phone,
    required String smsCode,
    required String password,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/retrievePass",
        {
          "phone": phone,
          "smsCode": smsCode,
          "password": password,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      if (success != null) {
        /// 请求成功回调
        success(data);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 注销账号
  /// [reason] 注销原因
  /// [imageId] 图片id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static logoutUser({
    required String reason,
    int? imageId,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/logoutUser",
        {
          "reason": reason,
          "imageId": imageId,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      if (success != null) {
        /// 请求成功回调
        success(data);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }
}
