import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/model/task/ProfitEntity.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';
import '../state.dart';

/// tab列表页面
class TabListPage extends StatefulWidget {
  const TabListPage({
    Key? key,
    required this.data,
    required this.logic,
    required this.type
  }) : super(key: key);

  /// 数据源
  final GoldIncomeState data;

  /// 逻辑层
  final GoldIncomeLogic logic;

  /// 列表的类型
  final int type;


  @override
  State<TabListPage> createState() => _TabListPageState();
}

/// 页面保活  AutomaticKeepAliveClientMixin
class _TabListPageState extends State<TabListPage> with AutomaticKeepAliveClientMixin {

  /// 列表的item
  Widget item(ProfitEntity item) {
    return Container(
      padding: EdgeInsets.only(left: 45.dp),
      child: Column(
        children: [
          SizedBox(height: 20.dp),
          Row(
            children: [
              /// 收入来源和时间
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 礼物名称
                  Text(item.profitDesc),
                  SizedBox(height: 15.dp),

                  Text(
                    item.createTime,
                    style: TextStyle(
                      fontSize: 24.dp,
                      color: darkGreyColor,
                    ),
                  ),
                ],
              ),

              const Expanded(child: SizedBox()),

              /// 收入金额
              Text(
                "+${item.profitNumber}",
                style: const TextStyle(
                  color: orange,
                ),
              ),
              SizedBox(width: 45.dp),
            ],
          ),
          SizedBox(height: 25.dp),
          /// 下划线
          Divider(
            height: 1.dp,
            thickness: 1.dp,
            color: lightBlackDivider,
          ),
        ],
      ),
    );
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<GoldIncomeLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if(widget.data.reload[widget.type] ?? false) {
        reset();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 页面保活
    super.build(context);
    /// 刷新和加载组件  自定义widget
    return RefreshLoad(
      /// 初始化请求
      init: (page) => widget.logic.getList(widget.type, page),
      /// 用于重置列表
      resetList: (reset) => reload(reset),
      child: GetBuilder<GoldIncomeLogic>(builder: (_) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 35.dp),
          children: [
            for (int i = 0; i < widget.data.listMap[widget.type]!.length; i++)
              item(widget.data.listMap[widget.type]![i])
          ],
        );
      }),
    );
  }
  /// 页面保活
  @override
  bool get wantKeepAlive => true;
}
