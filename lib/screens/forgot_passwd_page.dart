import 'package:flutter/material.dart';
import 'package:todos_app/components/my_text_form_field.dart';

class ForgotPasswdPage extends StatelessWidget {
  ForgotPasswdPage({super.key});

  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController passWdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text(
          "Quên mật khẩu",
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/forgot_passwd.png',
                height: 200,
              ),
              MyTextFormField(
                obscureText: false,
                controller: userNameCtrl,
                text: "Username",
                hintText: "Username",
                enabled: true,
              ),
              MyTextFormField(
                obscureText: true,
                controller: passWdCtrl,
                text: "Password",
                hintText: "Password",
                enabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
