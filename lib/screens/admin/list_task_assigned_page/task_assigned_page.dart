import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/admin/list_task_assigned_page/list_task_assigned_page.dart';

class TaskAssignedPage extends StatelessWidget {
  final NguoiDung nguoiDung;
  
  const TaskAssignedPage({super.key, required this.nguoiDung});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          title: const Text(
            "Danh sách các công việc đã giao",
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
              Tab(
                text: "Chờ nhận",
              ),
              Tab(
                text: "Đã nhận",
              ),
              Tab(
                text: "Đang thực hiện",
              ),
              Tab(
                text: "Hoàn thành",
              ),
              Tab(
                text: "Quá hạn",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListTaskAssignedPage(
              trangThai: "Chờ nhận",
              nguoiDung: nguoiDung,
            ),
            ListTaskAssignedPage(
              trangThai: "Đã nhận",
              nguoiDung: nguoiDung,
            ),
            ListTaskAssignedPage(
              trangThai: "Đang thực hiện",
              nguoiDung: nguoiDung,
            ),
            ListTaskAssignedPage(
              trangThai: "Hoàn thành",
              nguoiDung: nguoiDung,
            ),
            ListTaskAssignedPage(
              trangThai: "Quá hạn",
              nguoiDung: nguoiDung,
            ),
          ],
        ),
      ),
    );
  }
}
