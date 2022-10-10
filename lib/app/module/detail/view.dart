import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo2/app/core/utis/extension.dart';
import 'package:todo2/app/module/detail/widget/doing_list.dart';
import 'package:todo2/app/module/detail/widget/done_list.dart';

import '../home/controller.dart';

class DetailPage extends StatelessWidget {
  final homeCrol = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final task = homeCrol.task.value!;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Form(
        key: homeCrol.formkey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCrol.updateTodos();
                      homeCrol.changeTask(null);
                      homeCrol.editContr.clear();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style:
                        TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCrol.doingTodos.length + homeCrol.doneTodos.length;
              return Padding(
                padding:
                    EdgeInsets.only(left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
                child: Row(
                  children: [
                    Text(
                      '$totalTodos',
                      style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCrol.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.pink,
                            Color.fromARGB(255, 54, 244, 127)
                          ],
                        ),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey,
                            const Color.fromARGB(255, 54, 244, 127)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.wp, vertical: 5.0.wp),
              child: TextFormField(
                controller: homeCrol.editContr,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400],
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (homeCrol.formkey.currentState!.validate()) {
                        var success = homeCrol.addTodo(homeCrol.editContr.text);
                        if (success) {
                          EasyLoading.showSuccess('Todo added successfully');
                        } else {
                          EasyLoading.showError('Todo item already exist');
                        }
                        homeCrol.editContr.clear();
                      }
                    },
                    icon: Icon(Icons.done),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
            DoneList()
          ],
        ),
      )),
    );
  }
}
