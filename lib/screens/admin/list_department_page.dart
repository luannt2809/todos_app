import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/list_department_page/list_department_page_bloc.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/themes/styles.dart';

class ListDepartmentPage extends StatefulWidget {
  const ListDepartmentPage({super.key});

  @override
  State<ListDepartmentPage> createState() => _ListDepartmentPageState();
}

class _ListDepartmentPageState extends State<ListDepartmentPage> {
  final ListDepartmentPageBloc listDepartmentPageBloc =
      ListDepartmentPageBloc();

  @override
  void initState() {
    // TODO: implement initState
    listDepartmentPageBloc.add(GetListDepartment());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text(
          "Danh sách phòng ban",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => listDepartmentPageBloc,
        child: BlocListener<ListDepartmentPageBloc, ListDepartmentPageState>(
          listener: (context, state) {
            if (state is ListDepartmentPageError) {
              toast(state.error.toString());
            }
          },
          child: BlocBuilder<ListDepartmentPageBloc, ListDepartmentPageState>(
            builder: (context, state) {
              if (state is ListDepartmentPageLoading) {
                return circularProgressIndicator();
              } else if (state is ListDepartmentPageLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    PhongBan phongBan = state.listDepartment[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: Styles.boxDecoration,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${index + 1}. ${phongBan.tenPhongBan}")
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.listDepartment.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                );
              } else {
                return Center(
                  child: Text("Không có dữ liệu"),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 3,
        highlightElevation: 3,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
