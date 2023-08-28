import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/addtaskpage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    initializeDateFormatting("vi_VN", null);

    List<Widget> listDemoCV = [
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Công việc 1"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("9:30 AM - 3:30 PM"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("28-08-2023 - 31-08-2023"),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Công việc 2"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("9:30 AM - 3:30 PM"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("28-08-2023 - 31-08-2023"),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Công việc 3"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("9:30 AM - 3:30 PM"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("28-08-2023 - 31-08-2023"),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Công việc 4"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("9:30 AM - 3:30 PM"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("28-08-2023 - 31-08-2023"),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Công việc 5"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("9:30 AM - 3:30 PM"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("28-08-2023 - 31-08-2023"),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Công việc 6"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("9:30 AM - 3:30 PM"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("28-08-2023 - 31-08-2023"),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: h,
          // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: w,
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TimeDisplayWidget(),
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTaskPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Thêm +",
                            style: TextStyle(fontSize: 14),
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
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                child: DatePicker(
                  DateTime.now(),
                  width: 80,
                  height: 100,
                  initialSelectedDate: DateTime.now(),
                  selectedTextColor: Colors.white,
                  selectionColor: Colors.deepOrangeAccent,
                  dateTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  children: listDemoCV,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeDisplayWidget extends StatelessWidget {
  const TimeDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("vi_VN", null);

    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

    return Text(
      formattedDate.toUpperCase(),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}
