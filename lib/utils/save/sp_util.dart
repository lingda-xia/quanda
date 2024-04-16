import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/model/location/TaskParam.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @description :键值对存储
class SpUtil {
  /// 键值对存储
  static SharedPreferences sp = Get.find<SharedPreferences>();

  /// 保存token
  static saveToken(String value) async {
    var res = await sp.setString("token", value);
    if(res) {
      print("保存成功$res");
    } else {
      print("保存失败$res");
    }
  }

  /// 删除token
  static deleteToken() async {
    print("删除token");
    await sp.remove("token");
  }

  ///更新token
  ///[token] token
  static updateToken(String token) async {
    /// 删除token
    await deleteToken();
    /// 保存token
    await saveToken(token);
  }

  /// 获取token
  static getToken() async {
    try {
      var token = sp.getString("token");
      if (token == null) {
        return null;
      } else {
        return token;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 更新用户信息
  /// [userInfo] 用户信息
  static updateUserInfo(double balance) async {
    var oldInfo = getUserInfo();  /// 获取用户的信息
    if(oldInfo != null){
      oldInfo.balance = balance;
      /// 保存信息
      await SpUtil.saveUserInfo(oldInfo);
    }
  }

  /// 删除用户信息
  static deleteUserInfo() async {
    print("删除用户信息");
    await sp.remove("userInfo");
  }

  /// 存储用户信息
  /// [userInfo] UserInfo
  static saveUserInfo(UserInfo userInfo) async {
    /// jsonEncode 转换object为 JSON 字符串。
    var res = await sp.setString("userInfo", jsonEncode(userInfo.toJson()));
    if(res) {
      print("保存成功$res");
    } else {
      print("保存失败$res");
    }
  }

  /// 获取用户信息
  static UserInfo? getUserInfo() {
    try {
      var json = sp.getString("userInfo");
      if (json == null) {
        return null;
      } else {
        /// jsonDecode  解析字符串并返回生成的 Json 对象。
        return UserInfo.fromJson(jsonDecode(json));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 保存地址
  static saveAddress(String value) async {
    var res = await sp.setString("address", value);
    if(res) {
      print("保存成功$res");
    } else {
      print("保存失败$res");
    }
  }

  ///更新地址
  ///[address] 地址
  static updateAddress(String address) async {
    /// 删除地址
    await deleteAddress();
    /// 保存地址
    await saveAddress(address);
  }

  /// 删除地址
  static deleteAddress() async {
    print("删除地址");
    await sp.remove("address");
  }

  /// 获取地址
  static getAddress() async {
    try {
      var address = sp.getString("address");
      if (address == null) {
        return null;
      } else {
        return Address.fromJson(jsonDecode(address));
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 保存草稿
  static saveDraft(String value, String key) async {
    var res = await sp.setString(key, value);
    if(res) {
      print("保存成功$res");
    } else {
      print("保存失败$res");
    }
  }

  /// 获取草稿
  static getDraft(String key) async {
    try {
      var draft = sp.getString(key);
      if (draft == null) {
        return null;
      } else {
        return jsonDecode(draft);
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 保存聊天用户密钥
  static saveUserSig(String value) async {
    var res = await sp.setString("userSig", value);
    if(res) {
      print("保存成功$res");
    } else {
      print("保存失败$res");
    }
  }

  /// 删除用户密钥
  static deleteUserSig() async {
    await sp.remove("userSig");
  }

  /// 获取聊天用户密钥
  static obtainUserSig() async {
    try {
      var userSig = sp.getString("userSig");
      if (userSig == null) {
        return null;
      } else {
        return userSig;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 保存 选择的形象
  static saveFigure(String value) async {
    var res = await sp.setString("figure", value);
    if(res) {
      print("保存成功$res");
    } else {
      print("保存失败$res");
    }
  }

  /// 删除选择的形象
  static deleteFigure() async {
    await sp.remove("figure");
  }

  /// 获取选择的形象
  static getFigure() async {
    try {
      var figure = sp.getString("figure");
      if (figure == null) {
        return "1";
      } else {
        return jsonDecode(figure);
      }
    } catch (e) {
      debugPrint(e.toString());
      return "1";
    }
  }

}
