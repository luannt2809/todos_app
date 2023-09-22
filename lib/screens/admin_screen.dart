import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/home_page.dart';
import 'package:todos_app/screens/list_department_page.dart';
import 'package:todos_app/screens/list_user_page.dart';
import 'package:todos_app/screens/notify_page.dart';
import 'package:todos_app/screens/settings_page.dart';

class AdminScreen extends StatefulWidget {
  final NguoiDung nguoiDung;

  const AdminScreen({super.key, required this.nguoiDung});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> listPages = [
      const HomePage(),
      const ListUserPage(),
      const ListDepartmentPage(),
      const NotifyPage(),
      SettingsPage(nguoiDung: widget.nguoiDung)
    ];

    void _onItemTapped(int index) {
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
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          MyBottomNavigationBarItem(icon: Icons.home, label: "Trang chủ"),
          MyBottomNavigationBarItem(icon: Icons.person, label: "Người dùng"),
          MyBottomNavigationBarItem(icon: Icons.business_outlined, label: "Phòng ban"),
          MyBottomNavigationBarItem(
              icon: Icons.notifications_rounded, label: "Thông báo"),
          MyBottomNavigationBarItem(
              icon: Icons.settings, label: "Cài đặt"),
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
