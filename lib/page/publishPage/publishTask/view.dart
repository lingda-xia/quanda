import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/publishPublic/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/customSlider.dart';

import 'logic.dart';
import 'state.dart';

/// 发布任务页面
class PublishTask extends StatelessWidget {
  PublishTask({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PublishTaskLogic());

  /// 数据层
  final state = Get.find<PublishTaskLogic>().state;

  /// 列表的item
  Widget listItem(String title, int index, int select) {
    return Row(
      children: [
        Stack(
          children: [
            /// 选中状态
            Visibility(
              visible: select == index,
              child: Container(
                width: 24.dp,
                height: 24.dp,
                decoration: BoxDecoration(
                  color: paleGreenColor,
                  borderRadius: BorderRadius.circular(12.dp),
                ),
              ),
            ),

            /// 未选中状态
            Visibility(
              visible: select != index,
              child: Container(
                width: 24.dp,
                height: 24.dp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.dp),
                    border: Border.all(
                      width: 3.dp,
                      color: greyColor,
                    )),
              ),
            ),
          ],
        ),
        SizedBox(width: 8.dp),

        /// 提取方式
        Text(
          title,
          style: TextStyle(
            color: greyColor,
            fontSize: 26.dp,
          ),
        ),
      ],
    );
  }

  /// 滑块展示是数值
  Widget displayValues(String left, String middle, String right) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.dp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 最小公里数
          Expanded(
            child: Text(
              left,
              style: TextStyle(
                color: greyColor,
                fontSize: 24.dp,
              ),
            ),
          ),

          /// 选中的公里数
          Expanded(
            child: Text(
              middle,
              style: TextStyle(
                color: greyColor,
                fontSize: 24.dp,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /// 最大公里数
          Expanded(
            child: Text(
              right,
              style: TextStyle(
                color: greyColor,
                fontSize: 24.dp,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  /// 标题
  Widget title(String img, String title, String tip) {
    return Row(
      children: [
        Image.asset(
          img,
          width: 36.dp,
          height: 36.dp,
        ),
        SizedBox(width: 10.dp),
        Text(
          title,
          style: TextStyle(
            fontSize: 30.dp,
          ),
        ),
        SizedBox(width: 4.dp),
        Text(
          tip,
          style: TextStyle(
            fontSize: 24.dp,
            color: darkGreyColor,
          ),
        ),
      ],
    );
  }

  /// 输入内容
  Widget inputContent(
      {required AParameterCallback<String> onChange,
      required String title,
      required String suffixText,
        required TextEditingController controller,
        required FocusNode focusNode,
      }) {
    return SizedBox(
      height: 100.dp,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28.dp,
              color: greyColor,
            ),
          ),
          SizedBox(width: 60.dp),
          SizedBox(
            width: 150.dp,
            child: TextField(
              minLines: 1,

              maxLength: 10,

              focusNode: focusNode,

              controller: controller,

              keyboardType: TextInputType.number,

              /// 监听输入改变的时候
              onChanged: onChange,

              /// 输入的文本样式
              style: TextStyle(
                color: themeWhite,
                fontSize: 26.dp,
              ),

              /// 光标颜色
              cursorColor: themeWhite,

              /// 装饰
              decoration: InputDecoration(
                /// 未输入时提示的内容
                hintText: "输入数字",
                counterText: "",

                /// 提示的文本样式
                hintStyle: TextStyle(
                  color: themeWhite,
                  fontSize: 26.dp,
                  fontFamily: "PingFang SC",
                ),

                /// 边框
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 10.dp),
          Text(
            suffixText,
            style: TextStyle(
              fontSize: 26.dp,
              color: darkGreyColor,
            ),
          ),
        ],
      ),
    );
  }

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
        SizedBox(height: 40.dp),

        /// 多少公里内的人可以看到该广播
        title(
          "img/Icon/kilometre.png",
          "多少公里内的人可以看到该广播？",
          "(1公里=1元)",
        ),

        /// 公里数滑块
        GetBuilder<PublishTaskLogic>(builder: (e) {
          return Stack(
            children: [
              /// 自定义滑块  自定义widget
              CustomSlider(
                value: state.kilometers,
                min: 1.0,
                max: 1000.0,
                divisions: 200,
                onChange: logic.kilometersChange,
              ),

              /// 头部固定正方形
              Positioned(
                top: 34.9.dp,
                left: 34.dp,
                child: Container(
                  width: 30.dp,
                  height: 30.dp,
                  color: const Color.fromRGBO(127, 235, 214, 1),
                ),
              ),
            ],
          );
        }),

        /// 公里数值
        GetBuilder<PublishTaskLogic>(builder: (e) {
          return displayValues("1k", "${state.kilometers.round()}k", "1000k");
        }),

        SizedBox(height: 30.dp),

        /// 该任务展示的时长
        title(
          "img/Icon/time.png",
          "该任务展示的时长？",
          "(1分=0.1元)",
        ),

        /// 时长数滑块
        GetBuilder<PublishTaskLogic>(builder: (e) {
          return Stack(
            children: [
              /// 自定义滑块  自定义widget
              CustomSlider(
                value: state.times,
                min: 24.0,
                max: 72.0,
                divisions: 48,
                onChange: logic.timesChange,
              ),

              /// 头部固定正方形
              Positioned(
                top: 34.8.dp,
                left: 34.dp,
                child: Container(
                  width: 30.dp,
                  height: 30.dp,
                  color: const Color.fromRGBO(127, 235, 214, 1),
                ),
              ),
            ],
          );
        }),

        /// 时长数值
        GetBuilder<PublishTaskLogic>(builder: (e) {
          return displayValues("24h", "${state.times.round()}h", "72h");
        }),

        SizedBox(height: 30.dp),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        SizedBox(height: 30.dp),

        /// 任务类型
        Row(
          children: [
            Image.asset(
              "img/Icon/taskIcon.png",
              width: 26.dp,
              height: 30.dp,
            ),
            SizedBox(width: 10.dp),
            Text(
              "任务类型",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
          ],
        ),

        /// 任务类型列表
        GetBuilder<PublishTaskLogic>(builder: (e) {
          return Row(
            children: [
              for (int i = 0; i < state.taskTypeList.length; i++)
                GestureDetector(
                  onTap: () => logic.selectTaskType(i),
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 40.dp, bottom: 40.dp, right: 120.dp),
                      child:
                          listItem(state.taskTypeList[i], i, state.selectType)),
                ),
            ],
          );
        }),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        /// 性别要求列表
        GetBuilder<PublishTaskLogic>(builder: (e) {
          return Row(
            children: [
              Text(
                "性别要求",
                style: TextStyle(
                  fontSize: 28.dp,
                  color: greyColor,
                ),
              ),

              /// 选择列表
              for (int i = 0; i < state.genderList.length; i++)
                GestureDetector(
                  onTap: () => logic.selectGender(i),
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 40.dp, bottom: 40.dp, left: 80.dp),
                      child:
                          listItem(state.genderList[i], i, state.selectGender)),
                ),
            ],
          );
        }),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        /// 所需人数
        inputContent(
          /// 输入改变时触发
          onChange: logic.peopleNumChange,

          /// 标题
          title: "所需人数：",

          /// 后缀提示
          suffixText: "人",

          controller: state.numController,

          focusNode: state.rFocusNode,
        ),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        /// 完成奖励：
        inputContent(
          /// 输入改变时触发
          onChange: logic.rewardChange,

          /// 标题
          title: "完成奖励：",

          /// 后缀提示
          suffixText: "/人/个圈达币",

          controller: state.moneyController,

          focusNode: state.mFocusNode,
        ),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        /// 停留时间：
        inputContent(
          /// 输入改变时触发
          onChange: logic.residenceTimeChange,

          /// 标题
          title: "停留时间：",

          /// 后缀提示
          suffixText: "分钟   (任务需要多久时间)",

          controller: state.timeController,

          focusNode: state.tFocusNode,
        ),
        SizedBox(height: 20.dp),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        SizedBox(height: 30.dp),

        /// 所需圈达币
        Row(
          children: [
            /// 圈达币
            Image.asset(
              "img/Icon/GoldCoin.png",
              width: 42.dp,
              height: 42.dp,
            ),
            SizedBox(width: 14.dp),
            Text(
              "所需圈达币",
              style: TextStyle(
                fontSize: 30.dp,
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              height: 60.dp,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.dp),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.dp, color: orange),
                  borderRadius: BorderRadius.circular(
                    10.dp,
                  )),
              child: GetBuilder<PublishTaskLogic>(builder: (e) {
                return Text(
                  "${state.payMoney}币",
                  style: TextStyle(
                    fontSize: 30.dp,
                    color: orange,
                  ),
                );
              }),
            ),
          ],
        ),

        SizedBox(height: 40.dp),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: const Color.fromRGBO(32, 37, 36, 1),
        ),

        SizedBox(height: 40.dp),

        Text(
          "任务流程解析",
          style: TextStyle(
            fontSize: 36.dp,
          ),
        ),

        SizedBox(height: 40.dp),

        /// 任务流程
        CachedImage(
          imgUrl: "${RequestApi.imgBaseUrl}flowPath.png",
          width: 670.dp,
          height: 370.dp,
          // fit: BoxFit.cover,
        ),

        SizedBox(height: 80.dp),

        /// 温馨提示
        Container(
          alignment: Alignment.center,
          child: Text(
            "温馨提示：为了您的合法权益，请勿发布违规的任务。",
            style: TextStyle(
              fontSize: 24.dp,
              color: darkGreyColor,
            ),
          ),
        ),

        SizedBox(height: 200.dp),
      ],
    );
  }
}
