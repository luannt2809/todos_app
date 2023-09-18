import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/bloc/update_task_page/update_task_page_bloc.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/cong_viec.dart';

class UpdateTaskPage extends StatefulWidget {
  final CongViec congViec;

  const UpdateTaskPage({super.key, required this.congViec});

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  DateTime _selectStartDate = DateTime.now();
  DateTime _selectEndDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedTrangThai = 'Chờ nhận';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillDataCongViec();
  }

  TextEditingController tieuDeCtrl = TextEditingController();
  TextEditingController noiDungCtrl = TextEditingController();
  TextEditingController ngayBDCtrl = TextEditingController();
  TextEditingController ngayKTCtrl = TextEditingController();
  TextEditingController gioBDCtrl = TextEditingController();
  TextEditingController gioKTCtrl = TextEditingController();
  TextEditingController trangThaiCtrl = TextEditingController();
  TextEditingController tienDoCtrl = TextEditingController();
  TextEditingController ghiChuCtrl = TextEditingController();

  fillDataCongViec() {
    tieuDeCtrl.text = widget.congViec.tieuDe.toString();
    noiDungCtrl.text = widget.congViec.noiDung.toString();
    ngayBDCtrl.text = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(widget.congViec.ngayBatDau.toString()));
    ngayKTCtrl.text = DateFormat('dd-MM-yyyy')
        .format(DateTime.parse(widget.congViec.ngayKetThuc.toString()));
    gioBDCtrl.text = DateFormat("hh:mm a")
        .format(DateTime.parse(widget.congViec.gioBatDau.toString()))
        .toString();
    gioKTCtrl.text = DateFormat("hh:mm a")
        .format(DateTime.parse(widget.congViec.gioBatDau.toString()))
        .toString();
    trangThaiCtrl.text = widget.congViec.trangThai.toString();
    tienDoCtrl.text = widget.congViec.tienDo.toString();
    ghiChuCtrl.text = widget.congViec.ghiChu.toString();
  }

  @override
  void dispose() {
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

  List<String> listTrangThai = [
    'Chờ nhận',
    'Đã nhận',
    'Đang thực hiện',
    'Hoàn thành'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateTaskPageBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, ["Reload"]);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.orangeAccent,
              size: 20,
            ),
          ),
          title: const Text(
            "Cập nhật công việc",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<UpdateTaskPageBloc, UpdateTaskPageState>(
          listener: (context, state) {
            if (state is UpdateTaskPageLoaded) {
              toast(state.msg);
              Navigator.pop(context, ["Reload"]);
            } else if (state is UpdateTaskPageError) {
              toast(state.error.toString());
            }
          },
          builder: (context, state) {
            return BlocBuilder<UpdateTaskPageBloc, UpdateTaskPageState>(
              builder: (context, state) {
                if (state is UpdateTaskPageLoading) {
                  return circularProgressIndicator();
                } else {
                  return SafeArea(
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
                                    text: "Tiêu đề",
                                    hintText: "Tiêu đề",
                                    controller: tieuDeCtrl,
                                  ),
                                  MyTextFormField(
                                    text: "Nội dung",
                                    hintText: "Nội dung",
                                    controller: noiDungCtrl,
                                  ),
                                  MyTextFormField(
                                    controller: ngayBDCtrl,
                                    text: "Ngày bắt đầu",
                                    hintText: DateFormat.yMd()
                                        .format(_selectStartDate),
                                    widget: IconButton(
                                      onPressed: () {
                                        _getDateFromUser(isStartDate: true);
                                      },
                                      icon: const Icon(
                                          Icons.calendar_month_outlined),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  MyTextFormField(
                                    controller: ngayKTCtrl,
                                    text: "Ngày kết thúc",
                                    hintText:
                                        DateFormat.yMd().format(_selectEndDate),
                                    widget: IconButton(
                                      onPressed: () {
                                        _getDateFromUser(isStartDate: false);
                                      },
                                      icon: const Icon(
                                          Icons.calendar_month_outlined),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: MyTextFormField(
                                          controller: gioBDCtrl,
                                          text: "Giờ bắt đầu",
                                          hintText: _startTime,
                                          widget: IconButton(
                                            icon: const Icon(Icons.access_time),
                                            color: Colors.grey,
                                            onPressed: () {
                                              _getTimeFromUser(
                                                  isStartTime: true);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: MyTextFormField(
                                          controller: gioKTCtrl,
                                          text: "Giờ kết thúc",
                                          hintText: _endTime,
                                          widget: IconButton(
                                            icon: const Icon(Icons.access_time),
                                            color: Colors.grey,
                                            onPressed: () {
                                              _getTimeFromUser(
                                                  isStartTime: false);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  MyTextFormField(
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
                                      padding: const EdgeInsets.only(right: 8),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedTrangThai = newValue!;
                                          trangThaiCtrl.text = newValue;
                                        });
                                      },
                                      items: listTrangThai
                                          .map<DropdownMenuItem<String>>(
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
                                    controller: tienDoCtrl,
                                    text: "Tiến độ",
                                    hintText: "Tiến độ",
                                    inputType: TextInputType.number,
                                  ),
                                  MyTextFormField(
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
                                        width: 200,
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
                                              toast(
                                                  "Vui lòng nhập đủ thông tin công việc");
                                            } else {
                                              BlocProvider.of<UpdateTaskPageBloc>(
                                                      context)
                                                  .add(UpdateTask(
                                                      maCV:
                                                          int
                                                              .parse(
                                                                  widget
                                                                      .congViec
                                                                      .maCV
                                                                      .toString()),
                                                      tieuDe: tieuDeCtrl.text,
                                                      noiDung: noiDungCtrl.text,
                                                      ngayBD:
                                                          DateFormat(
                                                                  "yyyy-MM-dd")
                                                              .format(
                                                                  _selectStartDate),
                                                      ngayKT: DateFormat(
                                                              "yyyy-MM-dd")
                                                          .format(
                                                              _selectEndDate),
                                                      gioBD: gioBDCtrl.text,
                                                      gioKT: gioKTCtrl.text,
                                                      trangThai:
                                                          trangThaiCtrl.text,
                                                      tienDo: tienDoCtrl.text,
                                                      ghiChu: ghiChuCtrl.text));
                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.deepOrangeAccent),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            "Cập nhật công việc",
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
            );
          },
        ),
      ),
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();
    String _formatedTime = pickerTime.format(context);
    if (pickerTime == null) {
      print("Time canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
        gioBDCtrl.text = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
        gioKTCtrl.text = _formatedTime;
      });
    }
  }

  _getDateFromUser({required bool isStartDate}) async {
    DateTime? pickerDate = await _showDatePicker();
    print(pickerDate.toString());
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
                colorScheme:
                    const ColorScheme.light(primary: Colors.deepOrangeAccent),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
              colorScheme:
                  const ColorScheme.light(primary: Colors.deepOrangeAccent),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
  }
}
