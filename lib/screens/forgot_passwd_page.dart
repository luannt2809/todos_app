import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/forgot_passwd_page/forgot_passwd_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';

class ForgotPasswdPage extends StatelessWidget {
  ForgotPasswdPage({super.key});

  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController passWdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswdPageBloc(),
      child: Scaffold(
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
        body: BlocListener<ForgotPasswdPageBloc, ForgotPasswdPageState>(
          listener: (context, state) {
            if (state is ForgotPasswdPageError) {
              customToast(
                  context: context,
                  title: "Lỗi",
                  message: state.error.toString(),
                  contentType: ContentType.failure);
              userNameCtrl.text = "";
            } else if (state is ForgotPasswdPageLoaded) {
              customToast(
                  context: context,
                  title: "Thành công",
                  message: state.msg,
                  contentType: ContentType.success);
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<ForgotPasswdPageBloc, ForgotPasswdPageState>(
            builder: (context, state) {
              if (state is ForgotPasswdPageLoading) {
                return circularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 45,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              if (userNameCtrl.text.isEmpty ||
                                  passWdCtrl.text.isEmpty) {
                                customToast(
                                    context: context,
                                    title: "Thông báo",
                                    message:
                                        "Vui lòng nhập đủ thông tin người dùng",
                                    contentType: ContentType.warning);
                              } else {
                                BlocProvider.of<ForgotPasswdPageBloc>(context)
                                    .add(ForgotPasswdEvent(
                                        tenND: userNameCtrl.text,
                                        matKhau: passWdCtrl.text));
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepOrangeAccent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Đổi mật khẩu",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
