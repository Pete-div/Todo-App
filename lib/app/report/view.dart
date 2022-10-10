import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo2/app/core/utis/extension.dart';
import 'package:todo2/app/core/utis/value/color.dart';
import 'package:todo2/app/module/home/controller.dart';
import 'package:get/get.dart';

class Report extends StatelessWidget {
  final homeCrtl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var createdTasks = homeCrtl.getTotalTask();
        var completedTasks = homeCrtl.getTotalDoneTask();
        var liveTasks = createdTasks - completedTasks;
        var percentage =
            (completedTasks / createdTasks * 100).toStringAsFixed(0);
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                'My Report',
                style:
                    TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
              child: Text(
                DateFormat.yMMMEd().format(DateTime.now()),
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 4.0.wp),
              child: const Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 5.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buidStatus(Colors.green, liveTasks, 'Live Tasks'),
                 SizedBox(
                    width: 1.0.wp,
                  ),
                  _buidStatus(Colors.orange, completedTasks, 'Completed Tasks'),
                  SizedBox(width: 1.0.wp,),
                  _buidStatus(Colors.blue, createdTasks, 'Created'),
                ],
              ),
            ),
            SizedBox(
              height: 8.0.wp,
            ),
            UnconstrainedBox(
              child: SizedBox(
                width: 70.0.wp,
                height: 70.0.wp,
                child: CircularStepProgressIndicator(
                  totalSteps: createdTasks == 0 ? 1 : createdTasks,
                  currentStep: completedTasks,
                  stepSize: 20,
                  selectedColor: green,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 150,
                  height: 150,
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${createdTasks == 0 ? 0 : percentage}%',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                      ),
                      SizedBox(height: 1.0.wp,),
                      Text(
                        'Efficiency',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    ));
  }
}

Row _buidStatus(Color color, int number, String text) {
  return Row(
    children: [
      Container(
        height: 3.0.wp,
        width: 3.0.wp,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5.wp, color: color)),
      ),
      SizedBox(
        width: 1.0.wp,
      ),
      Column(
crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number',
            style: TextStyle(fontSize: 16.0.sp),
          ),
          SizedBox(
            height: 1.0.wp,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 5.0.wp),
          ),
        ],
      )
    ],
  );
}
