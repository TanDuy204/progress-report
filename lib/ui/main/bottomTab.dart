import 'package:flutter/material.dart';

import '../screen/index.dart';
import '../screen/notifi.dart';
import '../screen/profile.dart';
import '../screen/project.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    Index(),
    Notifications(),
    Project(),
    Profile(),
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Trang chủ"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: "Thông báo"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
              ),
              label: "Dự Án"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Cá Nhân"),
        ],
      ),
    );
  }
}
