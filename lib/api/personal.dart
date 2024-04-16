import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/personal/ConfirmInfo.dart';
import 'package:quanda/model/personal/PrivacyInfo.dart';

/// 个人中心 的接口仓库
class PersonalRequest {
  /// 收藏列表
  /// [type] 类型 0=全部 1=动态 2=广播 3=任务 4=闲置
  /// [page] 分页页码，数字类型
  /// [pageSize] 分页大小
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static collectList({
    required int type,
    int pageSize = 20,
    int page = 1,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/collectList",
        {
          "page": page,
          "pageSize": pageSize,
          "type": type,
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

  /// 删除收藏(支持批量)
  /// [ids] id数组
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static collectDel({
    required List<int> ids,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/collectDel",
        {
          "ids": ids,
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

  /// 账单列表
  /// [time] 日期年月  "2022-05"
  /// [listPage] 分页页码，数字类型
  /// [listPageSize] 分页大小
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static accountList({
    required String time,
    int listPageSize = 20,
    int listPage = 1,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/accountList",
        {
          "listPage": listPage,
          "listPageSize": listPageSize,
          "time": time,
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

  /// 关注和粉丝列表
  /// [type] 1=查看关注  2=查看粉丝
  /// [pageSize] 每页大小
  /// [page] 分页页码，数字类型
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static followList({
    required int type,
    int pageSize = 10,
    int page = 1,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/followList",
        {
          "type": type,
          "page": page,
          "pageSize": pageSize,
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

  /// 确认订单信息
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static confirmOrderInfo({
    required int id,
    Success<ConfirmInfo>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/confirmOrderInfo",
        {
          "id": id,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      ConfirmInfo value = ConfirmInfo.fromJson(data);

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

  /// 获取二维码使用权限
  /// [key] qrcode_status  二维码 nearby_status  附近推荐 sex_status 是否隐藏性别
  /// age_status 是否隐藏年龄  address_status 是否显示地区   home_share_status 个人主页是否允许分享
  /// content_share_status 内容是否允许分享 search_status 搜索是否开启
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static getSettingItem({
    required String key,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/getSettingItem",
        {
          "key": key,
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

  /// 获取用户的隐私信息
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static userSettingInfo({
    Success<Map<String, dynamic>>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/api/userSettingInfo", null,
        loading: loading, toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      PrivacyInfo value = PrivacyInfo.fromJson(data);

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

  /// 用户隐私保存
  /// [map] 参数
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static userSettingSave({
    required Map<String, dynamic> map,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>("/api/userSettingSave", map,
        loading: loading, toast: toast, success: (data) async {
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

  /// 建议反馈添加
  /// [content] 反馈内容
  /// [mobile] 手机号码
  /// [imageId] 图片列表id (注意图片最多9张)
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static feedBackSave({
    required String content,
    required String mobile,
    required List<int> imageId,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/feedBackSave",
        {
          "content": content,
          "mobile": mobile,
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

  /// 删除反馈
  /// [id] id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static feedBackDel({
    required int id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/feedBackDel",
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

  /// 建议反馈列表
  /// [pageSize] 每页大小
  /// [page] 分页页码，数字类型
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static feedBackList({
    int pageSize = 10,
    int page = 1,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/feedBackList",
        {
          "page": page,
          "pageSize": pageSize,
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
}
