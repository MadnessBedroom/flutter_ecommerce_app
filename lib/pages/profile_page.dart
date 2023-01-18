import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/controllers/controller.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<AppController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/profile_pic.png'),
          const Text(
            '功能开发中...\nfeature in development...',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
