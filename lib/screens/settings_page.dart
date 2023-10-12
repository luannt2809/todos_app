import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/login_page.dart';
import 'package:todos_app/screens/profile_page.dart';
import 'package:todos_app/screens/statistical_page/statistical_page.dart';
import 'package:todos_app/themes/styles.dart';

class SettingsPage extends StatefulWidget {
  final NguoiDung nguoiDung;

  const SettingsPage({super.key, required this.nguoiDung});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text(
          "Cài đặt",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset("assets/images/officer.png"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.nguoiDung.hoTen!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 10),
                decoration: Styles.boxDecoration,
                child: const Row(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Thông tin cá nhân",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) {
                  return ProfilePage(hoTen: widget.nguoiDung.hoTen!);
                })).then((value) {
                  if (value != null && value[1] != null) {
                    setState(() {
                      widget.nguoiDung.hoTen = value[1];
                    });
                  }
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 10),
                decoration: Styles.boxDecoration,
                child: const Row(
                  children: [
                    Icon(
                      Icons.stacked_bar_chart_rounded,
                      size: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Thống kê",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) {
                  return StatisticalPage(
                    nguoiDung: widget.nguoiDung,
                  );
                }));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 10),
                decoration: Styles.boxDecoration,
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 25,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Đăng xuất",
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    )
                  ],
                ),
              ),
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
