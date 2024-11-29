import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/auth_controller.dart';

import '../register/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    authController.emailController.clear();
    authController.passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Đăng nhập",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: authController.emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Color(0xFF1565C0)),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Color(0xFF1565C0)),
                    hintText: "Nhập Email",
                    errorText: authController.isLoginEmailValid.value
                        ? null
                        : "Email không hợp lệ",
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1565C0).withOpacity(0.3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1565C0)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.close, size: 20),
                      onPressed: () {
                        authController.emailController.clear();
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: authController.passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF1565C0)),
                    labelText: "Mật khẩu",
                    labelStyle: TextStyle(color: Color(0xFF1565C0)),
                    hintText: "Nhập mật khẩu",
                    errorText: authController.isLoginPasswordValid.value
                        ? null
                        : "Mật khẩu phải ít nhất 6 ký tự",
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1565C0).withOpacity(0.3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1565C0)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  authController.login();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1565C0)),
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Quên mật khẩu ?",
                      style: TextStyle(color: Color(0xFF1565C0)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(RegisterScreen(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 300));
                    },
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(color: Color(0xFF1565C0)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                " Hoặc đăng nhập với ",
                style: TextStyle(color: Color(0xFF1565C0), fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 55,
                      width: 55,
                      child: Image.asset("assets/icons/apple_icon.png")),
                  SizedBox(width: 15),
                  SizedBox(
                      height: 52,
                      width: 52,
                      child: Image.asset("assets/icons/google_icon.png")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
