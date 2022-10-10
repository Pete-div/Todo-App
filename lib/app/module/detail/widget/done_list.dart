import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo2/app/core/utis/extension.dart';
import 'package:todo2/app/core/utis/value/color.dart';

import '../../home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCrtl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCrtl.doneTodos.isNotEmpty
          ? ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2.0.wp, horizontal: 5.0.wp),
                  child: Text(
                    'Completed(${homeCrtl.doneTodos.length})',
                    style: TextStyle(fontSize: 12.0.wp, color: Colors.grey),
                  ),
                ),
                ...homeCrtl.doneTodos.map(
                  (e) => Dismissible(
                    key: ObjectKey(e),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) {
                      homeCrtl.deleteDoneTod(e);
                    },
                    background: Container(
                      color: Colors.red.withOpacity(0.8),
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right:5.0.wp),
                        child: const Icon(Icons.delete,color: Colors.white,),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp, horizontal: 9.0.wp),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: Icon(
                              Icons.done,
                              color: blue,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: Text(
                              e['title'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
