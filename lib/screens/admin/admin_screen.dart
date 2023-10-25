import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/admin/list_department_page.dart';
import 'package:todos_app/screens/admin/list_task_assigned_page/task_assigned_page.dart';
import 'package:todos_app/screens/admin/list_user_page.dart';
import 'package:todos_app/screens/home_page.dart';
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
  bool showItem = true;

  @override
  void initState() {
    if (widget.nguoiDung.maPB == 2) {
      showItem = true;
    } else {
      showItem = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listPages = [
      HomePage(nguoiDung: widget.nguoiDung),
      Visibility(
        visible: showItem,
        child: TaskAssignedPage(
          nguoiDung: widget.nguoiDung,
        ),
      ),
      Visibility(
        visible: showItem,
        child: const ListUserPage(),
      ),
      Visibility(visible: showItem, child: const ListDepartmentPage()),
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
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: <BottomNavigationBarItem>[
          MyBottomNavigationBarItem(icon: Icons.home, label: "Trang chủ"),
          MyBottomNavigationBarItem(
              icon: Icons.assignment_rounded, label: "Công việc"),
          MyBottomNavigationBarItem(icon: Icons.person, label: "Người dùng"),
          MyBottomNavigationBarItem(
              icon: Icons.group, label: "Phòng ban"),
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
