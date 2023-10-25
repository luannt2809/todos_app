import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';

import 'package:todos_app/screens/home_page.dart';
import 'package:todos_app/screens/notify_page.dart';
import 'package:todos_app/screens/settings_page.dart';

class UserScreen extends StatefulWidget {
  final NguoiDung nguoiDung;

  const UserScreen({super.key, required this.nguoiDung});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> listPages = [
      HomePage(
        nguoiDung: widget.nguoiDung,
      ),
      const NotifyPage(),
      SettingsPage(nguoiDung: widget.nguoiDung)
    ];

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: listPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: <BottomNavigationBarItem>[
          MyBottomNavigationBarItem(icon: Icons.home, label: "Trang chủ"),
          MyBottomNavigationBarItem(
              icon: Icons.notifications_rounded, label: "Thông báo"),
          MyBottomNavigationBarItem(icon: Icons.settings, label: "Cài đặt"),
        ],
      ),
    );
  }
}

class MyBottomNavigationBarItem extends BottomNavigationBarItem {
  MyBottomNavigationBarItem({required IconData icon, required String label})
      : super(
          icon: Icon(
            icon,
            size: 25,
          ),
          label: label,
        );
}
