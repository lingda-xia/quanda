import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:quanda/app.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'dart:io';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/injection.dart';
import 'package:quanda/utils/keyboard_util.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  if (Platform.isAndroid) {
    /// 设置顶部状态栏为透明色
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,

      /// 状态栏颜色  透明
      statusBarIconBrightness: Brightness.light,

      /// 状态栏图标亮度
      statusBarBrightness: Brightness.light,

      /// 状态栏亮度
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /// 确保重新初始化
  WidgetsFlutterBinding.ensureInitialized();

  /// 注入全局依赖
  await Injection.init();

  runApp(
    /// 解决使用  MediaQuery 时造成的键盘弹起时 引发重新build的问题
    MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .copyWith(boldText: false),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  /// 腾讯im
  final tim = Get.find<TencentImLogic>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "圈达",

      /// 初始路由
      initialRoute: RouteConfig.main,

      /// 将会按照此处指定的语言翻译
      locale: const Locale('zh', 'CN'),

      /// 多语言实现代理
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      /// 指定您的应用支持的语言环境
      supportedLocales: const [
        Locale('zh', 'CN'),
      ],

      /// 性能浮层
      // showPerformanceOverlay: true,

      // /// 如果为 true，将使用继承的 MediaQuery。如果一个不可用，或者这是错误的，则将从窗口构建一个。
      // useInheritedMediaQuery: true,

      /// 路由配置
      getPages: RouteConfig.getPages,
      routingCallback: (routing) {
        print("这是什么${routing?.current}");
      },

      /// 路由跳转的方式  比如从左到右
      defaultTransition: Transition.fade,

      /// 调试的时候不显示头部debug
      debugShowCheckedModeBanner: false,

      builder: (context, child) => Scaffold(
        /// 将关闭键盘的全局手势检测器
        body: GestureDetector(
          onTap: () {
            KeyboardUtils.hideKeyboard(context);
          },
          child: child,
        ),
      ),

      /// 主题配置
      theme: ThemeData(
        /// 文本主题
        textTheme: TextTheme(
          /// 默认文本颜色
          bodyText2: TextStyle(
            color: const Color.fromRGBO(223, 226, 235, 1),
            fontSize: 30.dp,
            fontFamily: "PingFang SC",
          ),
        ),

        /// 墨水颜色
        splashColor: Colors.transparent,

        /// 高亮颜色
        highlightColor: Colors.transparent,

        /// Scaffold 下的背景颜色
        scaffoldBackgroundColor: const Color.fromRGBO(7, 17, 20, 1),

        /// AppBar主题配置
        appBarTheme: AppBarTheme(
          /// AppBar 背景颜色
          backgroundColor: const Color.fromRGBO(7, 17, 20, 1),

          /// AppBar 标题居中
          centerTitle: true,

          /// AppBar 标题样式
          titleTextStyle: TextStyle(
            color: const Color.fromRGBO(223, 226, 235, 1),
            fontFamily: "PingFang SC",
            fontSize: 36.dp,
          ),
        ),
      ),
      home: const AppPage(),
    );
  }
}
