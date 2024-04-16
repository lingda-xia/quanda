import 'package:get/get.dart';
import 'state.dart';

/// 逻辑层
class HomePageLogic extends GetxController {
  HomePageState state = HomePageState();


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// 选择tab下标
  selectIndex(int index) {
    state.tabIndex = index;
    update();
  }

}
