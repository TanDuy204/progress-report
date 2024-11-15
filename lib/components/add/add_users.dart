import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUsers extends StatelessWidget {
  const AddUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Thêm Tài Liệu",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Hủy",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Lưu",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thông Tin Tài Liệu",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDocument('Dự Án'),
                _buildDocument('Email của người dùng'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildDocument(String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        flex: 1,
        child: Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.symmetric(vertical: 22),
          child: Center(child: Text(title)),
        ),
      ),
      Expanded(
        flex: 2,
        child: TextField(
          decoration: InputDecoration(border: UnderlineInputBorder()),
        ),
      )
    ],
  );
}
