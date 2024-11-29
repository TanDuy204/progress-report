import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/controllers/auth_controller.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thiết lập"),
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          color: Colors.grey.shade200,
          child: Obx(
            () {
              final user = authController.auths.isNotEmpty
                  ? authController.auths.first
                  : null;
              if (user == null) {
                return Center(
                    child: TextButton(
                        onPressed: () {
                          authController.logOut();
                        },
                        child: Text("Logout")));
              }
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: FittedBox(
                            child: CircleAvatar(
                              radius: 2,
                              backgroundImage:
                                  AssetImage('assets/images/onboarding_1.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.userName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            Text(user.email),
                          ],
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          authController.logOut();
                        },
                        child: Text("Logout")),
                  )
                ],
              );
            },
          )),
    );
  }
}
