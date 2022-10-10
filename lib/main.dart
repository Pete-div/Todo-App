import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo2/app/module/home/binding.dart';
import './app/module/home/view.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/service/storage/service.dart';

void main() async {
  await GetStorage.init();
await Get.putAsync(()=>StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo-List_Getx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
