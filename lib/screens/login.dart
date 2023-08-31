import 'package:flutter/material.dart';
import 'package:todos_app/screens/userscreen.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          child: SingleChildScrollView(
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
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 2.0),
                            ),
                            hintText: "Tên người dùng"),
                        cursorColor: Colors.deepOrangeAccent,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.orange, width: 2.0),
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
                              backgroundColor: Colors.deepOrangeAccent),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => HomePage(),
                            //   ),
                            // );
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const UserScreen();
                                  },
                                ),
                              );
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
          ),
        ),
      ),
    );
  }
}
