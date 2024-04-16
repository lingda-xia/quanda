import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/personal/ReceivingEntity.dart';

/// 收货地址 的接口仓库
class ReceivingRequest {
  /// 收货地址列表
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static userDeliveryList({
    Success<List<ReceivingEntity>>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>("/api/userDeliveryList", {},
        loading: loading, toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      List<ReceivingEntity> list = [];

      for (int i = 0; i < data.length; i++) {
        list.add(ReceivingEntity.fromJson(data[i]));
      }

      if (success != null) {
        /// 请求成功回调
        success(list);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }

  /// 收货地址添加和编辑
  /// [id] 编辑时传的id
  /// [areaAddress] 省市区地址
  /// [address] 详细地址
  /// [contact] 联系人
  /// [phone] 手机号
  /// [defaultStatus] 手机号
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static userDeliverySave({
    required String areaAddress,
    required String address,
    required String contact,
    required String phone,
    required int defaultStatus,
    int? id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/userDeliverySave",
        {
          "id": id,
          "areaAddress": areaAddress,
          "address": address,
          "contact": contact,
          "phone": phone,
          "defaultStatus": defaultStatus,
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

  /// 设置默认收货地址
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static userDeliveryDefault({
    required int id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/userDeliveryDefault",
        {
          "id": id,
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

  /// 获取收货地址信息
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static userDeliveryById({
    required int id,
    Success<ReceivingEntity>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/userDeliveryById",
        {
          "id": id,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      ReceivingEntity value = ReceivingEntity.fromJson(data);

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
