import 'package:get/get.dart';
import 'package:todo2/app/data/provider/task/provider.dart';
import 'package:todo2/app/module/home/controller.dart';

import '../../data/service/storage/repository.dart';

class HomeBinding implements Bindings {
  @override
  // ignore: override_on_non_overriding_member
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider()),
      ),
    );
  }
}
