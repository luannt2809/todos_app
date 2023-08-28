import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    String _selectedTrangThai = 'Chờ nhận';
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
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.orangeAccent,
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Thêm công việc",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Tiêu đề",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.only(left: 14),
                                height: 52,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: "Tiêu đề",
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Nội dung",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.only(left: 14),
                                height: 52,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: "Nội dung",
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Ngày bắt đầu",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.only(left: 14),
                                height: 52,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: DateFormat.yMd()
                                              .format(DateTime.now()),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon:
                                            Icon(Icons.calendar_month_outlined),
                                        color: Colors.grey,
                                        onPressed: () async {
                                          DateTime? _pickerDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2025),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    primaryColor:
                                                        Colors.deepOrangeAccent,
                                                    colorScheme: ColorScheme.light(
                                                        primary: Colors
                                                            .deepOrangeAccent),
                                                    buttonTheme:
                                                        ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                  ),
                                                  child: child!);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Ngày kết thúc",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.only(left: 14),
                                height: 52,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: DateFormat.yMd()
                                              .format(DateTime.now()),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon:
                                            Icon(Icons.calendar_month_outlined),
                                        color: Colors.grey,
                                        onPressed: () async {
                                          DateTime? _pickerDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2020),
                                            lastDate: DateTime(2025),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                  data: ThemeData.light()
                                                      .copyWith(
                                                    primaryColor:
                                                        Colors.deepOrangeAccent,
                                                    colorScheme: ColorScheme.light(
                                                        primary: Colors
                                                            .deepOrangeAccent),
                                                    buttonTheme:
                                                        ButtonThemeData(
                                                            textTheme:
                                                                ButtonTextTheme
                                                                    .primary),
                                                  ),
                                                  child: child!);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Giờ bắt đầu",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      padding: EdgeInsets.only(left: 14),
                                      height: 52,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              autofocus: false,
                                              cursorColor: Colors.grey,
                                              decoration: InputDecoration(
                                                hintText: DateFormat("hh:mm a")
                                                    .format(DateTime.now())
                                                    .toString(),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.access_time,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                var _pickedTime =
                                                showTimePicker(
                                                  initialEntryMode:
                                                  TimePickerEntryMode.dial,
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour: DateTime.now().hour,
                                                      minute: DateTime.now()
                                                          .minute),
                                                  builder:
                                                      (BuildContext context,
                                                      Widget? child) {
                                                    return Theme(
                                                        data: ThemeData.light()
                                                            .copyWith(
                                                          primaryColor: Colors
                                                              .deepOrangeAccent,
                                                          colorScheme:
                                                          ColorScheme.light(
                                                              primary: Colors
                                                                  .deepOrangeAccent),
                                                          buttonTheme: ButtonThemeData(
                                                              textTheme:
                                                              ButtonTextTheme
                                                                  .primary),
                                                        ),
                                                        child: child!);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Giờ kết thúc",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      padding: EdgeInsets.only(left: 14),
                                      height: 52,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: TextFormField(
                                              autofocus: false,
                                              cursorColor: Colors.grey,
                                              decoration: InputDecoration(
                                                hintText: DateFormat("hh:mm a")
                                                    .format(DateTime.now())
                                                    .toString(),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.access_time,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                var _pickedTime =
                                                showTimePicker(
                                                  initialEntryMode:
                                                  TimePickerEntryMode.dial,
                                                  context: context,
                                                  initialTime: TimeOfDay(
                                                      hour: DateTime.now().hour,
                                                      minute: DateTime.now()
                                                          .minute),
                                                  builder:
                                                      (BuildContext context,
                                                      Widget? child) {
                                                    return Theme(
                                                        data: ThemeData.light()
                                                            .copyWith(
                                                          primaryColor: Colors
                                                              .deepOrangeAccent,
                                                          colorScheme:
                                                          ColorScheme.light(
                                                              primary: Colors
                                                                  .deepOrangeAccent),
                                                          buttonTheme: ButtonThemeData(
                                                              textTheme:
                                                              ButtonTextTheme
                                                                  .primary),
                                                        ),
                                                        child: child!);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Trạng thái",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.only(left: 14, right: 8),
                                height: 52,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: _selectedTrangThai,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DropdownButton(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey,
                                        ),
                                        iconSize: 30,
                                        elevation: 4,
                                        underline: Container(
                                          height: 0,
                                        ),
                                        items: listTrangThai
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value.toString(),
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (String? value) {
                                          print(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Tiến độ",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.only(left: 14),
                                height: 52,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        cursorColor: Colors.grey,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintText: "Tiến độ",
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Ghi chú",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.all(14),
                                // height: 52,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: false,
                                        cursorColor: Colors.grey,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          hintText: "Ghi chú",
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Tạo công việc",
                                  style: TextStyle(fontSize: 16),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.deepOrangeAccent),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
