import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/components/my_text_form_field.dart';

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
                      const MyTextFormField(
                          text: "Tiêu đề", hintText: "Tiêu đề"),
                      const MyTextFormField(
                          text: "Nội dung", hintText: "Nội dung"),
                      MyTextFormField(
                        text: "Ngày bắt đầu",
                        hintText: DateFormat.yMd().format(_selectStartDate),
                        widget: IconButton(
                          onPressed: () {
                            _getDateStartFromUser();
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                          color: Colors.grey,
                        ),
                      ),
                      MyTextFormField(
                        text: "Ngày kết thúc",
                        hintText: DateFormat.yMd().format(_selectEndDate),
                        widget: IconButton(
                          onPressed: () {
                            _getDateEndFromUser();
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                          color: Colors.grey,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MyTextFormField(
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
                      const MyTextFormField(
                        text: "Tiến độ",
                        hintText: "Tiến độ",
                        inputType: TextInputType.number,
                      ),
                      const MyTextFormField(
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
                              onPressed: () {},
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

  _getDateStartFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
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
      },
    );
    if (_pickerDate != null) {
      setState(() {
        _selectStartDate = _pickerDate;
      });
    } else {
      print("Có lỗi xảy ra");
    }
  }

  _getDateEndFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
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
      },
    );
    if (_pickerDate != null) {
      setState(() {
        _selectEndDate = _pickerDate;
      });
    } else {
      print("Có lỗi xảy ra");
    }
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
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
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


