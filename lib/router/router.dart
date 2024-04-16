import 'package:get/get.dart';
import 'package:quanda/page/chatPage/addFriends/view.dart';
import 'package:quanda/page/chatPage/blacklist/view.dart';
import 'package:quanda/page/chatPage/complaint/view.dart';
import 'package:quanda/page/chatPage/friendVerification/view.dart';
import 'package:quanda/page/chatPage/addMember/view.dart';
import 'package:quanda/page/chatPage/labelManage/view.dart';
import 'package:quanda/page/chatPage/mailList/view.dart';
import 'package:quanda/page/chatPage/newFriend/view.dart';
import 'package:quanda/page/chatPage/newLabel/view.dart';
import 'package:quanda/page/chatPage/nonFriend/view.dart';
import 'package:quanda/page/chatPage/passValidation/view.dart';
import 'package:quanda/page/chatPage/privateChat/view.dart';
import 'package:quanda/page/chatPage/selectLabel/view.dart';
import 'package:quanda/page/chatPage/setLabel/view.dart';
import 'package:quanda/page/chatPage/systemNotice/view.dart';
import 'package:quanda/page/chatPage/temporarySession/view.dart';
import 'package:quanda/components/search/view.dart';
import 'package:quanda/page/chatPage/viewFriends/view.dart';
import 'package:quanda/page/index/searchBox/view.dart';
import 'package:quanda/page/login/chooseBirthday/view.dart';
import 'package:quanda/page/login/chooseFigure/view.dart';
import 'package:quanda/page/login/chooseGender/view.dart';
import 'package:quanda/page/login/chooseName/view.dart';
import 'package:quanda/page/login/getCode/view.dart';
import 'package:quanda/page/login/loginBindChange/view.dart';
import 'package:quanda/page/login/oneClickLogin/view.dart';
import 'package:quanda/page/login/originalNumber/view.dart';
import 'package:quanda/page/login/passwordLogin/view.dart';
import 'package:quanda/page/login/retrievePassword/view.dart';
import 'package:quanda/page/login/unableToLogin/view.dart';
import 'package:quanda/page/login/verifyIdentity/view.dart';
import 'package:quanda/page/login/verifyLogin/view.dart';
import 'package:quanda/page/myPage/IdleOrderDetails/view.dart';
import 'package:quanda/page/myPage/about/view.dart';
import 'package:quanda/page/myPage/accountCancellation/view.dart';
import 'package:quanda/page/myPage/accountSecurity/view.dart';
import 'package:quanda/page/myPage/activity/view.dart';
import 'package:quanda/page/myPage/addressManage/view.dart';
import 'package:quanda/page/myPage/authenticationOk/view.dart';
import 'package:quanda/page/myPage/bill/view.dart';
import 'package:quanda/page/myPage/cancellation/view.dart';
import 'package:quanda/page/myPage/certification/view.dart';
import 'package:quanda/page/myPage/changeBinding/view.dart';
import 'package:quanda/page/myPage/changeNumber/view.dart';
import 'package:quanda/page/myPage/editAddress/view.dart';
import 'package:quanda/page/myPage/express/view.dart';
import 'package:quanda/page/myPage/fansFollow/view.dart';
import 'package:quanda/page/myPage/feedback/view.dart';
import 'package:quanda/page/myPage/friends/view.dart';
import 'package:quanda/page/myPage/gifts/view.dart';
import 'package:quanda/page/myPage/historicalFeedback/view.dart';
import 'package:quanda/page/myPage/myCollection/view.dart';
import 'package:quanda/page/myPage/myInteraction/view.dart';
import 'package:quanda/page/myPage/myOrder/view.dart';
import 'package:quanda/page/myPage/myWallet/view.dart';
import 'package:quanda/page/myPage/personalData/view.dart';
import 'package:quanda/page/myPage/personalQRCode/view.dart';
import 'package:quanda/page/myPage/privacySetting/view.dart';
import 'package:quanda/page/myPage/setPassword/view.dart';
import 'package:quanda/page/myPage/systemSettings/view.dart';
import 'package:quanda/page/myPage/taskList/view.dart';
import 'package:quanda/page/myPage/verificationCode/view.dart';
import 'package:quanda/page/othersHomePage/confirmOrder/view.dart';
import 'package:quanda/page/othersHomePage/others/view.dart';
import 'package:quanda/page/othersHomePage/seeDetails/view.dart';
import 'package:quanda/page/publishPage/addressSelection/view.dart';
import 'package:quanda/page/publishPage/broadcast/view.dart';
import 'package:quanda/page/publishPage/publish/view.dart';
import 'package:quanda/page/publishPage/publishDynamic/view.dart';
import 'package:quanda/page/publishPage/publishTask/view.dart';
import 'package:quanda/page/publishPage/setAside/view.dart';
import 'package:quanda/page/publishPage/videoPreview/view.dart';
import 'package:quanda/page/taskPage/goldIncome/view.dart';
import 'package:quanda/page/taskPage/incomeStatement/view.dart';
import 'package:quanda/page/taskPage/withdrawal/view.dart';

/// @description :页面管理
class RouteConfig {

  /// 聊天部分
  /// 通讯录
  static const String mailList = "/mailList";

  /// 临时会话
  static const String temporarySession = "/temporarySession";

  /// 搜索页
  static const String search = "/search";

  /// 私聊
  static const String privateChat = "/privateChat";

  /// 系统通知
  static const String systemNotice = "/systemNotice";

  /// 查看好友状态
  static const String viewFriends = "/viewFriends";

  /// 查看非好友状态
  static const String nonFriends = "/nonFriends";

  /// 加好友验证
  static const String friendVerification = "/friendVerification";

  /// 添加好友
  static const String addFriends = "/addFriends";

  /// 新的朋友
  static const String newFriends = "/newFriends";

  /// 通过验证
  static const String passValidation = "/passValidation";

  /// 选择标签
  static const String selectLabel = "/selectLabel";

  /// 标签管理
  static const String labelManage = "/labelManage";

  /// 新建标签
  static const String newLabel = "/newLabel";

  /// 添加成员
  static const String addMember = "/addMember";

  /// 设置标签
  static const String setLabel = "/setLabel";

  /// 投诉
  static const String complaint = "/complaint";

  /// 黑名单
  static const String blacklist = "/blacklist";


  /// 我的部分
  /// 个人资料
  static const String personalData = "/personalData";

  /// 我的互动
  static const String myInteraction = "/myInteraction";

  /// 任务人列表
  static const String taskList = "/taskList";

  /// 闲置订单详情
  static const String idleOrderDetails = "/idleOrderDetails";

  /// 快递选择
  static const String express = "/express";

  /// 我的钱包
  static const String myWallet = "/myWallet";

  /// 账单
  static const String bill = "/bill";

  /// 我的订单
  static const String myOrder = "/myOrder";

  /// 核验码
  static const String verificationCode = "/verificationCode";

  /// 粉丝关注
  static const String fansFollow = "/fansFollow";

  /// 我的收藏
  static const String myCollection = "/myCollection";

  /// 订单支付
  static const String orderPayment = "/orderPayment";

  /// 地址管理
  static const String addressManage = "/addressManage";

  /// 编辑地址
  static const String editAddress = "/editAddress";

  /// 认证成功
  static const String authenticationOk = "/authenticationOk";

  /// 实名认证
  static const String certification = "/certification";

  /// 个人二维
  static const String personalQRCode = "/personalQRCode";

  /// 赠礼
  static const String gifts = "/gifts";

  /// 活动
  static const String activity = "/activity";

  /// 好友
  static const String friends = "/friends";

  /// 隐私设置
  static const String privacySetting = "/privacySetting";

  /// 系统设置
  static const String systemSetting = "/systemSetting";

  /// 账号安全
  static const String accountSecurity = "/accountSecurity";

  /// 关于圈达
  static const String about = "/about";

  /// 设置密码
  static const String setPassword = "/setPassword";

  /// 更换手机号码绑定
  static const String changeNumber = "/changeNumber";

  /// 自助换绑
  static const String changeBinding = "/changeBinding";

  /// 账号注销
  static const String accountCancellation = "/accountCancellation";

  /// 注销原因
  static const String cancellation = "/cancellation";

  /// 反馈
  static const String feedback = "/feedback";

  /// 历史反馈
  static const String historicalFeedback = "/historicalFeedback";


  /// 登陆部分
  /// 一键登陆
  static const String oneClickLogin = "/oneClickLogin";

  /// 密码登陆
  static const String passwordLogin = "/passwordLogin";

  /// 验证码登陆
  static const String verifyLogin = "/verifyLogin";

  /// 获取短信验证码
  static const String getCode = "/getCode";

  /// 无法登录
  static const String unableToLogin = "/unableToLogin";

  /// 忘记密码
  static const String retrievePassword = "/retrievePassword";

  /// 登录 自助换绑 新手机号
  static const String loginBindChange = "/loginBindChange";

  /// 登录 自助换绑 原手机号
  static const String originalNumber = "/originalNumber";

  /// 核实身份 填写姓名身份证
  static const String verifyIdentity = "/verifyIdentity";

  /// 选择性别
  static const String chooseGender = "/chooseGender";

  /// 选择生日
  static const String chooseBirthday = "/chooseBirthday";

  /// 选择形象
  static const String chooseFigure = "/chooseFigure";

  /// 选择形名称
  static const String chooseName = "/chooseName";


  /// 发布部分
  /// 发布
  static const String publish = "/publish";

  /// 发布任务
  static const String publishTask = "/publishTask";

  /// 发布闲置
  static const String setAside = "/setAside";

  /// 发布广播
  static const String broadcast = "/broadcast";

  /// 发布瞬间
  static const String publishDynamic = "/publishDynamic";

  /// 地址选择
  static const String addressSelect = "/addressSelect";

  /// 视频预览
  static const String videoPreview = "/videoPreview";


  /// 他人主页部分
  /// 他人主页
  static const String others = "/others";

  /// 查看信息
  static const String seeDetails = "/seeDetails";

  /// 确认订单
  static const String confirmOrder = "/confirmOrder";



  /// 任务部分
  /// 收益说明
  static const String incomeStatement = "/incomeStatement";

  /// 提现
  static const String withdrawal = "/withdrawal";

  /// 金币收益
  static const String goldIncome = "/goldIncome";


  /// 首页
  /// 首页搜索框
  static const String searchBox = "/searchBox";


  /// 主页面
  static const String main = "/";



  /// 别名映射页面
  static final List<GetPage> getPages = [
    /// 首页搜索框
    GetPage(
      name: searchBox,
      page: () => SearchBox(),
    ),
    /// 金币收益
    GetPage(
      name: goldIncome,
      page: () => GoldIncome(),
    ),
    /// 提现
    GetPage(
      name: withdrawal,
      page: () => Withdrawal(),
    ),
    /// 收益说明
    GetPage(
      name: incomeStatement,
      page: () => const IncomeStatement(),
    ),
    /// 查看信息
    GetPage(
      name: seeDetails,
      page: () => SeeDetails(),
    ),
    /// 他人主页
    GetPage(
      name: others,
      page: () => Others(),
    ),
    /// 视频预览
    GetPage(
      name: addressSelect,
      page: () => AddressSelect(),
    ),
    /// 地址选择
    GetPage(
      name: videoPreview,
      page: () => VideoPreview(),
    ),
    /// 发布瞬间
    GetPage(
      name: publishDynamic,
      page: () => PublishDynamic(),
    ),
    /// 发布广播
    GetPage(
      name: broadcast,
      page: () => Broadcast(),
    ),
    /// 发布闲置
    GetPage(
      name: setAside,
      page: () => SetAside(),
    ),
    /// 发布任务
    GetPage(
      name: publishTask,
      page: () => PublishTask(),
    ),
    /// 发布
    GetPage(
      name: publish,
      page: () => Publish(),
    ),
    /// 选择名称
    GetPage(
      name: chooseName,
      page: () => ChooseName(),
    ),
    /// 选择形象
    GetPage(
      name: chooseFigure,
      page: () => ChooseFigure(),
    ),
    /// 选择生日
    GetPage(
      name: chooseBirthday,
      page: () => ChooseBirthday(),
    ),
    /// 选择性别
    GetPage(
      name: chooseGender,
      page: () => ChooseGender(),
    ),
    /// 核实身份 填写姓名身份证
    GetPage(
      name: verifyIdentity,
      page: () => VerifyIdentity(),
    ),
    /// 登录 自助换绑 原手机号
    GetPage(
      name: originalNumber,
      page: () => OriginalNumber(),
    ),
    /// 登录 自助换绑 新手机号
    GetPage(
      name: loginBindChange,
      page: () => LoginBindChange(),
    ),
    /// 忘记密码
    GetPage(
      name: retrievePassword,
      page: () => RetrievePassword(),
    ),
    /// 无法登录
    GetPage(
      name: unableToLogin,
      page: () => UnableToLogin(),
    ),
    /// 验证码登陆
    GetPage(
      name: getCode,
      page: () => GetCode(),
    ),
    /// 验证码登陆
    GetPage(
      name: verifyLogin,
      page: () => VerifyLogin(),
    ),
    /// 密码登陆
    GetPage(
      name: passwordLogin,
      page: () => PasswordLogin(),
    ),
    /// 一键登陆
    GetPage(
      name: oneClickLogin,
      page: () => OneClickLogin(),
    ),
    /// 历史反馈
    GetPage(
        name: historicalFeedback,
        page: () => HistoricalFeedback(),
    ),
    /// 反馈
    GetPage(
      name: feedback,
      page: () => Feedback(),
    ),
    /// 注销原因
    GetPage(
        name: cancellation,
        page: () => Cancellation(),
    ),
    /// 账号注销
    GetPage(
        name: accountCancellation,
        page: () => AccountCancellation(),
    ),
    /// 自助换绑
    GetPage(
      name: changeBinding,
      page: () => ChangeBinding(),
    ),
    /// 更换手机号码绑定
    GetPage(
      name: changeNumber,
      page: () => ChangeNumber(),
    ),
    /// 设置密码
    GetPage(
      name: setPassword,
      page: () => SetPassword(),
    ),
    /// 关于圈达
    GetPage(
      name: about,
      page: () => About(),
    ),
    /// 账号安全
    GetPage(
      name: accountSecurity,
      page: () => AccountSecurity(),
    ),
    /// 系统设置
    GetPage(
      name: systemSetting,
      page: () => SystemSetting(),
    ),
    /// 隐私设置
    GetPage(
      name: privacySetting,
      page: () => PrivacySetting(),
    ),
    /// 好友
    GetPage(
      name: friends,
      page: () => FriendsPage(),
    ),
    /// 活动
    GetPage(
      name: activity,
      page: () => Activity(),
    ),
    /// 赠礼
    GetPage(
      name: gifts,
      page: () => Gifts(),
    ),
    /// 个人二维码
    GetPage(
      name: personalQRCode,
      page: () => PersonalQRCode(),
    ),
    /// 实名认证
    GetPage(
      name: certification,
      page: () => Certification(),
    ),
    /// 认证成功
    GetPage(
        name: authenticationOk,
        page: () => AuthenticationOk(),
    ),
    /// 编辑地址
    GetPage(
        name: editAddress,
        page: () => EditAddress(),
    ),
    /// 地址管理
    GetPage(
        name: addressManage,
        page: () => AddressManage(),
    ),
    /// 确认订单
    GetPage(
        name: confirmOrder,
        page: () => ConfirmOrder(),
    ),
    /// 我的收藏
    GetPage(
        name: myCollection,
        page: () => MyCollection(),
    ),
    /// 粉丝关注
    GetPage(
        name: fansFollow,
        page: () => FansFollow(),
    ),
    /// 核验码
    GetPage(
        name: verificationCode,
        page: () => VerificationCode(),
    ),
    /// 我的订单
    GetPage(
        name: myOrder,
        page: () => MyOrder(),
    ),
    /// 账单
    GetPage(
        name: bill,
        page: () => Bill(),
    ),
    /// 我的钱包
    GetPage(
        name: myWallet,
        page: () => MyWallet(),
    ),
    /// 闲置订单详情
    GetPage(
        name: idleOrderDetails,
        page: () => IdleOrderDetails(),
    ),
    /// 快递选择
    GetPage(
      name: express,
      page: () => Express(),
    ),
    /// 任务人列表
    GetPage(
        name: taskList,
        page: () => TaskList(),
    ),
    /// 我的互动
    GetPage(
        name: myInteraction,
        page: () => MyInteraction(),
    ),
    /// 个人资料
    GetPage(
        name: personalData,
        page: () => PersonalData(),
    ),
    /// 通讯录
    GetPage(
        name: mailList,
        page: () => MailList(),
    ),
    /// 临时会话
    GetPage(
      name: temporarySession,
      page: () => TemporarySession(),
    ),
    /// 公共搜索页面
    GetPage(
      name: search,
      page: () => Search(),
    ),
    /// 私聊页面
    GetPage(
      name: privateChat,
      page: () => PrivateChat(),
    ),
    /// 系统通知页面
    GetPage(
      name: systemNotice,
      page: () => SystemNotice(),
    ),
    /// 查看好友状态页面
    GetPage(
      name: viewFriends,
      page: () => ViewFriends(),
    ),
    /// 查看非好友状态页面
    GetPage(
      name: nonFriends,
      page: () => NonFriends(),
    ),
    /// 加好友验证页面
    GetPage(
      name: friendVerification,
      page: () => FriendVerification(),
    ),
    /// 添加好友页面
    GetPage(
      name: addFriends,
      page: () => AddFriends(),
    ),
    /// 新的朋友页面
    GetPage(
      name: newFriends,
      page: () => NewFriends(),
    ),
    /// 通过验证页面
    GetPage(
      name: passValidation,
      page: () => PassValidation(),
    ),
    /// 选择标签页面
    GetPage(
      name: selectLabel,
      page: () => SelectLabel(),
    ),
    /// 标签管理页面
    GetPage(
      name: labelManage,
      page: () => LabelManage(),
    ),
    /// 新建标签页面
    GetPage(
      name: newLabel,
      page: () => NewLabel(),
    ),
    /// 添加成员页面
    GetPage(
      name: addMember,
      page: () => AddMember(),
    ),
    /// 设置标签页面
    GetPage(
      name: setLabel,
      page: () => SetLabel(),
    ),
    /// 投诉页面
    GetPage(
      name: complaint,
      page: () => Complaint(),
    ),
    /// 黑名单页面
    GetPage(
      name: blacklist,
      page: () => Blacklist(),
    ),
  ];
}