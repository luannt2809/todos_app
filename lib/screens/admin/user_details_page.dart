import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/themes/styles.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class UserDetailsPage extends StatefulWidget {
  final NguoiDung nguoiDung;

  const UserDetailsPage({super.key, required this.nguoiDung});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  String trangThai = "";

  @override
  void initState() {
    // TODO: implement initState
    if (widget.nguoiDung.trangThai == true) {
      setState(() {
        trangThai = "Hoạt động";
      });
    } else {
      setState(() {
        trangThai = "Hoạt động";
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: const Text(
            "Thông tin chi tiết",
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, ["Reload"]);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.orangeAccent,
              size: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/officer.png",
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Uri uri =
                              Uri.parse('tel:${widget.nguoiDung.soDienThoai}');
                          launcher.launchUrl(uri);
                        },
                        child: iconAction(Icons.call)),
                    GestureDetector(
                        onTap: () {
                          Uri uri =
                              Uri.parse('mailto:${widget.nguoiDung.email}');
                          launcher.launchUrl(uri);
                        },
                        child: iconAction(Icons.email))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: Styles.boxDecoration,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text("Username")),
                        Text("${widget.nguoiDung.tenNguoiDung}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Họ và tên")),
                        Text("${widget.nguoiDung.hoTen}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Số điện thoại")),
                        Text("${widget.nguoiDung.soDienThoai}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Email")),
                        Text("${widget.nguoiDung.email}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Phòng ban")),
                        Text("${widget.nguoiDung.tenPhongBan}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Quyền")),
                        Text("${widget.nguoiDung.danhSachVaiTro}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Trạng thái")),
                        Text(
                          "${trangThai}",
                          style: TextStyle(
                              color: widget.nguoiDung.trangThai ?? false
                                  ? Colors.green
                                  : Colors.deepOrange),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget iconAction(IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Icon(
        iconData,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}
