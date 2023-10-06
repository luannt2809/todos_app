import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/bloc/task/delete_task/delete_task_bloc.dart';
import 'package:todos_app/bloc/task/list_task_assigned_page/list_task_assigned_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/task_details_page.dart';
import 'package:todos_app/screens/update_task_page.dart';
import 'package:todos_app/themes/styles.dart';

class ListTaskAssignedPage extends StatefulWidget {
  final NguoiDung nguoiDung;

  const ListTaskAssignedPage({super.key, required this.nguoiDung});

  @override
  State<ListTaskAssignedPage> createState() => _ListTaskAssignedPageState();
}

class _ListTaskAssignedPageState extends State<ListTaskAssignedPage> {
  final ListTaskAssignedPageBloc listTaskAssignedPageBloc =
      ListTaskAssignedPageBloc();

  @override
  void initState() {
    // TODO: implement initState
    listTaskAssignedPageBloc.add(GetListTaskAssigned());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text(
          "Danh sách công việc đã giao",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => listTaskAssignedPageBloc,
        child:
            BlocListener<ListTaskAssignedPageBloc, ListTaskAssignedPageState>(
          listener: (context, state) {
            if (state is ListTaskAssignedPageError) {
              customToast(
                  context: context,
                  title: "Lỗi",
                  message: state.error.toString(),
                  contentType: ContentType.failure);
            }
          },
          child:
              BlocBuilder<ListTaskAssignedPageBloc, ListTaskAssignedPageState>(
            builder: (context, state) {
              if (state is ListTaskAssignedPageLoading) {
                return circularProgressIndicator();
              } else if (state is ListTaskAssignedPageEmpty) {
                return const Center(
                  child: Text("Không có dữ liệu"),
                );
              } else if (state is ListTaskAssignedPageLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    CongViec congViec = state.listTaskAssigned[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailsPage(
                                hoTen: widget.nguoiDung.hoTen.toString(),
                                congViec: CongViec(
                                  maCV: int.parse(congViec.maCV.toString()),
                                  tieuDe: congViec.tieuDe,
                                  noiDung: congViec.noiDung,
                                  ngayBatDau: congViec.ngayBatDau,
                                  ngayKetThuc: congViec.ngayKetThuc,
                                  gioBatDau: congViec.gioBatDau,
                                  gioKetThuc: congViec.gioKetThuc,
                                  trangThai: congViec.trangThai,
                                  tienDo: congViec.tienDo,
                                  ghiChu: congViec.ghiChu,
                                  hoTenNguoiLam: congViec.hoTenNguoiLam,
                                  hoTenNguoiGiao: congViec.hoTenNguoiGiao
                                ),
                              ),
                            ),
                          ).then((value) async {
                            if (value != null && value[0] == 'Reload') {
                              getData();
                            }
                          });
                        },
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                onPressed: (BuildContext context) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateTaskPage(
                                        congViec: CongViec(
                                          maCV: int.parse(
                                              congViec.maCV.toString()),
                                          tieuDe: congViec.tieuDe,
                                          noiDung: congViec.noiDung,
                                          ngayBatDau: congViec.ngayBatDau,
                                          ngayKetThuc: congViec.ngayKetThuc,
                                          gioBatDau: congViec.gioBatDau,
                                          gioKetThuc: congViec.gioKetThuc,
                                          trangThai: congViec.trangThai,
                                          tienDo: congViec.tienDo,
                                          ghiChu: congViec.ghiChu,
                                          maNguoiLam: congViec.maNguoiLam,
                                        ),
                                      ),
                                    ),
                                  ).then((value) {
                                    if (value != null && value[0] == 'Reload') {
                                      getData();
                                    }
                                  });
                                },
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Cập nhật',
                              ),
                              SlidableAction(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                icon: Icons.delete_rounded,
                                label: 'Xóa',
                                onPressed: (BuildContext context) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        BlocProvider(
                                      create: (context) => DeleteTaskBloc(),
                                      child: BlocConsumer<DeleteTaskBloc,
                                          DeleteTaskState>(
                                        listener: (context, state) {
                                          if (state is DeleteTaskError) {
                                            customToast(
                                                context: context,
                                                title: "Lỗi",
                                                message: state.error.toString(),
                                                contentType:
                                                    ContentType.failure);
                                            Navigator.of(context).pop();
                                          } else if (state is DeletedTask) {
                                            customToast(
                                                context: context,
                                                title: "Thành công",
                                                message: state.msg,
                                                contentType:
                                                    ContentType.success);
                                            Navigator.of(context).pop();
                                            getData();
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is DeleteTaskInitial) {
                                            return AlertDialog(
                                              title: const Text("Xác nhận"),
                                              content: const Text(
                                                  "Bạn có xác nhận xoá công việc này không ?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                DeleteTaskBloc>(
                                                            context)
                                                        .add(DeleteTask(
                                                            int.parse(congViec
                                                                .maCV
                                                                .toString())));
                                                  },
                                                  child: const Text(
                                                    "Xác nhận",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "Huỷ",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: Styles.boxDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      congViec.tieuDe.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )),
                                    Text(
                                      congViec.trangThai.toString(),
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("${congViec.hoTenNguoiLam}"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        "${formatTime(congViec.gioBatDau.toString())} - ${formatTime(congViec.gioKetThuc.toString())}"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_outlined,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${formatDate(congViec.ngayBatDau.toString())} - ${formatDate(congViec.ngayKetThuc.toString())}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.listTaskAssigned.length,
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
    );
  }

  // format time
  String formatTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  // format date
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd/MM/y').format(parsedDate);
    return formattedDate;
  }

  getData() {
    listTaskAssignedPageBloc.add(GetListTaskAssigned());
  }
}