import 'package:flutter/material.dart';
import 'package:todos_app/screens/admin/admin_add_task/tab_giao_viec.dart';
import 'package:todos_app/screens/admin/admin_add_task/tab_tao_viec.dart';

class AdminAddTaskPage extends StatefulWidget {
  const AdminAddTaskPage({super.key});

  @override
  State<AdminAddTaskPage> createState() => _AdminAddTaskPageState();
}

class _AdminAddTaskPageState extends State<AdminAddTaskPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.orangeAccent,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context, ["Reload"]);
            },
          ),
          title: const Text(
            "Thêm công việc",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: const TabBar(
            unselectedLabelColor: Colors.black26,
            labelColor: Colors.deepOrange,
            indicatorColor: Colors.white,
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 15),
            tabs: [
              Tab(text: "Giao công việc"),
              Tab(
                text: "Tạo công việc",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TabGiaoViec(),
            TabTaoViec(),
          ],
        ),
      ),
    );
  }
}
