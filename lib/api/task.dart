import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/task/DailyTask.dart';
import 'package:quanda/model/task/RecommendTask.dart';
import 'package:quanda/model/task/TaskInfo.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'dart:convert';

/// 任务 的接口仓库
class TaskRequest {
  /// 任务中心信息
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static taskCoreInfo({
    Success<TaskInfo>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/task/taskCoreInfo", null,
        loading: loading, toast: toast, success: (data) async {
      TaskInfo value = TaskInfo.fromJson(data);

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

  /// 日常任务信息
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static dailyTaskInfo({
    Success<List<DailyTask>>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/task/dailyTaskInfo", null,
        loading: loading, toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      List<DailyTask> list = [];

      for (int i = 0; i < data.length; i++) {
        list.add(DailyTask.fromJson(data[i]));
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

  /// 推荐任务
  /// [lon] 经度
  /// [lat] 纬度
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static recommendTaskList({
    required String lon,
    required String lat,
    Success<List<RecommendTask>>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/task/recommendTaskList",
        {
          "lon": lon,
          "lat": lat,
        },
        loading: loading,
        toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      List<RecommendTask> list = [];

      for (int i = 0; i < data.length; i++) {
        list.add(RecommendTask.fromJson(data[i]));
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

  /// 限时签到领红包
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static signRedPackage({
    Success<dynamic>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/task/signRedPackage", null,
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

  /// 收益明细列表
  /// [type] 1=金币收益 2=现金收益
  /// [page] 分页页码，数字类型
  /// [pageSize] 分页大小
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static profitList({
    required int type,
    int pageSize = 10,
    int page = 1,
    Success<LongList>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/task/profitList",
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
}
