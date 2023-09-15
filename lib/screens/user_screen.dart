import 'package:flutter/material.dart';
import 'package:todos_app/screens/home_page.dart';
import 'package:todos_app/screens/notify_page.dart';
import 'package:todos_app/screens/profile_page.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> listPages = [const HomePage(), const NotifyPage(), const ProfilePage()];

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
        selectedItemColor: Colors.deepOrangeAccent,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          MyBottomNavigationBarItem(icon: Icons.home, label: "Trang chủ"),
          MyBottomNavigationBarItem(
              icon: Icons.notifications_rounded, label: "Thông báo"),
          MyBottomNavigationBarItem(
              icon: Icons.perm_contact_cal_rounded, label: "Hồ sơ"),
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
