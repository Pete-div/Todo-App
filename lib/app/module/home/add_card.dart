import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo2/app/core/utis/extension.dart';
import 'package:todo2/app/data/models/task.dart';
import 'package:todo2/app/module/home/controller.dart';
import 'package:todo2/app/widget/icons.dart';
import 'package:todo2/app/core/utis/value/color.dart';

class AddCard extends StatelessWidget {
  final homeContrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWith = Get.width - 12.0.wp;
    return Container(
      width: squareWith / 2,
      height: squareWith / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            title: 'Title',
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              content: Form(
                key: homeContrl.formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                      child: TextFormField(
                        controller: homeContrl.editContr,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your task title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    selectedColor: Colors.grey[200],
                                    pressElevation: 0,
                                    backgroundColor: Colors.white,
                                    label: e,
                                    selected:
                                        homeContrl.chipIndex.value == index,
                                    onSelected: (bool selected) {
                                      homeContrl.chipIndex.value = selected
                                          ? index
                                          : 0;
                                    },
                                  );
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: Size(150, 40)),
                        onPressed: () {
                          if (homeContrl.formkey.currentState!.validate()) {
                            int icon = icons[homeContrl.chipIndex.value]
                                .icon!
                                .codePoint;
                          
                            // String color =
                            // icons[homeContrl.chipIndex.value]
                            //     .color!
                            //     .toHex();
                            var task = Task(
                                title: homeContrl.editContr.text,
                                icon: icon,
                                // color: color
                                );
                            Get.back();
                            homeContrl.addTask(task)
                                ? EasyLoading.showSuccess('create successful')
                                : EasyLoading.showError('Duplicated task');
                          }
                        },
                        child: Text('Confirm'))
                  ],
                ),
              ));
          homeContrl.editContr.clear();
          homeContrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
