import 'package:flutter/material.dart';
import 'package:quanda/model/task/DailyTask.dart';
import 'package:quanda/model/task/RecommendTask.dart';
import 'package:quanda/model/task/SignData.dart';
import 'package:quanda/model/task/TaskInfo.dart';

/// 任务 的数据层
class TaskState {
  /// 任务中心信息
  late TaskInfo data;

  /// 签到列表
  late List<SignData?> signList;

  /// 签到标题
  late List<String> signTitle;

  /// 限时日期
  late String timeLimit;

  /// 日常任务列表
  late List<DailyTask> dailyTaskList;

  /// 日常任务标题
  late List<String> dailyTaskTitle;

  /// 日常任务按钮提示
  late List<String> tips;

  /// 推荐任务列表
  late List<RecommendTask> recommendList;

  /// 初始化 构造函数
  TaskState() {
    data = TaskInfo(0, 0, 0, 0, []);
    dailyTaskList = [];
    dailyTaskTitle = ["看广告赚金币", "搜索并加好友", "发布瞬间", "发布闲置", "发布任务", "发布广播"];
    tips = ["领福利", "去添加", "去发布", "去发布", "去发布", "去发布"];
    signList = [];
    signTitle = ["第一天", "第二天", "第三天", "第四天", "第五天"];
    timeLimit = "";
    recommendList = [];
  }
}

