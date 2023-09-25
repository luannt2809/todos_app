import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_app/bloc/department/add_department/add_department_bloc.dart';
import 'package:todos_app/bloc/department/list_department_page/list_department_page_bloc.dart';
import 'package:todos_app/bloc/department/update_department/update_department_bloc.dart';
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
  late ListDepartmentPageBloc listDepartmentPageBloc;
  final TextEditingController tenPBCtrl = TextEditingController();
  bool fabVisible = false;

  @override
  void initState() {
    listDepartmentPageBloc = ListDepartmentPageBloc();
    listDepartmentPageBloc.add(GetListDepartment());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tenPBCtrl.dispose();
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
                return NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    if (notification.direction == ScrollDirection.forward) {
                      if (!fabVisible) {
                        setState(() {
                          fabVisible = true;
                        });
                      }
                    } else if (notification.direction ==
                        ScrollDirection.reverse) {
                      if (fabVisible) {
                        setState(() {
                          fabVisible = false;
                        });
                      }
                    }
                    return true;
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      PhongBan phongBan = state.listDepartment[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        tenPBCtrl.text = phongBan.tenPhongBan;
                                        return BlocProvider(
                                          create: (context) =>
                                              UpdateDepartmentBloc(),
                                          child: BlocListener<
                                              UpdateDepartmentBloc,
                                              UpdateDepartmentState>(
                                            listener: (context, state) {
                                              // TODO: implement listener
                                              if(state is UpdateDepartmentError){
                                                toast(state.error.toString());
                                                Navigator.of(context).pop();
                                              } else if (state is UpdatedDepartment){
                                                toast(state.msg);
                                                Navigator.of(context).pop();
                                                getData();
                                              }
                                            },
                                            child: BlocBuilder<
                                                UpdateDepartmentBloc,
                                                UpdateDepartmentState>(
                                              builder: (context, state) {
                                                if(state is UpdatingDepartment){
                                                  return circularProgressIndicator();
                                                } else {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Cập nhật phòng ban"),
                                                    content: TextField(
                                                      controller: tenPBCtrl,
                                                      decoration:
                                                      const InputDecoration(
                                                          border:
                                                          OutlineInputBorder(),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .orange,
                                                                width: 2.0),
                                                          ),
                                                          hintText:
                                                          "Tên phòng ban"),
                                                      cursorColor:
                                                      Colors.deepOrangeAccent,
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors
                                                                .deepOrangeAccent),
                                                        child: const Text("Huỷ"),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                              UpdateDepartmentBloc>(
                                                              context)
                                                              .add(UpdateDepartment(
                                                              tenPB: tenPBCtrl
                                                                  .text,
                                                              maPB: phongBan
                                                                  .maPb));
                                                        },
                                                        child: const Text("Lưu"),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      )
                                                    ],
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        );
                                      });
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
                                Text(phongBan.tenPhongBan)
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
                  ),
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
      floatingActionButton: Visibility(
        visible: fabVisible,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BlocProvider(
                  create: (context) => AddDepartmentBloc(),
                  child: BlocListener<AddDepartmentBloc, AddDepartmentState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is AddDepartmentError) {
                        toast(state.error.toString());
                        Navigator.of(context).pop();
                      } else if (state is AddDepartmentLoaded) {
                        toast(state.msg);
                        Navigator.of(context).pop();
                        getData();
                      }
                    },
                    child: BlocBuilder<AddDepartmentBloc, AddDepartmentState>(
                      builder: (context, state) {
                        if (state is AddDepartmentLoading) {
                          return circularProgressIndicator();
                        } else {
                          return AlertDialog(
                            title: const Text("Thêm phòng ban"),
                            content: TextField(
                              controller: tenPBCtrl,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2.0),
                                  ),
                                  hintText: "Tên phòng ban"),
                              cursorColor: Colors.deepOrangeAccent,
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepOrangeAccent),
                                child: const Text("Huỷ"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<AddDepartmentBloc>(context)
                                      .add(AddDepartment(tenPBCtrl.text));
                                },
                                child: const Text("Lưu"),
                              ),
                              const SizedBox(
                                width: 8,
                              )
                            ],
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 3,
          highlightElevation: 3,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  getData() {
    listDepartmentPageBloc.add(GetListDepartment());
  }
}
