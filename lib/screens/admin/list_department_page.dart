import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_app/bloc/department/list_department_page/list_department_page_bloc.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/screens/admin/add_department_page.dart';
import 'package:todos_app/screens/admin/update_department_page.dart';
import 'package:todos_app/themes/styles.dart';

class ListDepartmentPage extends StatefulWidget {
  const ListDepartmentPage({super.key});

  @override
  State<ListDepartmentPage> createState() => _ListDepartmentPageState();
}

class _ListDepartmentPageState extends State<ListDepartmentPage> {
  late ListDepartmentPageBloc listDepartmentPageBloc;
  ScrollController _scrollController = ScrollController();
  bool fabVisible = true;

  @override
  void initState() {
    listDepartmentPageBloc = ListDepartmentPageBloc();
    listDepartmentPageBloc.add(GetListDepartment());
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        fabVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        fabVisible = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
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
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    PhongBan phongBan = state.listDepartment[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => UpdateDepartmentPage(
                                          phongBan: phongBan,
                                        ))).then((value) => getData());
                              },
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: "Cập nhật",
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: Styles.boxDecoration,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/team.png",
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(phongBan.tenPhongBan.toString())
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.listDepartment.length,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                );
              } else {
                return const Center(
                  child: Text("Không có dữ liệu"),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: fabVisible ? FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (_) => const AddDepartmentPage()))
              .then((value) {
            getData();
          });
        },
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 3,
        highlightElevation: 3,
        child: const Icon(
          Icons.add,
        ),
      ) : null,
    );
  }

  getData() {
    listDepartmentPageBloc.add(GetListDepartment());
  }
}
