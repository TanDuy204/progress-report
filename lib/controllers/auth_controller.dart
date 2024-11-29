import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/model/auth_model.dart';
import 'package:intern_progressreport/ui/screen/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/main/bottomTab.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var userNameController = TextEditingController();
  List<AuthModel> users = getAuth().obs;
  var auths = <AuthModel>[].obs;
  var isLoginEmailValid = true.obs;
  var isLoginPasswordValid = true.obs;

  var isUserNameValid = true.obs;
  var isRegisterEmailValid = true.obs;
  var isRegisterPasswordValid = true.obs;
  var isRegisterConfirmPassword = true.obs;
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggerIn') ?? false;

    if (isLoggedIn) {
      String email = prefs.getString('userEmail') ?? '';
      String userName = prefs.getString('userName') ?? '';

      var currentUser = users.firstWhere(
        (user) => user.email == email,
        orElse: () => AuthModel(userName: userName, email: email, password: ''),
      );

      auths.clear();
      auths.add(currentUser);
    }
  }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || !email.isEmail) {
      isLoginEmailValid.value = false;
    } else {
      isLoginEmailValid.value = true;
    }

    if (password.isEmpty || password.length < 6) {
      isLoginPasswordValid.value = false;
    } else {
      isLoginPasswordValid.value = true;
    }

    bool isValidUser =
        users.any((user) => user.email == email && user.password == password);
    if (isValidUser) {
      var currentUser = users.firstWhere((element) => element.email == email);
      auths.clear();
      auths.add(currentUser);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggerIn', true);
      await prefs.setString('userEmail', currentUser.email);
      await prefs.setString('userName', currentUser.userName);
      Get.off(() => MainPage());
      Get.snackbar("Thành công", "Đăng nhập thành công");
    } else {
      Get.snackbar("Lỗi", "Email hoặc mật khẩu không đúng");
    }
  }

  void register() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String userName = userNameController.text.trim();

    if (userName.isEmpty) {
      isUserNameValid.value = false;
    } else {
      isUserNameValid.value = true;
    }

    if (email.isEmpty || !email.isEmail) {
      isRegisterEmailValid.value = false;
    } else {
      isRegisterEmailValid.value = true;
    }

    if (password.isEmpty || password.length < 6) {
      isRegisterPasswordValid.value = false;
    } else {
      isRegisterPasswordValid.value = true;
    }

    if (confirmPassword != password) {
      isRegisterConfirmPassword.value = false;
    } else {
      isLoginPasswordValid.value = true;
    }

    if (isRegisterEmailValid.value &&
        isRegisterPasswordValid.value &&
        isLoginPasswordValid.value) {
      bool emailExist = users.any((user) => user.email == email);
      if (emailExist) {
        Get.snackbar("Lỗi", "Email đã tồn tại");
      } else {
        users.add(
            AuthModel(email: email, password: password, userName: userName));
        Get.snackbar("Thành công", "Đăng ký thành công");
        Get.off(LoginScreen());
      }
    }
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggerIn');
    //prefs.setBool('isLoggerIn', false);
    Get.off(LoginScreen());
  }
}
