import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: FittedBox(
                child: CircleAvatar(
                  radius: 2,
                  backgroundImage: AssetImage('assets/images/onboarding_1.png'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Trang Chủ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: <Widget>[
          _buildIconButtonAppbar(Icons.search, () {}),
          _buildIconButtonAppbar(Icons.add, () {}),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        color: Colors.grey.shade200,
        child: ListView(
          children: [
            title('Hôm Nay'),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.lightGreenAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.library_add_check_outlined,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Tác vụ",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                      // Nội dung khác
                      ),
                ),
              ],
            ),
            title('Tất cả các hạng mục'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: <Widget>[
                  category(
                      Icons.library_add_check_outlined, "Tất cả các tác vụ",
                      () {
                    print('abc');
                  }),
                  Divider(),
                  category(Icons.person_search_outlined, "Các tác vụ của tôi",
                      () {
                    print('abc');
                  }),
                  Divider(),
                  category(Icons.person_search_outlined,
                      "Các tác vụ đến hạn của tôi", () {
                    print('abc');
                  }),
                  Divider(),
                  category(Icons.hourglass_empty, "Các tác vụ quá hạn", () {
                    print('abc');
                  }),
                  Divider(),
                  category(Icons.access_time, "Tác vụ ngày mai", () {
                    print('abc');
                  }),
                  Divider(),
                  category(Icons.calendar_today, "Tác vụ trong 7 ngày tới", () {
                    print('abc');
                  }),
                  Divider(),
                  category(Icons.calendar_month, "Tác vụ hôm nay + Quá hạn",
                      () {
                    print('abc');
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            category(Icons.calendar_month, "Lịch", () {
              print('abc');
            }),
            SizedBox(height: 20),
            category(Icons.message, "Thảo luận", () {
              print('abc');
            }),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  category(Icons.people_alt_outlined, "Người dùng cổng", () {
                    print('abc');
                  }),
                  Divider(),
                  category(Icons.groups_3_outlined, "Các nhóm", () {
                    print('abc');
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            category(Icons.tag_outlined, "Tất cả Tag", () {
              print('abc');
            }),
          ],
        ),
      ),
    );
  }
}

Widget title(String label) {
  return Text(
    label,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Colors.grey.shade700,
    ),
  );
}

Widget category(IconData icon, String label, Function onTap) {
  return GestureDetector(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.cyan,
              ),
            ),
            SizedBox(width: 20),
            Text(label),
          ],
        ),
      ),
    ),
  );
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
