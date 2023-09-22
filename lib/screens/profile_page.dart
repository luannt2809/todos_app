import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/profile_page/profile_page_bloc.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/nguoi_dung.dart';

class ProfilePage extends StatefulWidget {
  final String hoTen;
  const ProfilePage({super.key, required this.hoTen});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfilePageBloc profilePageBloc = ProfilePageBloc();
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();
  TextEditingController departmentCtrl = TextEditingController(); // phòng ban
  TextEditingController statusCtrl = TextEditingController();

  getData() async {
    profilePageBloc.add(GetInfoEvent());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, ["Reload", fullNameCtrl.text]);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.orangeAccent,
            size: 20,
          ),
        ),
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text(
          "Thông tin cá nhân",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => profilePageBloc,
        child: BlocListener<ProfilePageBloc, ProfilePageState>(
          listener: (context, state) {
            if (state is GetInfoError) {
              toast(state.error.toString());
            } else if (state is GetInfoLoaded) {
              NguoiDung nguoiDung = state.userList[0];
              userNameCtrl.text = nguoiDung.tenNguoiDung;
              emailCtrl.text = nguoiDung.email;
              fullNameCtrl.text = nguoiDung.hoTen;
              phoneCtrl.text = nguoiDung.soDienThoai;
              roleCtrl.text = nguoiDung.tenVaiTro;
              departmentCtrl.text = nguoiDung.tenPhongBan;
              statusCtrl.text = nguoiDung.trangThai == true
                  ? "Đang hoạt động"
                  : "Không hoạt động";
            } else if (state is ChangeInfoError) {
              toast(state.error.toString());
            } else if (state is ChangeInfoSuccess) {
              toast(state.msg);
            }
          },
          child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
            builder: (context, state) {
              if (state is GetInfoLoading) {
                return circularProgressIndicator();
              } else if (state is ChangingInfo) {
                return circularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                            child: Image.asset("assets/images/user.png"),
                          ),
                        ),
                        MyTextFormField(
                          controller: userNameCtrl,
                          text: "Username",
                          hintText: "Username",
                          enabled: true,
                        ),
                        MyTextFormField(
                          controller: emailCtrl,
                          text: "Email",
                          hintText: "Email",
                          enabled: true,
                        ),
                        MyTextFormField(
                          controller: fullNameCtrl,
                          text: "Họ và tên",
                          hintText: "Họ và tên",
                          enabled: true,
                        ),
                        MyTextFormField(
                          controller: phoneCtrl,
                          text: "Số điện thoại",
                          hintText: "Số điện thoại",
                          enabled: true,
                        ),
                        MyTextFormField(
                          controller: roleCtrl,
                          text: "Vai trò",
                          hintText: "Vai trò",
                          enabled: false,
                        ),
                        MyTextFormField(
                          controller: departmentCtrl,
                          text: "Phòng ban",
                          hintText: "Phòng ban",
                          enabled: false,
                        ),
                        MyTextFormField(
                          controller: statusCtrl,
                          text: "Trạng thái",
                          hintText: "Trạng thái",
                          enabled: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (userNameCtrl.text.isEmpty ||
                                      emailCtrl.text.isEmpty ||
                                      fullNameCtrl.text.isEmpty ||
                                      phoneCtrl.text.isEmpty ||
                                      roleCtrl.text.isEmpty ||
                                      departmentCtrl.text.isEmpty ||
                                      statusCtrl.text.isEmpty) {
                                    toast(
                                        "Vui lòng nhập đủ thông tin người dùng");
                                  } else {
                                    BlocProvider.of<ProfilePageBloc>(context)
                                        .add(ChangeInfoEvent(
                                            userName: userNameCtrl.text,
                                            email: emailCtrl.text,
                                            fullName: fullNameCtrl.text,
                                            phone: phoneCtrl.text));
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
                                  "Cập nhật thông tin",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
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

// Widget buildBody(NguoiDung nguoiDung) {}
}
