import 'package:get/get.dart';
import 'package:quanda/page/chatPage/tencent_im/conversation_logic.dart';
import 'package:quanda/page/chatPage/tencent_im/friend_logic.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/page/chatPage/tencent_im/msg_logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @description :初始化时进行依赖注入，可全局使用
class Injection{

  static Future<void> init() async {
    /// 键值对存储 shared_preferences
    await Get.putAsync(() => SharedPreferences.getInstance());

    /// 腾讯im
    Get.lazyPut(() => TencentImLogic());
    /// 腾讯im 会话列表
    Get.lazyPut(() => ConversationLogic());
    /// 腾讯im聊天
    Get.lazyPut(() => MsgLogic());
    /// 腾讯im 关系链
    Get.lazyPut(() => TFriendLogic());

  }
}