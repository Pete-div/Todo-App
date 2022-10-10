import 'dart:convert';

import 'package:todo2/app/core/utis/keys.dart';
import 'package:todo2/app/data/service/storage/service.dart';
import 'package:get/get.dart';

import '../../models/task.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTask() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
