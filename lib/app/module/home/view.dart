import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo2/app/core/utis/extension.dart';
import 'package:todo2/app/data/models/task.dart';
import 'package:todo2/app/module/home/add_card.dart';
import 'package:todo2/app/module/home/controller.dart';
import 'package:todo2/app/module/home/widgets/add_dialog.dart';
import 'package:todo2/app/module/home/widgets/task_card.dart';
import 'package:todo2/app/report/view.dart';

import '../../core/utis/value/color.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>
         IndexedStack(
          index: controller.tabIndex.value,
          children:[ SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Text(
                    'My List',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                  () => GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks
                          .map((e) => LongPressDraggable(
                              data: e,
                              onDragStarted: () => controller.changeDeleting(true),
                              onDraggableCanceled: (_, __) =>
                                  controller.changeDeleting(false),
                              onDragEnd: (_) => controller.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: TaskCard(task: e),
                              ),
                              child: TaskCard(task: e)))
                          .toList(),
                      AddCard(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Report()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo('Please create your task type');

                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete successful');
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: Obx(()=>
          BottomNavigationBar(
            onTap: (index)=>controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(right:15.0.wp),
                  child: const Icon(Icons.apps),
                ),),
                 BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding:  EdgeInsets.only(left:15.0.wp),
                    child: const Icon(Icons.data_usage),
                  ),
                ),
            ]),
        ),
      ),
        
    );
  }
}
