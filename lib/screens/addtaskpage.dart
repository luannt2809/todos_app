import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/services/api/apiConfig.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectStartDate = DateTime.now();
  DateTime _selectEndDate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _selectedTrangThai = 'Chờ nhận';

  Dio dio = Dio();
  TextEditingController tieuDeCtrl = TextEditingController();
  TextEditingController noiDungCtrl = TextEditingController();
  TextEditingController ngayBDCtrl = TextEditingController();
  TextEditingController ngayKTCtrl = TextEditingController();
  TextEditingController gioBDCtrl = TextEditingController();
  TextEditingController gioKTCtrl = TextEditingController();
  TextEditingController trangThaiCtrl = TextEditingController();
  TextEditingController tienDoCtrl = TextEditingController();
  TextEditingController ghiChuCtrl = TextEditingController();

  Future<void> addTask() async {
    String tieuDe = tieuDeCtrl.text;
    String noiDung = noiDungCtrl.text;
    String ngayBD = DateFormat("yyyy-MM-dd").format(_selectStartDate);
    String ngayKT = DateFormat("yyyy-MM-dd").format(_selectEndDate);
    // String gioBD = DateFormat('hh:mm').format(DateTime.parse(gioBDCtrl.text)).toString();
    // String gioKT = DateFormat('hh:mm').format(DateTime.parse(gioKTCtrl.text)).toString();
    String gioBD = gioBDCtrl.text;
    String gioKT = gioKTCtrl.text;
    String trangThai = trangThaiCtrl.text;
    String tienDo = tienDoCtrl.text;
    String? ghiChu = ghiChuCtrl.text.isEmpty ? null : ghiChuCtrl.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maNguoiLam = prefs.getInt("maND");

    String msg = "";

    resetData() {
      tieuDeCtrl.text = "";
      noiDungCtrl.text = "";
      ngayBDCtrl.text = "";
      ngayKTCtrl.text = "";
      gioBDCtrl.text = "";
      gioKTCtrl.text = "";
      trangThaiCtrl.text = "";
      tienDoCtrl.text = "";
      ghiChuCtrl.text = "";
    }

    if(tieuDe.isEmpty || noiDung.isEmpty || ngayBD.isEmpty || ngayKT.isEmpty || gioBD.isEmpty || gioKT.isEmpty || trangThai.isEmpty || tienDo.isEmpty){
      msg = "Vui lòng nhập đủ thông tin công việc";
      resetData();
    } else {
      try {
        Response response =
        await dio.post("${ApiConfig.BASE_URL}/congviec/insert", data: {
          'TieuDe': tieuDe,
          'NoiDung': noiDung,
          'GioBatDau': gioBD,
          'GioKetThuc': gioKT,
          'NgayBatDau': ngayBD,
          'NgayKetThuc': ngayKT,
          'TrangThai': trangThai,
          'TienDo': tienDo,
          'GhiChu': ghiChu,
          'MaNguoiLam': maNguoiLam
        });

        if (response.statusCode == 200) {
          msg = response.data.toString();
          Navigator.pop(context);
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
    List<String> listTrangThai = [
      'Chờ nhận',
      'Đã nhận',
      'Đang thực hiện',
      'Hoàn thành'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.orangeAccent,
            size: 20,
          ),
        ),
        title: const Text(
          "Thêm công việc",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
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
                        hintText:
                            DateFormat('dd-MM-yyyy').format(_selectStartDate),
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
                        controller: ngayKTCtrl,
                        text: "Ngày kết thúc",
                        hintText:
                            DateFormat('dd-MM-yyyy').format(_selectEndDate),
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
                            width: 150,
                            child: ElevatedButton(
                              onPressed: addTask,
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
      ),
    );
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();
    String _formatedTime = pickerTime.format(context);
    print(_formatedTime);
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
      initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0])),
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
