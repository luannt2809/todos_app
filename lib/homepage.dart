import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/addtaskpage.dart';
import 'package:todos_app/taskdetailspage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    initializeDateFormatting("vi_VN", null);

    List<Widget> listDemoCV = [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailsPage(),
            ),
          );
        },
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                onPressed: (BuildContext context) {  },
                backgroundColor: const Color(0xFF7BC043),
                foregroundColor: Colors.white,
                icon: Icons.archive,
                label: 'Archive',
              ),
              SlidableAction(
                backgroundColor: const Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.save,
                label: 'Save', onPressed: (BuildContext context) {  },
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Column(
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
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailsPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
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
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailsPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
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
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailsPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
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
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailsPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
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
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskDetailsPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Column(
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
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: h,
          // padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: w,
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: TimeDisplayWidget(),
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddTaskPage(),
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
                            "Thêm +",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: DatePicker(
                  DateTime.now(),
                  width: 80,
                  height: 100,
                  initialSelectedDate: DateTime.now(),
                  selectedTextColor: Colors.white,
                  selectionColor: Colors.deepOrangeAccent,
                  dateTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
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
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}
