import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/screens/user_screen.dart';
import 'package:todos_app/services/config/api_config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Dio dio = Dio();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  Future<void> login() async {
    String username = userNameController.text;
    String passwd = passwdController.text;
    String msg = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if(username.isEmpty || passwd.isEmpty){
      msg = "Vui lòng nhập đủ thông tin";
    } else {
      try {
        Response response =
        await dio.post('${ApiConfig.BASE_URL}/nguoidung/login', data: {
          'TenNguoiDung': username,
          'MatKhau': passwd,
        });

        if (response.statusCode == 200) {

          msg = response.data['msg'];
          await prefs.setInt("maND", response.data['maND']);

          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const UserScreen();
                },
              ),
            );
          }
        }
      } on DioException catch (e) {
        if (e.type == DioExceptionType.badResponse) {
          msg = "${e.response?.data}";
        }
      }
    }

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    // hide keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }

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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: userNameController,
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
                      TextField(
                        controller: passwdController,
                        obscureText: true,
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
                          onPressed: login,
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
