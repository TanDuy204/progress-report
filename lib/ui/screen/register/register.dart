import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/auth_controller.dart';
import 'package:intern_progressreport/ui/screen/login/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();
    authController.emailController.clear();
    authController.passwordController.clear();
    authController.confirmPasswordController.clear();
    authController.userNameController.clear();
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
                "Đăng ký",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              Obx(
                () => TextField(
                  controller: authController.userNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Color(0xFF1565C0)),
                    labelText: "Tên người dùng",
                    labelStyle: TextStyle(color: Color(0xFF1565C0)),
                    hintText: "Nhập tên người dùng",
                    errorText: authController.isUserNameValid.value
                        ? null
                        : "Vui Lòng nhập tên",
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1565C0).withOpacity(0.3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1565C0)),
                    ),
                  ),
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
                    errorText: authController.isRegisterEmailValid.value
                        ? null
                        : "Email không hợp lệ",
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1565C0).withOpacity(0.3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1565C0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: authController.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF1565C0)),
                    labelText: "Mật khẩu",
                    labelStyle: TextStyle(color: Color(0xFF1565C0)),
                    hintText: "Nhập mật khẩu",
                    errorText: authController.isRegisterPasswordValid.value
                        ? null
                        : "Mật khẩu phải ít nhất 6 ký tự",
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1565C0).withOpacity(0.3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1565C0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: authController.confirmPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF1565C0)),
                    labelText: "Xác nhận mật khẩu",
                    labelStyle: TextStyle(color: Color(0xFF1565C0)),
                    hintText: "Nhập lại mật khẩu",
                    errorText: authController.isRegisterConfirmPassword.value
                        ? null
                        : "mật khẩu không trùng khớp",
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1565C0).withOpacity(0.3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1565C0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  authController.register();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1565C0)),
                child: Text(
                  "Đăng ký",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bạn đã có tài khoản ?"),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.off(LoginScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(milliseconds: 300));
                    },
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(color: Color(0xFF1565C0)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              
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
