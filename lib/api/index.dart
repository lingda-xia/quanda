import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/LongList.dart';

/// 首页 的接口仓库
class IndexRequest {
  /// 首页推荐列表
  /// [lat] 纬度
  /// [lon] 经度
  /// [type] 类型  全部传0 或不传 1=动态 2=广播 3=任务 4=闲置
  /// [pageSize] 每页大小
  /// [page] 分页页码，数字类型
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static homePageDataList({
    required String lat,
    required String lon,
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
        "/api/homePageDataList",
        {
          "lat": lat,
          "lon": lon,
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

  /// 首页搜索列表
  /// [lat] 纬度
  /// [lon] 经度
  /// [type] 0=用户 1=互动
  /// [keyword] 搜索关键字
  /// [pageSize] 每页大小
  /// [page] 分页页码，数字类型
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static homePageSearchList({
    required String lat,
    required String lon,
    required int type,
    required String keyword,
    int pageSize = 10,
    int page = 1,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/api/homePageSearchList",
        {
          "lat": lat,
          "lon": lon,
          "type": type,
          "keyword": keyword,
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
