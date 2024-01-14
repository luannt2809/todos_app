import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/login_page/login_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/screens/admin/admin_screen.dart';
import 'package:todos_app/screens/forgot_passwd_page.dart';
import 'package:todos_app/screens/user_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: w,
          height: h,
          child: BlocProvider(
            create: (context) => LoginPageBloc(),
            child: BlocListener<LoginPageBloc, LoginPageState>(
              listener: (context, state) {
                if (state is LoginPageError) {
                  customToast(
                      context: context,
                      title: "Lỗi",
                      message: state.error.toString(),
                      contentType: ContentType.failure);
                } else if (state is LoginPageSuccess) {
                  customToast(
                      context: context,
                      title: "Thành công",
                      message: state.msg,
                      contentType: ContentType.success);
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    if (state.nguoiDung.maPB == 2) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return AdminScreen(
                          nguoiDung: state.nguoiDung,
                        );
                      }));
                    } else {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return UserScreen(
                          nguoiDung: state.nguoiDung,
                        );
                      }));
                    }
                  }
                }
              },
              child: BlocBuilder<LoginPageBloc, LoginPageState>(
                builder: (context, state) {
                  if (state is LoginPageLoading) {
                    return circularProgressIndicator();
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 50),
                            child: Center(
                              child: Image.asset(
                                "assets/images/logo.png",
                                width: 130,
                                height: 130,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextField(
                                  controller: userNameController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange, width: 2.0),
                                      ),
                                      hintText: "Tên người dùng"),
                                  cursorColor: Colors.deepOrangeAccent,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: passwdController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange, width: 2.0),
                                      ),
                                      hintText: "Mật khẩu"),
                                  cursorColor: Colors.deepOrangeAccent,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ForgotPasswdPage()));
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.orange),
                                  child: const Text(
                                    "Quên mật khẩu?",
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: w,
                                  height: 45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.deepOrangeAccent),
                                    onPressed: () {
                                      if (userNameController.text.isEmpty ||
                                          passwdController.text.isEmpty) {
                                        customToast(
                                            context: context,
                                            title: "Thông báo",
                                            message:
                                                "Vui lòng nhập đủ thông tin đăng nhập",
                                            contentType: ContentType.warning);
                                      } else {
                                        BlocProvider.of<LoginPageBloc>(context)
                                            .add(LoginEvent(
                                            username: userNameController.text,
                                            passwd: passwdController.text));
                                      }
                                    },
                                    child: const Text(
                                      "Đăng nhập",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
