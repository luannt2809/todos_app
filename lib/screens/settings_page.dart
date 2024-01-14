import 'package:cached_network_image/cached_network_image.dart';
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
  final ImageProvider imageProvider = const AssetImage("assets/images/officer.png");

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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: widget.nguoiDung.anh.toString() == "null"
                    ? Image.asset("assets/images/officer.png")
                    : CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: "http://192.168.1.30:3000/${widget.nguoiDung.anh}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                        ),
                        progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Colors.deepOrangeAccent,
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
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
                child: Row(
                  children: const [
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
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
                  return ProfilePage(
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
                child: Row(
                  children: const [
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
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
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
                child: Row(
                  children: const [
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
