import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/department/add_department/add_department_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';

class AddDepartmentPage extends StatefulWidget {
  const AddDepartmentPage({super.key});

  @override
  State<AddDepartmentPage> createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddDepartmentPage> {
  TextEditingController tenPhongBanCtrl = TextEditingController();
  List<int> selectedValue = [];

  void handleCheckboxValueChanged(int value, bool isChecked) {
    setState(() {
      if (isChecked) {
        selectedValue.add(value);
      } else {
        selectedValue.remove(value);
      }
    });
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
            "Thêm phòng ban",
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
          create: (context) => AddDepartmentBloc(),
          child: BlocListener<AddDepartmentBloc, AddDepartmentState>(
            listener: (context, state) {
              if (state is AddDepartmentError) {
                customToast(
                    context: context,
                    title: "Lỗi",
                    message: state.error.toString(),
                    contentType: ContentType.failure);
              } else if (state is AddDepartmentLoaded) {
                customToast(
                    context: context,
                    title: "Thành công",
                    message: state.msg,
                    contentType: ContentType.success);
                Navigator.of(context).pop(["Reload"]);
              }
            },
            child: BlocBuilder<AddDepartmentBloc, AddDepartmentState>(
              builder: (context, state) {
                if (state is AddDepartmentLoading) {
                  return circularProgressIndicator();
                } else {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          MyTextFormField(
                            obscureText: false,
                            text: "Tên phòng ban",
                            hintText: "Tên phòng ban",
                            controller: tenPhongBanCtrl,
                            enabled: true,
                            inputType: TextInputType.text,
                          ),
                          buildCheckbox(1, "Xem"),
                          buildCheckbox(2, "Thêm"),
                          buildCheckbox(3, "Cập nhật"),
                          buildCheckbox(4, "Xoá"),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                if (tenPhongBanCtrl.text.isEmpty) {
                                  customToast(
                                      context: context,
                                      title: "Thông báo",
                                      message:
                                          "Vui lòng nhập đủ thông tin phòng ban",
                                      contentType: ContentType.warning);
                                } else {
                                  BlocProvider.of<AddDepartmentBloc>(context)
                                      .add(
                                    AddDepartment(
                                      tenPhongBanCtrl.text,
                                      selectedValue.isEmpty
                                          ? '1, 2, 3, 4'
                                          : selectedValue.join(", "),
                                    ),
                                  );
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
                                "Thêm phòng ban",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckbox(int value, String title) {
    return CheckboxListTile(
        checkColor: Colors.white,
        activeColor: Colors.deepOrangeAccent,
        title: Text(title),
        value: selectedValue.contains(value),
        onChanged: (isChecked) {
          handleCheckboxValueChanged(value, isChecked ?? false);
        });
  }
}
