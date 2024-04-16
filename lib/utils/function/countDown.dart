/// 倒计时
class CountDown {

  /// 倒计时
  /// [date] 目标时间
  /// [num] 所需增加的时间
  static String countDown(String date, int num) {
    String time = "0";

    /// 转为时间戳
    int start = DateTime.parse(date).millisecondsSinceEpoch;

    /// 当前时间戳
    int now = DateTime.now().millisecondsSinceEpoch;

    if((start + num) > now) {
      /// 毫秒差
      int diff = (start + num) - now;

      /// 把diff换算为分钟，秒
      /// 除以一分钟的毫秒数等到几分钟
      int minutes = ((diff % (1000 * 60 * 60)) / (1000 * 60)).truncate();
      /// 除以一秒的毫秒数等到几秒
      int seconds = (((diff % (1000 * 60 * 60)) % (1000 * 60)) / 1000).truncate();

      time = "$minutes:$seconds";
    }

    return time;
  }

}
