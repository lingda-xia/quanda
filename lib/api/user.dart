import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/user/OrderInfo.dart';
import 'package:quanda/model/user/PersonalDataInfo.dart';
import 'package:quanda/model/user/PersonalInfo.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'dart:convert';

/// 用户 的接口仓库
class UserRequest {
  /// 获取个人信息
  /// [data] 参数 token
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static getUserInfo({
    Success<UserInfo>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) async {
    /// 发起请求
    await Request.post<dynamic>("/api/userInfo", {},
        loading: loading, toast: toast, success: (data) async {
      print("获取到的用户信息======> $data");

      UserInfo userInfo = UserInfo.fromJson(data);

      /// 保存用户信息
      await SpUtil.saveUserInfo(userInfo);

      if (success != null) {
        /// 请求成功回调
        success(userInfo);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 用户信息保存
  /// [nickname] 名称
  /// [sex] 性别
  /// [birthday] 生日
  /// [address] 地址信息
  /// [avatarUrl] 头像
  /// [introduction] 简介
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static userInfoSave({
    required String nickname,
    required int sex,
    required String birthday,
    required String address,
    required String avatarUrl,
    required String introduction,
    bool save = true,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/userInfoSave",
        {
          "nickname": nickname,
          "sex": sex,
          "birthday": birthday,
          "address": address,
          "avatarUrl": avatarUrl,
          "introduction": introduction,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("修改用户信息成功======> $data");

      /// 是否要请求用户信息并保存
      if(save) {
        /// 请求用户的信息
        await getUserInfo(
          loading: loading,
        );
      }

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

  /// 个人主页信息
  /// [userId] 用户id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static personHomePage({
    required dynamic userId,
    Success<PersonalInfo>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/personHomePage",
        {
          "userId": userId,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("用户信息======> $data");

      PersonalInfo value = PersonalInfo.fromJson(data);

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

  /// 创建订单
  /// [type] 3=任务 4=闲置
  /// [id] id
  /// [doTask] 任务订单有奖励金币时传来 "doTask"
  /// [deliveryId] 闲置收货id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static orderSave({
    required int type,
    required int id,
    String? doTask,
    int? deliveryId,
    Success<OrderInfo>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/orderSave",
        {
          "type": type,
          "id": id,
          "doTask": doTask,
          "deliveryId": deliveryId,
        },
        loading: loading,
        toast: toast, success: (data) async {
      OrderInfo value = OrderInfo.fromJson(data);

      print("接口仓库的请求返回${data}");

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

  /// 统一支付
  /// [module] release = 广播任务支付   orderPay = 订单支付
  /// [payType] 支付类型 1=微信支付  2=支付宝支付 3=余额支付
  /// [payId] 支付id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static pay({
    required String module,
    required int payType,
    required String payId,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/pay",
        {
          "module": module,
          "payType": payType,
          "payId": payId,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("支付成功======> $data");

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

  /// 个人资料信息
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static personDateInfo({
    Success<PersonalDataInfo>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/api/personDateInfo", null,
        loading: loading, toast: toast, success: (data) async {
      print("个人资料信息======> $data");

      PersonalDataInfo value = PersonalDataInfo.fromJson(data);

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
}
