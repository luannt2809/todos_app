import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/user/add_user_page/add_user_page_bloc.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/services/repositories/phong_ban_repository.dart';

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

  List<PhongBan> listPhongBan = [];
  int selectedMaPB = 1;
  String _selectTenPhongBan = 'Phòng ban';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
              toast(state.error.toString());
            } else if (state is AddUserLoaded) {
              toast(state.msg);
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
                          controller: userNameCtrl,
                          text: "Username",
                          hintText: "Username",
                          enabled: true,
                        ),
                        MyTextFormField(
                          controller: passWdCtrl,
                          text: "Password",
                          hintText: "Password",
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
                          controller: departmentCtrl,
                          text: "Phòng ban",
                          hintText: _selectTenPhongBan,
                          enabled: true,
                          widget: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 30,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            padding: EdgeInsets.only(right: 8),
                            items: listPhongBan.map<DropdownMenuItem<PhongBan>>(
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
                          controller: statusCtrl,
                          text: "Trạng thái",
                          hintText: _selectedTrangThai,
                          enabled: true,
                          widget: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 30,
                            elevation: 4,
                            underline: Container(
                              height: 0,
                            ),
                            padding: EdgeInsets.only(right: 8),
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
                                    toast(
                                        "Vui lòng nhập đủ thông tin người dùng");
                                  } else {
                                    int status = 1;
                                    if (statusCtrl.text == "Hoạt động") {
                                      status = 1;
                                    } else if (statusCtrl.text ==
                                        "Không hoạt động") {
                                      status = 0;
                                    }
                                    BlocProvider.of<AddUserPageBloc>(context)
                                        .add(AddUserEvent(
                                            userName: userNameCtrl.text,
                                            passWd: passWdCtrl.text,
                                            email: emailCtrl.text,
                                            fullName: fullNameCtrl.text,
                                            phone: phoneCtrl.text,
                                            maPB: selectedMaPB.toString(),
                                            status: status));
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
    );
  }
}
