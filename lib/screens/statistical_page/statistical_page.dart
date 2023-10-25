import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/statistical_page/list_statistical_page.dart';

class StatisticalPage extends StatelessWidget {
  final NguoiDung nguoiDung;

  const StatisticalPage({super.key, required this.nguoiDung});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
            "Thống kê công việc",
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
            ListStatisticalPage(
              trangThai: "Chờ nhận",
              nguoiDung: nguoiDung,
            ),
            ListStatisticalPage(
              trangThai: "Đã nhận",
              nguoiDung: nguoiDung,
            ),
            ListStatisticalPage(
              trangThai: "Đang thực hiện",
              nguoiDung: nguoiDung,
            ),
            ListStatisticalPage(
              trangThai: "Hoàn thành",
              nguoiDung: nguoiDung,
            ),
            ListStatisticalPage(
              trangThai: "Quá hạn",
              nguoiDung: nguoiDung,
            ),
          ],
        ),
      ),
    );
  }
}
