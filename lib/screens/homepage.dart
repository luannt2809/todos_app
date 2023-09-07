import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/models/CongViec.dart';
import 'package:todos_app/screens/addtaskpage.dart';
import 'package:todos_app/screens/taskdetailspage.dart';
import 'package:todos_app/screens/updatetaskpage.dart';
import 'package:todos_app/services/api/api_config.dart';
import 'package:todos_app/services/api/api_congviec.dart';
import 'package:todos_app/themes/styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectStartDate = DateTime.now();
  TextEditingController ngayBDCtrl = TextEditingController();

  Future<void> deleteTask(int maCV) async {
    String msg = "";

    try {
      Response response = await ApiConfig.dio
          .delete("${ApiConfig.BASE_URL}/congviec/delete/${maCV}");

      if (response.statusCode == 200) {
        msg = response.data.toString();
        setState(() {});
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        msg = "${e.response?.data}";
      }
    }

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.pop(context, ['Reload']);
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: h,
          child: Column(
            children: <Widget>[
              Container(
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
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
                              ).then((value) {
                                // if (value != null && value[0] == 'Reload') {
                                /// to do something
                                getData();
                                // }
                              });
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
                                hintText: DateFormat('dd-MM-yyyy')
                                    .format(_selectStartDate),
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
              ),
              Expanded(
                child: FutureBuilder<List<CongViec>>(
                  // initialData: list,
                  future: ApiCongViec.getAllCongViecByMaND(
                      DateFormat('yyyy-MM-dd').format(_selectStartDate)),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CongViec>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return itemListCV(
                              context,
                              snapshot.data![index].tieuDe.toString(),
                              snapshot.data![index].noiDung.toString(),
                              snapshot.data![index].ngayBatDau.toString(),
                              snapshot.data![index].ngayKetThuc.toString(),
                              snapshot.data![index].gioBatDau.toString(),
                              snapshot.data![index].gioKetThuc.toString(),
                              snapshot.data![index].trangThai.toString(),
                              snapshot.data![index].tienDo!.toDouble(),
                              snapshot.data![index].ghiChu.toString(),
                              snapshot.data![index].maNguoiLam!.toInt(),
                              snapshot.data![index].maCV.toString());
                        },
                        itemCount: snapshot.data!.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                      );
                    } else {
                      // return const Center(
                      //   child: CircularProgressIndicator(
                      //     color: Colors.deepOrangeAccent,
                      //   ),
                      // );
                      return const Center(
                        child: Text("Chưa có công việc"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // List<CongViec> list = [];

  getData() async {
    // list = await ApiCongViec.getAllCongViecByMaND(
    //             DateFormat('yyyy-MM-dd').format(_selectStartDate))
    //         ?.whenComplete(() {}) ??
    //     []; sửa thành ->
    await ApiCongViec.getAllCongViecByMaND(
        DateFormat('yyyy-MM-dd').format(_selectStartDate));
    setState(() {});
  }

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

  Widget itemListCV(
      BuildContext context,
      String tieuDe,
      String noiDung,
      String ngayBD,
      String ngayKT,
      String gioBD,
      String gioKT,
      String trangThai,
      double tienDo,
      String ghiChu,
      int maNguoiLam,
      String id) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsPage(
                congViec: CongViec(
                  maCV: int.parse(id),
                  tieuDe: tieuDe,
                  noiDung: noiDung,
                  ngayBatDau: ngayBD,
                  ngayKetThuc: ngayKT,
                  gioBatDau: gioBD,
                  gioKetThuc: gioKT,
                  trangThai: trangThai,
                  tienDo: tienDo,
                  ghiChu: ghiChu,
                  maNguoiLam: maNguoiLam,
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
                          maCV: int.parse(id),
                          tieuDe: tieuDe,
                          noiDung: noiDung,
                          ngayBatDau: ngayBD,
                          ngayKetThuc: ngayKT,
                          gioBatDau: gioBD,
                          gioKetThuc: gioKT,
                          trangThai: trangThai,
                          tienDo: tienDo,
                          ghiChu: ghiChu,
                          maNguoiLam: maNguoiLam,
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
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Xác nhận"),
                      content: const Text(
                          "Bạn có xác nhận xoá công việc này không ?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            await deleteTask(int.parse(id));
                          },
                          child: const Text(
                            "Xác nhận",
                            style: TextStyle(
                                color: Colors.deepOrangeAccent, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, ['Reload']);
                          },
                          child: const Text(
                            "Huỷ",
                            style: TextStyle(
                                color: Colors.deepOrangeAccent, fontSize: 16),
                          ),
                        ),
                      ],
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
                Text(tieuDe),
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
                    Text("${formatTime(gioBD)} - ${formatTime(gioKT)}"),
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
                      "${formatDate(ngayBD)} - ${formatDate(ngayKT)}",
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
