import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/personal/ExpressEntity.dart';
import 'package:quanda/model/publish/IdleDetail.dart';

/// 我的发布 的接口仓库
class InteractionRequest {
  /// 主动结束任务
  /// [id] 任务id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static releaseTaskEnd({
    required String id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/releaseTaskEnd",
        {
          "id": id,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回$data");

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

  /// 闲置订单详情
  /// [id] 闲置id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static idleOrderInfo({
    required String id,
    Success<IdleDetail>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>(
        "/api/idleOrderInfo",
        {
          "id": id,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回$data");

      IdleDetail value = IdleDetail.fromJson(data);

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

  /// 任务订单列表
  /// [taskId] 任务id
  /// [page] 分页页码，数字类型
  /// [pageSize] 分页大小
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static taskOrderList({
    required int taskId,
    int pageSize = 20,
    int page = 1,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/taskOrderList",
        {
          "page": page,
          "pageSize": pageSize,
          "taskId": taskId,
        },
        loading: loading,
        toast: toast, success: (data) async {
      LongList value = LongList.fromJson(data);

      print("接口仓库的请求返回${value.toJson()}");

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

  /// 删除互动
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static releaseDel({
    required String id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/releaseDel",
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

  /// 订单核验
  /// [sourceOrderId] 源订单id
  /// [checkCode] 检验code
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static orderCheckSave({
    required int sourceOrderId,
    required String checkCode,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/orderCheckSave",
        {
          "sourceOrderId": sourceOrderId,
          "checkCode": checkCode,
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

  /// 闲置发货
  /// [orderId] 订单id
  /// [expressName] 快递公司名称
  /// [expressId] 快递公司id
  /// [expressNo] 快递单号
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static idleOrderSendGoods({
    required String orderId,
    required String expressName,
    required int expressId,
    required String expressNo,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/idleOrderSendGoods",
        {
          "orderId": orderId,
          "expressName": expressName,
          "expressId": expressId,
          "expressNo": expressNo,
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

  /// 同意退款
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static agreeRefund({
    required String id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/agreeRefund",
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

  /// 拒绝退款
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static refuseRefund({
    required String id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/refuseRefund",
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

  /// 删除订单
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static idleOrderDel({
    required String id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/idleOrderDel",
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

  /// 快递列表
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static expressList({
    Success<List<ExpressEntity>>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/api/expressList", null, loading: loading, toast: toast,
        success: (data) async {
      print("接口仓库的请求返回${data}");

      List<ExpressEntity> list = [];

      for (int i = 0; i < data.length; i++) {
        list.add(ExpressEntity.fromJson(data[i]));
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
}
