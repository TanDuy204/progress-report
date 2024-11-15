import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhận xét"),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _comment('Duy', 'oke', context),
                  _comment('Hùng', 'hello', context),
                  _comment('Cương', 'what', context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Thêm nhận xét",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _comment(String userName, String content, BuildContext context) {
  return Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/onboarding_1.png'),
        ),
        title: Text(userName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content),
            SizedBox(height: 1),
            Text("10:30"),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.delete_outline),
                        title: Text("Xóa"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.mode_edit_outlined),
                        title: Text("Chỉnh sửa"),
                        onTap: () {},
                      ),
                      Divider(height: 1),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Hủy"))
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      Divider(),
    ],
  );
}
