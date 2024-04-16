import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/publishPublic/view.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';
import 'state.dart';

/// 发布瞬间 瞬间 页面
class PublishDynamic extends StatelessWidget {
  PublishDynamic({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PublishDynamicLogic());

  /// 数据层
  final state = Get.find<PublishDynamicLogic>().state;

  @override
  Widget build(BuildContext context) {
    /// 发布公用部分  自定义widget
    return PublishPublic(
      /// 发布
      release: (title, content, address, location, idList) =>
          logic.release(title, content, address, location, idList),

      /// 保存草稿
      saveDraft: (title, content, address, location, galleryItem, status) =>
          logic.saveDraft(title, content, address, location, galleryItem, status),

      /// 是否打开使用草稿对话框
      initDialog: () => logic.initDialog(),

      /// 使用草稿时为父组件设置参数
      setContent: (value) => logic.setContent(value),

      children: [
        SizedBox(height: 10.dp),
      ],
    );
  }
}
