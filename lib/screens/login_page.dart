import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/login_page/login_page_bloc.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/screens/user_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Dio dio = Dio();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => LoginPageBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: w,
            height: h,
            child: BlocListener<LoginPageBloc, LoginPageState>(
              listener: (context, state) {
                if (state is LoginPageError) {
                  toast(state.error.toString());
                } else if (state is LoginPageSuccess) {
                  toast(state.msg);
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const UserScreen();
                    }));
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
                                  onPressed: () {},
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
                                      BlocProvider.of<LoginPageBloc>(context)
                                          .add(LoginEvent(
                                              username: userNameController.text,
                                              passwd: passwdController.text));
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
