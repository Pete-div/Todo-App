import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo2/app/core/utis/extension.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo2/app/module/detail/view.dart';

import '../../../data/models/task.dart';
import '../controller.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({required this.task});
  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;
    // final color = HexColor.fromHex(task.color!);
    final color = Color.fromARGB(255, 159, 199, 13);
    return GestureDetector(
      onTap: (() {
        homeCtrl.changeTask(task);
          homeCtrl.changeTodos(task.todos ?? []);
        Get.to(DetailPage());
      }),
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(6.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[300]!, blurRadius: 7, offset: Offset(0, 7))
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // import step profgreess indcator

            StepProgressIndicator(
              totalSteps: homeCtrl.isTodosEmpty(task)? 1: task.todos!.length,
              currentStep: homeCtrl.isTodosEmpty(task) ? 0:homeCtrl.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.5), color],
              ),
              unselectedGradientColor: LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),
                  color: color),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.wp, right: 6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.0.sp),
                  ),
                  SizedBox(
                    height: 2.0.hp,
                  ),
                  Text(
                    '${task.todos?.length ?? 0}Task',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
