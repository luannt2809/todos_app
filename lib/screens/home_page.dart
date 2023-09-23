import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/bloc/add_task_page/add_task_page_bloc.dart';
import 'package:todos_app/bloc/delete_task/delete_task_bloc.dart';
import 'package:todos_app/bloc/home_page/home_page_bloc.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/add_task_page.dart';
import 'package:todos_app/screens/admin/admin_add_task_page.dart';
import 'package:todos_app/screens/task_details_page.dart';
import 'package:todos_app/screens/update_task_page.dart';
import 'package:todos_app/themes/styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => homePageBloc,
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageError) {
              return Center(
                child: Text(state.error!),
              );
            } else if (state is HomePageLoading) {
              return circularProgressIndicator();
            } else if (state is GetListTaskEmpty) {
              return SafeArea(
                child: SizedBox(
                  height: h,
                  child: Column(
                    children: <Widget>[
                      headerHomePage(),
                      const Expanded(
                        child: Center(
                          child: Text("Không có dữ liệu"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is HomePageLoaded) {
              return SafeArea(
                child: SizedBox(
                  height: h,
                  child: Column(
                    children: <Widget>[
                      headerHomePage(),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            CongViec congViec = state.taskList[index];
                            return itemListCV(context, congViec);
                          },
                          itemCount: state.taskList.length,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeDisplayWidget(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hôm nay",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.nguoiDung.maVt == 1 ||
                        widget.nguoiDung.maVt == 2) {
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
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrangeAccent),
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
                      hintText:
                          DateFormat('dd/MM/yyyy').format(_selectStartDate),
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
    homePageBloc.add(GetTaskList(
        startDate:
            DateFormat('yyyy-MM-dd').format(_selectStartDate).toString()));
  }

  // List<CongViec> list = [];

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: _selectStartDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.deepOrangeAccent,
              colorScheme:
                  const ColorScheme.light(primary: Colors.deepOrangeAccent),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!);
      },
    );
    if (_pickerDate != null) {
      setState(() {
        _selectStartDate = _pickerDate;
        ngayBDCtrl.text = _selectStartDate.toString();
      });
      getData();
    } else {
      print("Có lỗi xảy ra");
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
              builder: (context) => TaskDetailsPage(
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
                  maNguoiLam: congViec.maNguoiLam,
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
                    builder: (BuildContext context) => BlocProvider(
                      create: (context) => DeleteTaskBloc(),
                      child: BlocConsumer<DeleteTaskBloc, DeleteTaskState>(
                        listener: (context, state) {
                          if (state is DeleteTaskError) {
                            toast("Error: ${state.error}");
                            Navigator.of(context).pop();
                          } else if (state is DeletedTask) {
                            toast(state.msg);
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
                                    BlocProvider.of<DeleteTaskBloc>(context)
                                        .add(DeleteTask(int.parse(
                                            congViec.maCV.toString())));
                                  },
                                  child: const Text(
                                    "Xác nhận",
                                    style: TextStyle(
                                        color: Colors.deepOrangeAccent,
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
                                        color: Colors.deepOrangeAccent,
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
                Text(congViec.tieuDe.toString()),
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

    String formattedDate =
        DateFormat('MMMM dd, y', 'vi').format(DateTime.now());

    return Text(
      formattedDate.toUpperCase(),
      style: Styles.textTimeDisplay,
    );
  }
}
