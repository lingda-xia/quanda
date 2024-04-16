import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/publish/DetailsEntity.dart';
import 'package:quanda/model/publish/IdleDetail.dart';

/// 发布 的接口仓库
class PublishRequest {
  /// 发布任务
  /// [title] 标题
  /// [address] 地址名称
  /// [lon] 经度
  /// [lat] 纬度
  /// [content] 正文内容
  /// [media] 媒体列表
  /// [payMoney] 需要支付的总金额
  /// [rangeKm] 多少公里数可看
  /// [broadcastTime] 广播时长
  /// [taskType] 任务类型 1=到店奖励 2= 一起玩耍
  /// [sex] 性别要求 0 =男女不限  1=男 2=女
  /// [personNumber] 任务所需人数
  /// [finishMoney] 任务完成后每人可获取奖励
  /// [taskTime] 任务需要停留时间(单位分钟)
  /// [goldType] 金币奖励类型:任务
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static publishTask({
    required String title,
    required String address,
    required String lon,
    required String lat,
    required String content,
    required List<String> media,
    required double payMoney,
    required double rangeKm,
    required double broadcastTime,
    required int taskType,
    required int sex,
    required int personNumber,
    required int finishMoney,
    required int taskTime,
    required String goldType,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/release",
        {
          /// 发布任务 类型为3
          "type": 3,
          "title": title,
          "address": address,
          "lon": lon,
          "lat": lat,
          "content": content,
          "media": media,
          "payMoney": payMoney,
          "rangeKm": rangeKm,
          "broadcastTime": broadcastTime,
          "taskType": taskType,
          "sex": sex,
          "personNumber": personNumber,
          "finishMoney": finishMoney,
          "taskTime": taskTime,
          "goldType": goldType,
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

  /// 发布广播
  /// [title] 标题
  /// [address] 地址名称
  /// [lon] 经度
  /// [lat] 纬度
  /// [content] 正文内容
  /// [media] 媒体列表
  /// [payMoney] 需要支付的总金额
  /// [rangeKm] 多少公里数可看
  /// [broadcastTime] 广播时长
  /// [goldType] 金币奖励类型: 广播
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static publishBroadcast({
    required String title,
    required String address,
    required String lon,
    required String lat,
    required String content,
    required List<String> media,
    required double payMoney,
    required double rangeKm,
    required double broadcastTime,
    required String goldType,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/release",
        {
          /// 发布广播 类型为2
          "type": 2,
          "title": title,
          "address": address,
          "lon": lon,
          "lat": lat,
          "content": content,
          "media": media,
          "payMoney": payMoney,
          "rangeKm": rangeKm,
          "broadcastTime": broadcastTime,
          "goldType": goldType,
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

  /// 发布瞬间
  /// [title] 标题
  /// [address] 地址名称
  /// [lon] 经度
  /// [lat] 纬度
  /// [content] 正文内容
  /// [media] 媒体列表
  /// [goldType] 金币奖励类型: 瞬间
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static publishDynamic({
    required String title,
    required String address,
    required String lon,
    required String lat,
    required String content,
    required List<String> media,
    required String goldType,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/release",
        {
          /// 发布瞬间 类型为1
          "type": 1,
          "title": title,
          "address": address,
          "lon": lon,
          "lat": lat,
          "content": content,
          "media": media,
          "goldType": goldType,
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

  /// 发布闲置
  /// [title] 标题
  /// [address] 地址名称
  /// [lon] 经度
  /// [lat] 纬度
  /// [content] 正文内容
  /// [media] 媒体列表
  /// [payMoney] 需要支付的总金额
  /// [extractType] 提取方式 1=上门自提 2=我出邮费 3=你出邮费
  /// [deliveryId] 上门自提需要 提货地址id
  /// [goldType] 金币奖励类型: 闲置
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static publishSetAside({
    required String title,
    required String address,
    required String lon,
    required String lat,
    required String content,
    required List<String> media,
    required int payMoney,
    required int extractType,
    required int deliveryId,
    required String goldType,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/release",
        {
          /// 发布闲置 类型为4
          "type": 4,
          "title": title,
          "address": address,
          "lon": lon,
          "lat": lat,
          "content": content,
          "media": media,
          "payMoney": payMoney,
          "extractType": extractType,
          "deliveryId": deliveryId,
          "goldType": goldType,
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

  /// 获取发布列表
  /// [userId] 用户id
  /// [type] 类型 0=全部 1=动态 2=广播 3=任务 4=闲置
  /// [page] 页页码，数字类型
  /// [pageSize] 分页条数 ，数字类型
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static getReleaseList({
    required int type,
    int? userId,
    int page = 1,
    int pageSize = 20,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/releaseList",
        {
          "userId": userId,
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

  /// 查看详情
  /// [id] 发布id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static seeDetails({
    required int id,
    Success<DetailsEntity>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>(
        "/api/releaseInfo",
        {
          "id": id,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回$data");
      print("接口仓库的请求返回的用户信息${data["userInfo"]}");
      DetailsEntity value = DetailsEntity.fromJson(data);

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

  /// 点赞发布
  /// [id] 发布id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static giveRelease({
    required int id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>(
        "/api/giveRelease",
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

  /// 收藏发布
  /// [id] 发布id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static collectRelease({
    required int id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>(
        "/api/collectRelease",
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

  /// 评论发布
  /// [id] 发布id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static commentRelease({
    required int id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>(
        "/api/commentRelease",
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

  /// 点赞颜值
  /// [userId] 用户id
  /// [status] 1=高颜值 2=傻呆呆
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static appearanceSave({
    required String userId,
    required int status,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/appearanceSave",
        {
          "userId": userId,
          "status": status,
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
