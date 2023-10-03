import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/department/update_department/update_department_bloc.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/phong_ban.dart';

class UpdateDepartmentPage extends StatefulWidget {
  final PhongBan phongBan;

  const UpdateDepartmentPage({super.key, required this.phongBan});

  @override
  State<UpdateDepartmentPage> createState() => _UpdateDepartmentPageState();
}

class _UpdateDepartmentPageState extends State<UpdateDepartmentPage> {
  TextEditingController tenPhongBanCtrl = TextEditingController();
  List<int> selectedValue = [];

  @override
  void initState() {
    // TODO: implement initState
    tenPhongBanCtrl.text = widget.phongBan.tenPhongBan.toString();
    selectedValue = widget.phongBan.arrMaVT!
        .split(', ')
        .map((e) => int.tryParse(e) ?? 0)
        .toList();

    super.initState();
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
          title: const Text(
            "Cập nhật phòng ban",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => UpdateDepartmentBloc(),
          child: BlocListener<UpdateDepartmentBloc, UpdateDepartmentState>(
            listener: (context, state) {
              if (state is UpdateDepartmentError) {
                toast(state.error.toString());
              } else if (state is UpdatedDepartment) {
                toast(state.msg);
                Navigator.of(context).pop(["Reload"]);
              }
            },
            child: BlocBuilder<UpdateDepartmentBloc, UpdateDepartmentState>(
              builder: (context, state) {
                if (state is UpdatingDepartment) {
                  return circularProgressIndicator();
                } else {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          MyTextFormField(
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
                                BlocProvider.of<UpdateDepartmentBloc>(context)
                                    .add(
                                  UpdateDepartment(
                                    maPB: int.parse(
                                        widget.phongBan.maPB.toString()),
                                    tenPB: tenPhongBanCtrl.text,
                                    arrMaVT: selectedValue.isEmpty
                                        ? '1, 2, 3, 4'
                                        : selectedValue.join(", "),
                                  ),
                                );
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
                                "Cập nhật phòng ban",
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
          setState(() {
            if (isChecked ?? false) {
              selectedValue.add(value);
            } else {
              selectedValue.remove(value);
            }
            print(selectedValue);
          });
        });
  }
}
