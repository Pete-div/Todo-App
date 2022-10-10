import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo2/app/core/utis/extension.dart';
import 'package:todo2/app/module/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCrtl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCrtl.doingTodos.isEmpty && homeCrtl.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/fr.jpg',
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
                SizedBox(height: 10.0.hp,),
                Text(
                  'Add Task',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0.sp),
                ),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                ...homeCrtl.doingTodos
                    .map((e) => Padding(
                      padding: EdgeInsets.symmetric(vertical:3.0.wp,horizontal: 9.0.wp),
                      child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Checkbox(
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey),
                                  value: e['done'],
                                  onChanged: (val) {
                                    homeCrtl.doneTodo(e['title']);
                                  },
                                ),
                              ),

                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal:5.0.wp),
                                child: Text(e['title'],
                                overflow: TextOverflow.ellipsis,),
                              ),
                            ],
                          ),
                    ))
                    .toList(),
                    if(homeCrtl.doingTodos.isNotEmpty)
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.0.wp),
                      child: const Divider(thickness: 2,),
                    )
              ],
            ),
    );
  }
}
