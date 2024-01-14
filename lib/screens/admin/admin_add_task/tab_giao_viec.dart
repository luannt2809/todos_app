import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/bloc/task/admin_add_task_page/admin_add_task_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/services/repositories/nguoi_dung_repository.dart';

class TabGiaoViec extends StatefulWidget {
  const TabGiaoViec({super.key});

  @override
  State<TabGiaoViec> createState() => _TabGiaoViecState();
}

class _TabGiaoViecState extends State<TabGiaoViec> {
  DateTime _selectStartDate = DateTime.now();
  DateTime _selectEndDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedTrangThai = 'Chờ nhận';

  List<NguoiDung> listNguoiLam = [];
  int selectMaNL = 1;
  String selectTenNL = "Người làm";

  int? maNguoiGiao;

  TextEditingController nguoiLamCtrl = TextEditingController();
  TextEditingController tieuDeCtrl = TextEditingController();
  TextEditingController noiDungCtrl = TextEditingController();
  TextEditingController ngayBDCtrl = TextEditingController();
  TextEditingController ngayKTCtrl = TextEditingController();
  TextEditingController gioBDCtrl = TextEditingController();
  TextEditingController gioKTCtrl = TextEditingController();
  TextEditingController trangThaiCtrl = TextEditingController();
  TextEditingController tienDoCtrl = TextEditingController();
  TextEditingController ghiChuCtrl = TextEditingController();

  @override
  void dispose() {
    nguoiLamCtrl.dispose();
    tieuDeCtrl.dispose();
    noiDungCtrl.dispose();
    ngayBDCtrl.dispose();
    ngayKTCtrl.dispose();
    gioBDCtrl.dispose();
    gioKTCtrl.dispose();
    trangThaiCtrl.dispose();
    tienDoCtrl.dispose();
    ghiChuCtrl.dispose();
    super.dispose();
  }

  List<String> listTrangThai = ['Chờ nhận', 'Đã nhận', 'Đang thực hiện', 'Hoàn thành'];

  void setMaNguoiGiao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      maNguoiGiao = prefs.getInt("maND");
      // print(maNguoiGiao);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    NguoiDungRepository().getListOthers().then((value) {
      setState(() {
        listNguoiLam = value;
      });
    }).catchError((onError) {
      throw Exception(onError);
    });

    setMaNguoiGiao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminAddTaskPageBloc(),
      child: BlocListener<AdminAddTaskPageBloc, AdminAddTaskPageState>(
        listener: (context, state) {
          if (state is AdminAddTaskPageLoaded) {
            customToast(context: context, title: "Thành công", message: state.msg, contentType: ContentType.success);
            Navigator.of(context).pop();
          } else if (state is AdminAddTaskPageError) {
            customToast(
                context: context, title: "Lỗi", message: state.error.toString(), contentType: ContentType.failure);
          }
        },
        child: BlocBuilder<AdminAddTaskPageBloc, AdminAddTaskPageState>(
          builder: (context, state) {
            if (state is AdminAddTaskPageLoading) {
              return circularProgressIndicator();
            } else {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MyTextFormField(
                                obscureText: false,
                                controller: nguoiLamCtrl,
                                text: "Người làm",
                                hintText: selectTenNL,
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
                                  items: listNguoiLam.map<DropdownMenuItem<NguoiDung>>((NguoiDung item) {
                                    return DropdownMenuItem<NguoiDung>(
                                      value: item,
                                      child: Text(item.hoTen.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (NguoiDung? newValue) {
                                    setState(() {
                                      selectMaNL = int.parse(newValue!.maND.toString());
                                      nguoiLamCtrl.text = newValue.hoTen.toString();
                                      // print(selectMaNL);
                                    });
                                  },
                                ),
                              ),
                              MyTextFormField(
                                obscureText: false,
                                text: "Tiêu đề",
                                hintText: "Tiêu đề",
                                controller: tieuDeCtrl,
                              ),
                              MyTextFormField(
                                obscureText: false,
                                text: "Nội dung",
                                hintText: "Nội dung",
                                controller: noiDungCtrl,
                              ),
                              MyTextFormField(
                                obscureText: false,
                                controller: ngayBDCtrl,
                                text: "Ngày bắt đầu",
                                hintText: DateFormat('dd-MM-yyyy').format(_selectStartDate),
                                widget: IconButton(
                                  onPressed: () {
                                    // _getDateStartFromUser();
                                    _getDateFromUser(isStartDate: true);
                                  },
                                  icon: const Icon(Icons.calendar_month_outlined),
                                  color: Colors.grey,
                                ),
                              ),
                              MyTextFormField(
                                obscureText: false,
                                controller: ngayKTCtrl,
                                text: "Ngày kết thúc",
                                hintText: DateFormat('dd-MM-yyyy').format(_selectEndDate),
                                widget: IconButton(
                                  onPressed: () {
                                    _getDateFromUser(isStartDate: false);
                                  },
                                  icon: const Icon(Icons.calendar_month_outlined),
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: MyTextFormField(
                                      obscureText: false,
                                      controller: gioBDCtrl,
                                      text: "Giờ bắt đầu",
                                      hintText: _startTime,
                                      widget: IconButton(
                                        icon: const Icon(Icons.access_time),
                                        color: Colors.grey,
                                        onPressed: () {
                                          _getTimeFromUser(isStartTime: true);
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: MyTextFormField(
                                      obscureText: false,
                                      controller: gioKTCtrl,
                                      text: "Giờ kết thúc",
                                      hintText: _endTime,
                                      widget: IconButton(
                                        icon: const Icon(Icons.access_time),
                                        color: Colors.grey,
                                        onPressed: () {
                                          _getTimeFromUser(isStartTime: false);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              MyTextFormField(
                                obscureText: false,
                                controller: trangThaiCtrl,
                                text: "Trạng thái",
                                hintText: _selectedTrangThai,
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
                                      trangThaiCtrl.text = newValue;
                                    });
                                  },
                                  items: listTrangThai.map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              MyTextFormField(
                                obscureText: false,
                                controller: tienDoCtrl,
                                text: "Tiến độ",
                                hintText: "Tiến độ",
                                inputType: TextInputType.number,
                              ),
                              MyTextFormField(
                                obscureText: false,
                                controller: ghiChuCtrl,
                                text: "Ghi chú",
                                hintText: "Ghi chú",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 45,
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (tieuDeCtrl.text.isEmpty ||
                                            noiDungCtrl.text.isEmpty ||
                                            ngayBDCtrl.text.isEmpty ||
                                            ngayKTCtrl.text.isEmpty ||
                                            gioBDCtrl.text.isEmpty ||
                                            gioKTCtrl.text.isEmpty ||
                                            trangThaiCtrl.text.isEmpty ||
                                            tienDoCtrl.text.isEmpty) {
                                          customToast(
                                              context: context,
                                              title: "Thông báo",
                                              message: "Vui lòng nhập đủ thông tin công việc",
                                              contentType: ContentType.warning);
                                        } else if (double.parse(tienDoCtrl.text) < 0 ||
                                            double.parse(tienDoCtrl.text) > 100) {
                                          customToast(
                                              context: context,
                                              title: "Thông báo",
                                              message: "Vui lòng nhập tiến độ 0 - 100",
                                              contentType: ContentType.warning);
                                        } else {
                                          // them cong viec ơ day
                                          BlocProvider.of<AdminAddTaskPageBloc>(context).add(AdminAddTaskEvent(
                                              tieuDe: tieuDeCtrl.text,
                                              noiDung: noiDungCtrl.text,
                                              ngayBD: DateFormat("yyyy-MM-dd").format(_selectStartDate),
                                              ngayKT: DateFormat("yyyy-MM-dd").format(_selectEndDate),
                                              gioBD: gioBDCtrl.text,
                                              gioKT: gioKTCtrl.text,
                                              trangThai: trangThaiCtrl.text,
                                              tienDo: tienDoCtrl.text,
                                              ghiChu: ghiChuCtrl.text.isEmpty ? "Không có ghi chú" : ghiChuCtrl.text,
                                              maNguoiLam: selectMaNL,
                                              maNguoiGiao: maNguoiGiao));
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
                                        "Tạo công việc",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
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
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();
    if (!context.mounted) return;
    String formatedTime = pickerTime.format(context);
    if (pickerTime == null) {
      print("Time canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = formatedTime;
        gioBDCtrl.text = formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = formatedTime;
        gioKTCtrl.text = formatedTime;
      });
    }
  }

  _getDateFromUser({required bool isStartDate}) async {
    DateTime? pickerDate = await _showDatePicker();
    // print(pickerDate.toString());
    if (pickerDate == null) {
      print("Date cancel");
    } else if (isStartDate == true) {
      setState(() {
        _selectStartDate = pickerDate;
        ngayBDCtrl.text = DateFormat('dd-MM-yyyy').format(_selectStartDate);
      });
    } else if (isStartDate == false) {
      setState(() {
        _selectEndDate = pickerDate;
        ngayKTCtrl.text = DateFormat('dd-MM-yyyy').format(_selectEndDate);
      });
    }
  }

  _showDatePicker() async {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          const Duration(days: 0),
        ),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.deepOrangeAccent,
                colorScheme: const ColorScheme.light(primary: Colors.deepOrangeAccent),
                buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });
  }

  _showTimePicker() async {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      // initialTime: TimeOfDay(
      //     hour: int.parse(_startTime.split(":")[0]),
      //     minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.deepOrangeAccent,
              colorScheme: const ColorScheme.light(primary: Colors.deepOrangeAccent),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
  }
}
