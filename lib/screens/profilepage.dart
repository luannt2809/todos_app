import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 20),
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
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              const MyTextFormField(
                text: "Username",
                hintText: "Username",
                enabled: true,
              ),
              const MyTextFormField(
                text: "Email",
                hintText: "Email",
                enabled: true,
              ),
              const MyTextFormField(
                text: "Họ và tên",
                hintText: "Họ và tên",
                enabled: true,
              ),
              const MyTextFormField(
                text: "Số điện thoại",
                hintText: "Số điện thoại",
                enabled: true,
              ),
              const MyTextFormField(
                text: "Vai trò",
                hintText: "Vai trò",
                enabled: false,
              ),
              const MyTextFormField(
                text: "Phòng ban",
                hintText: "Phòng ban",
                enabled: false,
              ),
              const MyTextFormField(
                text: "Trạng thái",
                hintText: "Trạng thái",
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String text;
  final String hintText;
  final bool enabled;

  const MyTextFormField(
      {super.key,
      required this.text,
      required this.hintText,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: hintText,
                      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabled: enabled,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
