import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print("Middleware đã được gọi!");

    SharedPreferences.getInstance().then((prefs) {
      bool isLoggedIn = prefs.getBool('isLoggerIn') ?? false;
      print("Trạng thái đăng nhập: $isLoggedIn");

      if (!isLoggedIn) {
        print("Chuyển hướng đến Login");
        Get.offAllNamed('/login');
      } else {
        print("Người dùng đã đăng nhập, tiếp tục đến MainPage");
      }
    });

    return null;
  }
}
