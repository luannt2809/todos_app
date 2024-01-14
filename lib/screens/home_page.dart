import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/bloc/home_page/home_page_bloc.dart';
import 'package:todos_app/bloc/task/add_task_page/add_task_page_bloc.dart';
import 'package:todos_app/bloc/task/delete_task/delete_task_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/add_task_page.dart';
import 'package:todos_app/screens/admin/admin_add_task/admin_add_task_page.dart';
import 'package:todos_app/screens/task_details_page.dart';
import 'package:todos_app/screens/update_task_page.dart';
import 'package:todos_app/themes/styles.dart';

class HomePage extends StatefulWidget {
  final NguoiDung nguoiDung;

  const HomePage({super.key, required this.nguoiDung});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectStartDate = DateTime.now();
  TextEditingController ngayBDCtrl = TextEditingController();
  final HomePageBloc homePageBloc = HomePageBloc();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    print(widget.nguoiDung.maPB);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
          create: (context) => homePageBloc,
          child: SafeArea(
            child: SizedBox(
              height: h,
              child: Column(
                children: <Widget>[
                  headerHomePage(),
                  Expanded(
                    child: BlocListener<HomePageBloc, HomePageState>(
                      listener: (context, state) {
                        if (state is HomePageError) {
                          customToast(
                              context: context,
                              title: "Lỗi",
                              message: state.error.toString(),
                              contentType: ContentType.failure);
                        }
                      },
                      child: BlocBuilder<HomePageBloc, HomePageState>(
                        builder: (context, state) {
                          if (state is HomePageLoading) {
                            return circularProgressIndicator();
                          } else if (state is GetListTaskEmpty) {
                            return const Center(
                              child: Text("Không có dữ liệu"),
                            );
                          } else if (state is HomePageLoaded) {
                            return ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                CongViec congViec = state.taskList[index];
                                return itemListCV(context, congViec);
                              },
                              itemCount: state.taskList.length,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget headerHomePage() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
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
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    TimeDisplayWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hôm nay",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.nguoiDung.maPB == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const AdminAddTaskPage();
                        }),
                      ).then((value) {
                        getData();
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AddTaskPageBloc(),
                            child: const AddTaskPage(),
                          ),
                        ),
                      ).then((value) {
                        // if (value != null && value[0] == 'Reload') {
                        /// to do something
                        getData();
                        // }
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
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
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFeeeeee),
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: DateFormat('dd/MM/yyyy').format(_selectStartDate),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // _getDateStartFromUser();
                    _getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_month_outlined),
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getData() async {
    // list = await ApiCongViec.getAllCongViecByMaND(
    //             DateFormat('yyyy-MM-dd').format(_selectStartDate))
    //         ?.whenComplete(() {}) ??
    //     []; sửa thành ->
    homePageBloc.add(GetTaskList(startDate: DateFormat('yyyy-MM-dd').format(_selectStartDate).toString()));
  }

  // List<CongViec> list = [];

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: _selectStartDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.deepOrangeAccent,
              colorScheme: const ColorScheme.light(primary: Colors.deepOrangeAccent),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    if (pickerDate != null) {
      setState(() {
        _selectStartDate = pickerDate;
        ngayBDCtrl.text = _selectStartDate.toString();
      });
      getData();
    } else {
      if (kDebugMode) {
        print("Có lỗi xảy ra");
      }
    }
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

  Widget itemListCV(BuildContext context, CongViec congViec) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsPage(nguoiDung: widget.nguoiDung, congViec: congViec),
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
                      builder: (context) => UpdateTaskPage(nguoiDung: widget.nguoiDung, congViec: congViec),
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
              Visibility(
                visible: congViec.maNguoiGiao == null && widget.nguoiDung.maPB != 2 || widget.nguoiDung.maPB == 2,
                child: SlidableAction(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_rounded,
                  label: 'Xóa',
                  onPressed: (BuildContext context) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => BlocProvider(
                        create: (context) => DeleteTaskBloc(),
                        child: BlocConsumer<DeleteTaskBloc, DeleteTaskState>(
                          listener: (context, state) {
                            if (state is DeleteTaskError) {
                              customToast(
                                  context: context,
                                  title: "Lỗi",
                                  message: state.error.toString(),
                                  contentType: ContentType.failure);
                              Navigator.of(context).pop();
                            } else if (state is DeletedTask) {
                              customToast(
                                  context: context,
                                  title: "Thành công",
                                  message: state.msg,
                                  contentType: ContentType.success);
                              Navigator.of(context).pop();
                              getData();
                            }
                          },
                          builder: (context, state) {
                            if (state is DeleteTaskInitial) {
                              return AlertDialog(
                                title: const Text("Xác nhận"),
                                content: const Text("Bạn có xác nhận xoá công việc này không ?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      BlocProvider.of<DeleteTaskBloc>(context)
                                          .add(DeleteTask(int.parse(congViec.maCV.toString())));
                                    },
                                    child: const Text(
                                      "Xác nhận",
                                      style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Huỷ",
                                      style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
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
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      congViec.trangThai.toString(),
                      style: TextStyle(
                          color: congViec.trangThai != "Quá hạn" ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500),
                    )
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
  }
}

class TimeDisplayWidget extends StatelessWidget {
  const TimeDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("vi_VN", null);

    String formattedDate = DateFormat('MMMM dd, y', 'vi').format(DateTime.now());

    return Text(
      formattedDate.toUpperCase(),
      style: Styles.textTimeDisplay,
    );
  }
}
