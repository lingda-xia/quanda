import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 上拉刷新、下拉加载、空白页加载动画
class RefreshLoad extends StatefulWidget {
  const RefreshLoad({
    Key? key,
    required this.child,
    required this.init,
    required this.resetList,
    this.enableRefresh = true,
    this.emptyTips = "加载数据为空",
    this.emptyWidget,
  }) : super(key: key);

  /// 子级
  final Widget child;

  /// 是否启用刷新
  final bool enableRefresh;

  /// 初始化方法
  final Future<LongList> Function(int) init;

  /// 用于重置列表
  final AParameterCallback<Function> resetList;

  /// 加载为空的提示
  final String emptyTips;

  /// 加载为空的图片widget
  final Widget? emptyWidget;

  @override
  State<RefreshLoad> createState() => _RefreshLoadState();
}

class _RefreshLoadState extends State<RefreshLoad> {
  /// 控制器
  late EasyRefreshController _controller;

  /// 加载状态  0加载中 1加载成功 2加载数据为空 3加载失败
  int loadState = 0;

  /// 当前页数
  int page = 1;

  /// 请求的数据
  LongList data = LongList(
    [],
    1,
    10,
    1,
    "",
    {},
    1,
  );

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: widget.enableRefresh,
      controlFinishLoad: true,
    );
    init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  init() {
    /// 页面重构完成回调
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// 请求
      widget.init(1).then((value) {
        print("初始化请求----${value.toJson()}---------------------");

        /// 请求数据初始化
        dataInit(value);

        /// 初始化页数
        resetPage();

        /// 加载状态  0加载中 1加载成功 2加载数据为空 3加载失败
        if (value.records.isEmpty) {
          updateState(2);
        } else {
          updateState(1);
        }

        /// 重置页脚
        _controller.resetFooter();
      }).catchError((e) {
        print("初始化请求错误----$e---------------------");

        /// 重置页脚
        _controller.resetFooter();

        /// 未连接网络 todo
        if (e == 1000) {
          updateState(3);
        } else {
          updateState(3);
        }
      });
    });
  }

  /// 更新状态
  updateState(int value) {
    setState(() {
      loadState = value;
    });
  }

  /// 初始化页数
  resetPage() {
    setState(() {
      page = 1;
    });
  }

  /// 请求数据初始化
  dataInit(LongList value) {
    setState(() {
      data = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          /// 用于埋下一个触发点  用于重置列表
          widget.resetList(init),

          /// 上下刷新、下拉加载控件
          Visibility(
            visible: loadState == 1,
            child: EasyRefresh(
              /// 控制器
              controller: _controller,

              /// 头部刷新
              header: const CupertinoHeader(),

              /// 底部加载
              footer: CupertinoFooter(
                foregroundColor: Colors.white,
                emptyWidget: Text(
                  "没有更多数据了",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 24.dp,
                  ),
                ),
              ),

              /// 刷新触发事件
              onRefresh: widget.enableRefresh
                  ? () async {
                      /// 加载中
                      updateState(0);

                      /// 初始化页数
                      resetPage();

                      /// 请求
                      widget.init(1).then((value) {
                        print("刷新请求----${value.toJson()}---------------------");

                        /// 请求数据初始化
                        dataInit(value);

                        /// 加载状态  0加载中 1加载成功 2加载数据为空 3加载失败
                        if (value.records.isEmpty) {
                          updateState(2);
                        } else {
                          updateState(1);
                        }

                        /// 完成刷新
                        _controller.finishRefresh();

                        /// 重置页脚
                        _controller.resetFooter();
                      }).catchError((e) {
                        print("刷新请求错误----$e---------------------");

                        /// 完成刷新
                        _controller.finishRefresh();

                        /// 重置页脚
                        _controller.resetFooter();

                        /// 未连接网络
                        if (e == 1000) {
                          updateState(3);
                        } else {
                          updateState(3);
                        }
                      });
                    }
                  : null,

              /// 加载触发事件
              onLoad: () async {
                print("现在的页数${data.current} ----- 总页数${data.pages}");

                /// 当前页小于总页数则继续加载
                if (data.current < data.pages) {
                  /// 更新页数
                  setState(() {
                    page++;
                  });

                  /// 请求
                  widget.init(page).then((value) {
                    print("加载请求----${value.toJson()}---------------------");

                    /// 请求数据初始化
                    dataInit(value);

                    /// 请求完毕后是否还有更多数据
                    _controller.finishLoad(value.current >= value.pages
                        ? IndicatorResult.noMore
                        : IndicatorResult.success);
                  }).catchError((e) {
                    print("加载请求错误----$e---------------------");
                    _controller.finishLoad(IndicatorResult.success);

                    /// 未连接网络 todo
                    if (e == 1000) {
                      updateState(3);
                    } else {
                      updateState(3);
                    }
                  });
                } else {
                  /// 没有更多数据了
                  _controller.finishLoad(IndicatorResult.noMore);
                }
              },
              child: widget.child,
            ),
          ),

          /// 未加载前显示的动画，加载之后需要隐藏
          Visibility(
            visible: loadState == 0,
            child: Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: const Text(
                "正在加载",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          /// 加载数据为空的页面
          Visibility(
            visible: loadState == 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 加载为空图片
                widget.emptyWidget != null ? widget.emptyWidget! : Container(),

                widget.emptyWidget != null
                    ? SizedBox(height: 30.dp)
                    : Container(),

                /// 加载为空提示
                Text(
                  widget.emptyTips,
                  style: TextStyle(
                    color: widget.emptyWidget != null
                        ? const Color.fromRGBO(48, 195, 177, 1)
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),

          /// 加载出错的页面
          Visibility(
            visible: loadState == 3,
            child: Column(
              children: [
                SizedBox(height: 60.dp),

                Image.asset(
                  "img/bigIcon/load_failed.png",
                  width: 540.dp,
                  height: 415.dp,
                ),

                const Text(
                  "加载出错了~",
                  style: TextStyle(
                    color: Color.fromRGBO(54, 197, 179, 1),
                  ),
                ),

                SizedBox(height: 30.dp),

                /// 刷新
                GestureDetector(
                  onTap: () {
                    /// 加载中
                    updateState(0);

                    /// 初始化页数
                    resetPage();

                    /// 请求
                    widget.init(1).then((value) {
                      print("刷新请求----${value.toJson()}---------------------");

                      /// 请求数据初始化
                      dataInit(value);

                      /// 加载状态  0加载中 1加载成功 2加载数据为空 3加载失败
                      if (value.records.isEmpty) {
                        updateState(2);
                      } else {
                        updateState(1);
                      }
                    }).catchError((e) {
                      /// 未连接网络
                      if (e == 1000) {
                        updateState(3);
                      } else {
                        updateState(3);
                      }
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 246.dp,
                    height: 142.dp,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/bigIcon/refresh_box.png"),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "刷新",
                      style: TextStyle(
                        fontSize: 28.dp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
