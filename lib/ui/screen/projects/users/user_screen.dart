import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_progressreport/components/add/add_users.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Người Dùng'),
        actions: [
          _buildIconButtonAppbar(Icons.search, () {
            print("avcd");
          }),
          _buildIconButtonAppbar(Icons.add, () {
            Get.to(AddUsers());
          }),
        ],
      ),
      body: Container(
        color: Colors.grey.shade300,
        padding: EdgeInsets.only(top: 20),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              height: 90,
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset("assets/images/onboarding_1.png"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("UserName"), Text("tohuy45829@gmail.com")],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildIconButtonAppbar(IconData icon, Function onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Container(
      height: 40,
      width: 40,
      decoration:
          BoxDecoration(color: Colors.cyanAccent, shape: BoxShape.circle),
      margin: EdgeInsets.only(right: 15),
      child: Icon(icon),
    ),
  );
}
