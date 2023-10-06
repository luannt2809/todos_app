import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/user/update_user_page/update_user_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/services/repositories/phong_ban_repository.dart';

class UpdateUserPage extends StatefulWidget {
  final NguoiDung nguoiDung;

  const UpdateUserPage({required this.nguoiDung, super.key});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passWdCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController departmentCtrl = TextEditingController(); // phòng ban
  TextEditingController statusCtrl = TextEditingController();

  List<PhongBan> listPhongBan = [];
  int selectedMaPB = 1;
  String _selectTenPhongBan = 'Phòng ban';

  List<String> listStatus = ['Hoạt động', "Không hoạt động"];
  String _selectedTrangThai = 'Hoạt động';

  @override
  void initState() {
    // TODO: implement initState
    userNameCtrl.text = widget.nguoiDung.tenNguoiDung.toString();
    emailCtrl.text = widget.nguoiDung.email.toString();
    fullNameCtrl.text = widget.nguoiDung.hoTen.toString();
    phoneCtrl.text = widget.nguoiDung.soDienThoai.toString();
    selectedMaPB = int.parse(widget.nguoiDung.maPB.toString());
    departmentCtrl.text = widget.nguoiDung.tenPhongBan.toString();
    if (widget.nguoiDung.trangThai == true) {
      statusCtrl.text = "Hoạt động";
    } else {
      statusCtrl.text = "Không hoạt động";
    }

    PhongBanRepository().getListDepartment().then((value) {
      setState(() {
        listPhongBan = value;
      });
    }).catchError((err) {
      throw Exception(err);
    });

    super.initState();
  }

  // validate
  bool isEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isPhoneNumber(String phoneNumber) {
    final phoneNumberRegex = RegExp(r'^(?:\+84|0[0-9]{9})$');
    return phoneNumberRegex.hasMatch(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: const Text(
            "Cập nhật người dùng",
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
        body: BlocProvider(
          create: (context) => UpdateUserPageBloc(),
          child: BlocListener<UpdateUserPageBloc, UpdateUserPageState>(
            listener: (context, state) {
              if (state is UpdateUserError) {
                customToast(
                    context: context,
                    title: "Lỗi",
                    message: state.error.toString(),
                    contentType: ContentType.failure);
              } else if (state is UpdatedUser) {
                customToast(
                    context: context,
                    title: "Thành công",
                    message: state.msg,
                    contentType: ContentType.success);
                Navigator.of(context).pop(["Reload"]);
              }
            },
            child: BlocBuilder<UpdateUserPageBloc, UpdateUserPageState>(
              builder: (context, state) {
                if (state is UpdatingUser) {
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
                              child: Image.asset("assets/images/officer.png"),
                            ),
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
                          MyTextFormField(
                            obscureText: false,
                            controller: emailCtrl,
                            text: "Email",
                            hintText: "Email",
                            enabled: true,
                          ),
                          MyTextFormField(
                            obscureText: false,
                            controller: fullNameCtrl,
                            text: "Họ và tên",
                            hintText: "Họ và tên",
                            enabled: true,
                          ),
                          MyTextFormField(
                            obscureText: false,
                            controller: phoneCtrl,
                            text: "Số điện thoại",
                            hintText: "Số điện thoại",
                            enabled: true,
                          ),
                          MyTextFormField(
                            obscureText: false,
                            controller: departmentCtrl,
                            text: "Phòng ban",
                            hintText: _selectTenPhongBan,
                            enabled: true,
                            widget: DropdownButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              iconSize: 30,
                              elevation: 4,
                              underline: Container(
                                height: 0,
                              ),
                              padding: const EdgeInsets.only(right: 8),
                              items: listPhongBan
                                  .map<DropdownMenuItem<PhongBan>>(
                                      (PhongBan item) {
                                return DropdownMenuItem<PhongBan>(
                                  value: item,
                                  child: Text(item.tenPhongBan.toString()),
                                );
                              }).toList(),
                              onChanged: (PhongBan? newValue) {
                                setState(() {
                                  selectedMaPB =
                                      int.parse(newValue!.maPB.toString());
                                  departmentCtrl.text =
                                      newValue.tenPhongBan.toString();
                                  print(selectedMaPB);
                                });
                              },
                            ),
                          ),
                          MyTextFormField(
                            obscureText: false,
                            controller: statusCtrl,
                            text: "Trạng thái",
                            hintText: _selectedTrangThai,
                            enabled: true,
                            widget: DropdownButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                              ),
                              iconSize: 30,
                              elevation: 4,
                              underline: Container(
                                height: 0,
                              ),
                              padding: const EdgeInsets.only(right: 8),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedTrangThai = newValue!;
                                  statusCtrl.text = newValue;
                                });
                              },
                              items: listStatus.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                            ),
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
                                        departmentCtrl.text.isEmpty ||
                                        statusCtrl.text.isEmpty) {
                                      customToast(
                                          context: context,
                                          title: "Thông báo",
                                          message:
                                              "Vui lòng nhập đủ thông tin người dùng",
                                          contentType: ContentType.warning);
                                    } else {
                                      int? status;
                                      if (statusCtrl.text == "Hoạt động") {
                                        status = 1;
                                      } else if (statusCtrl.text ==
                                          "Không hoạt động") {
                                        status = 0;
                                      }

                                      BlocProvider.of<UpdateUserPageBloc>(
                                              context)
                                          .add(UpdateUserEvent(
                                              maND: int.parse(widget
                                                  .nguoiDung.maND
                                                  .toString()),
                                              userName: userNameCtrl.text,
                                              passWd: passWdCtrl.text,
                                              email: emailCtrl.text,
                                              fullName: fullNameCtrl.text,
                                              phone: phoneCtrl.text,
                                              maPB: selectedMaPB.toString(),
                                              status: status!));
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
                                    "Cập nhật người dùng",
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
      ),
    );
  }
}
