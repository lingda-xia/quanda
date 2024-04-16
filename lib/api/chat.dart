import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/model/chat/LabelEntity.dart';
import 'package:quanda/model/chat/NoticeEntity.dart';
import 'package:quanda/model/user/OthersInfo.dart';
import 'package:quanda/utils/save/sp_util.dart';

/// 聊天 的接口仓库
class ChatRequest {
  /// 通知信息列表
  /// [page] 分页页码，数字类型
  /// [pageSize] 分页大小
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static systemMsgList({
    int page = 1,
    int pageSize = 20,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/systemMsgList",
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

  /// 获取系统通知
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static systemMsgInfo({
    Success<NoticeEntity>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/chat/systemMsgInfo", null,
        loading: loading, toast: toast, success: (data) async {
      print("接口仓库的请求返回${data}");

      NoticeEntity value = NoticeEntity.fromJson(data);

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

  /// 获取聊天用户密钥
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static getUserSig({
    Success<String>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/chat/getUserSig", null,
        loading: loading, toast: toast, success: (data) async {
      /// 保存token
      await SpUtil.saveUserSig(data);

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

  /// 好友申请
  /// [toUserId] 对方id
  /// [source] 来源
  /// [info] 申请时写的信息"
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static friendApply({
    required String toUserId,
    required String source,
    required String info,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/friendApply",
        {
          "toUserId": toUserId,
          "source": source,
          "info": info,
        },
        loading: loading,
        toast: toast, success: (data) async {
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

  /// 查看用户信息
  /// [userId] 对方id
  /// [source] 来源
  /// [type] 1=被加的 2=我加的 其他为普通查看
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static seeUserInfo({
    required String userId,
    required String source,
    required int type,
    Success<OthersInfo>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/seeUserInfo",
        {
          "userId": userId,
          "source": source,
          "type": type,
        },
        loading: loading,
        toast: toast, success: (data) async {
      OthersInfo value = OthersInfo.fromJson(data);
      print("这是查看用户数据${value.toJson()}");

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

  /// 修改好友描述和备注
  /// [toDesc] 好友描述
  /// [remarkName] 好友备注
  /// [toUserId] 对方id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static friendEditBy({
    required String toDesc,
    required String remarkName,
    required String toUserId,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
      "/chat/friendEditBy",
      {
        "toDesc": toDesc,
        "remarkName": remarkName,
        "toUserId": toUserId,
      },
      loading: loading,
      toast: toast,
      success: (data) async {
        if (success != null) {
          /// 请求成功回调
          success(data);
        }
      },
      fail: (code, msg) {
        if (fail != null) {
          /// 请求失败回调
          fail(code, msg);
        }
      },
    );
  }

  /// 聊天数据保存
  /// [data] 需要保存的数据
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static chatSave({
    required Map<String, dynamic> data,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>("/chat/chatSave", data,
        loading: loading, toast: toast, success: (data) async {
      print("聊天保存返回${data}");

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

  /// 同意验证好友
  /// [toUserId] 对方id
  /// [remarkName] 备注名称
  /// [tagId] 标签id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static agreeFriend({
    required String toUserId,
    String? remarkName,
    String? tagId,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/agreeFriend",
        {
          "toUserId": toUserId,
          "remarkName": remarkName,
          "tagId": tagId,
        },
        loading: loading,
        toast: toast, success: (data) async {
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

  /// 添加验证好友信息
  /// [userId] 对方id
  /// [content] 内容
  /// [type] 1=被加的 2=我加的 其他为普通查看
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static checkMessageAdd({
    required String userId,
    required String content,
    required int type,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/checkMessageAdd",
        {
          "userId": userId,
          "content": content,
          "type": type,
        },
        loading: loading,
        toast: toast, success: (data) async {
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

  /// 好友列表
  /// [type] 1 是好友列表  2 是拉黑列表
  /// [keyword] 搜索名称
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static friendList({
    required int type,
    String? keyword,
    Success<List<FriendList>>? success,
    Fail? fail,
    bool loading = false,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/friendList",
        {
          "type": type,
          "keyword": keyword,
        },
        loading: loading,
        toast: toast, success: (data) async {
      /// 将组头加入数组
      var res = data.map((item) {
        item["indexLetter"] = "#";
        return item;
      }).toList();
      List<FriendList> list = [];
      for (int i = 0; i < res.length; i++) {
        list.add(FriendList.fromJson(data[i]));
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

  /// 搜索用户和好友
  /// [userId] 用户id
  /// [type] 类型 0=全部 1=动态 2=广播 3=任务 4=闲置
  /// [page] 页页码，数字类型
  /// [pageSize] 分页条数 ，数字类型
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static friendSearchList({
    required String name,
    int page = 1,
    int pageSize = 20,
    Success<LongList>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/friendSearchList",
        {
          "name": name,
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

  /// 拉黑
  /// [userId] 对方id
  /// [status] 0=拉黑 1=取消拉黑
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static blackUserAction({
    required String userId,
    required int status,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/blackUserAction",
        {
          "userId": userId,
          "status": status,
        },
        loading: loading,
        toast: toast, success: (data) async {
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

  /// 标签列表
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static tagList({
    Success<List<LabelEntity>>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.get<dynamic>("/chat/tagList", null, loading: loading, toast: toast,
        success: (data) async {
      List<LabelEntity> list = [];

      for (int i = 0; i < data.length; i++) {
        list.add(LabelEntity.fromJson(data[i]));
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

  /// 标签好友列表
  /// [tagId] 标签id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static tagFriendList({
    required String tagId,
    Success<List<FriendList>>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/tagFriendList",
        {
          "tagId": tagId,
        },
        loading: loading,
        toast: toast, success: (data) async {
      /// 将组头加入数组
      var res = data.map((item) {
        item["indexLetter"] = "#";
        item["toUserId"] = int.parse(item["toUserId"]);

        return item;
      }).toList();

      List<FriendList> list = [];

      for (int i = 0; i < res.length; i++) {
        list.add(FriendList.fromJson(data[i]));
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

  /// 标签内添加好友列表
  /// [name] 搜索名称 (精准搜索)
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static tagFriendInfoList({
    String? name,
    Success<List<FriendList>>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
        "/chat/tagFriendInfoList",
        {
          "name": name,
        },
        loading: loading,
        toast: toast, success: (data) async {
      /// 将组头加入数组
      var res = data.map((item) {
        item["indexLetter"] = "#";
        item["toUserId"] = int.parse(item["toUserId"]);

        return item;
      }).toList();

      List<FriendList> list = [];

      for (int i = 0; i < res.length; i++) {
        list.add(FriendList.fromJson(data[i]));
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

  /// 添加和编辑标签
  /// [id] id 编辑时可传id
  /// [name] 标签名称
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static tagSave({
    String? id,
    required String name,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
      "/chat/tagSave",
      {
        "id": id,
        "name": name,
      },
      loading: loading,
      toast: toast,
      success: (data) async {
        if (success != null) {
          /// 请求成功回调
          success(data);
        }
      },
      fail: (code, msg) {
        if (fail != null) {
          /// 请求失败回调
          fail(code, msg);
        }
      },
    );
  }

  /// 移动好友到标签
  /// [tagId] 标签id
  /// [toUserId] 对方id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static tagFriendMove({
    required String tagId,
    required String toUserId,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
      "/chat/tagFriendMove",
      {
        "tagId": tagId,
        "toUserId": toUserId,
      },
      loading: loading,
      toast: toast,
      success: (data) async {
        if (success != null) {
          /// 请求成功回调
          success(data);
        }
      },
      fail: (code, msg) {
        if (fail != null) {
          /// 请求失败回调
          fail(code, msg);
        }
      },
    );
  }

  /// 添加好友到标签(支持批量)
  /// [ids] 好友的id 做成一个list集合
  /// [tagId] 标签id
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static tagFriendAdd({
    required List<String> ids,
    required String tagId,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
      "/chat/tagFriendAdd",
      {
        "ids": ids,
        "tagId": tagId,
      },
      loading: loading,
      toast: toast,
      success: (data) async {
        if (success != null) {
          /// 请求成功回调
          success(data);
        }
      },
      fail: (code, msg) {
        if (fail != null) {
          /// 请求失败回调
          fail(code, msg);
        }
      },
    );
  }

  /// 删除标签
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static tagDel({
    required String id,
    Success<dynamic>? success,
    Fail? fail,
    bool loading = true,
    bool toast = false,
  }) {
    /// 发起请求
    Request.post<dynamic>(
      "/chat/tagDel",
      {
        "id": id,
      },
      loading: loading,
      toast: toast,
      success: (data) async {
        if (success != null) {
          /// 请求成功回调
          success(data);
        }
      },
      fail: (code, msg) {
        if (fail != null) {
          /// 请求失败回调
          fail(code, msg);
        }
      },
    );
  }
}
