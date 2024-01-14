import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todos_app/bloc/user/add_user_page/add_user_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/services/repositories/phong_ban_repository.dart';
import 'package:path/path.dart' as path;

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController passWdCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController departmentCtrl = TextEditingController(); // phòng ban
  TextEditingController statusCtrl = TextEditingController();
  String? anh;
  File? _imageFile;
  ImageProvider imageProvider = const AssetImage("assets/images/officer.png");

  List<PhongBan> listPhongBan = [];
  int selectedMaPB = 1;
  final String _selectTenPhongBan = 'Phòng ban';

  List<String> listStatus = ['Hoạt động', "Không hoạt động"];
  String _selectedTrangThai = 'Hoạt động';

  @override
  void initState() {
    // TODO: implement initState
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

  void showImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _imageFile = File(file.path);
        anh = file.path;
      });
      print(path.basename(_imageFile!.path));
    } else {
      print("No image selected");
    }
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
            "Thêm người dùng",
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, ["Reload"]);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
          create: (context) => AddUserPageBloc(),
          child: BlocListener<AddUserPageBloc, AddUserPageState>(
            listener: (context, state) {
              if (state is AddUserError) {
                customToast(
                    context: context, title: "Lỗi", message: state.error.toString(), contentType: ContentType.failure);
              } else if (state is AddUserLoaded) {
                customToast(
                    context: context, title: "Thành công", message: state.msg, contentType: ContentType.success);
                Navigator.of(context).pop(["Reload"]);
              }
            },
            child: BlocBuilder<AddUserPageBloc, AddUserPageState>(
              builder: (context, state) {
                if (state is AddUserLoading) {
                  return circularProgressIndicator();
                } else {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Stack(children: [
                            Container(
                              width: 90,
                              height: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                // borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                image: DecorationImage(
                                    image: _imageFile != null ? FileImage(_imageFile!) : imageProvider,
                                    fit: BoxFit.contain),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: showImagePicker,
                                child: const Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            )
                          ]),
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
                            inputType: TextInputType.phone,
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
                              // padding: const EdgeInsets.only(right: 8),
                              items: listPhongBan.map<DropdownMenuItem<PhongBan>>((PhongBan item) {
                                return DropdownMenuItem<PhongBan>(
                                  value: item,
                                  child: Text(item.tenPhongBan.toString()),
                                );
                              }).toList(),
                              onChanged: (PhongBan? newValue) {
                                setState(() {
                                  selectedMaPB = int.parse(newValue!.maPB.toString());
                                  departmentCtrl.text = newValue.tenPhongBan.toString();
                                  // print(selectedMaPB);
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
                              // padding: const EdgeInsets.only(right: 8),
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
                                          message: "Vui lòng nhập đủ thông tin người dùng",
                                          contentType: ContentType.warning);
                                    } else if (!isEmail(emailCtrl.text) && !isPhoneNumber(phoneCtrl.text)) {
                                      customToast(
                                          context: context,
                                          title: "Thông báo",
                                          message: "Email và số điện thoại không đúng định dạng",
                                          contentType: ContentType.warning);
                                    } else if (!isEmail(emailCtrl.text)) {
                                      customToast(
                                          context: context,
                                          title: "Thông báo",
                                          message: "Email không đúng định dạng",
                                          contentType: ContentType.warning);
                                    } else if (!isPhoneNumber(phoneCtrl.text)) {
                                      customToast(
                                          context: context,
                                          title: "Thông báo",
                                          message: "Số điện thoại không đúng định dạng",
                                          contentType: ContentType.warning);
                                    } else {
                                      int status = 1;
                                      if (statusCtrl.text == "Hoạt động") {
                                        status = 1;
                                      } else if (statusCtrl.text == "Không hoạt động") {
                                        status = 0;
                                      }

                                      _imageFile == null
                                          ? BlocProvider.of<AddUserPageBloc>(context).add(AddUserEvent(
                                              userName: userNameCtrl.text,
                                              passWd: passWdCtrl.text,
                                              email: emailCtrl.text,
                                              fullName: fullNameCtrl.text,
                                              phone: phoneCtrl.text,
                                              maPB: selectedMaPB.toString(),
                                              status: status))
                                          : BlocProvider.of<AddUserPageBloc>(context).add(AddUserWithImageEvent(
                                              userName: userNameCtrl.text,
                                              passWd: passWdCtrl.text,
                                              email: emailCtrl.text,
                                              fullName: fullNameCtrl.text,
                                              phone: phoneCtrl.text,
                                              maPB: selectedMaPB.toString(),
                                              status: status,
                                              anh: _imageFile?.path ?? anh.toString()));
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Thêm người dùng",
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
