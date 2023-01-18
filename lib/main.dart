import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecommerce_app/common/theme.dart';
import 'package:flutter_ecommerce_app/controllers/binding.dart';
import 'package:flutter_ecommerce_app/pages/main_page.dart';
import 'package:get/get.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightAppTheme,
      debugShowCheckedModeBanner: false,
      enableLog: true,
      title: 'Material App',
      initialBinding: AppBinding(),
      home: const MainPage(),
      builder: EasyLoading.init(),
    );
  }
}
