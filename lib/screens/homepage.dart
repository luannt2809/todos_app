import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/components/my_text_form_field.dart';
import 'package:todos_app/models/CongViec.dart';
import 'package:todos_app/screens/addtaskpage.dart';
import 'package:todos_app/screens/taskdetailspage.dart';
import 'package:todos_app/screens/updatetaskpage.dart';
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
                              );
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
                    SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.only(left: 14),
                      decoration: BoxDecoration(
                        color: Color(0xFFeeeeee),
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
                                hintText: DateFormat('dd-MM-yyyy').format(_selectStartDate),
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
                  future: ApiCongViec.getAllCongViecByMaND(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CongViec>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          // format time
                          String formatTime(String time) {
                            DateTime dateTime = DateTime.parse(time);
                            String formattedTime =
                                DateFormat.jm().format(dateTime);
                            return formattedTime;
                          }

                          // format date
                          String formatDate(String date) {
                            DateTime parsedDate = DateTime.parse(date);
                            String formattedDate =
                                DateFormat('dd/MM/y').format(parsedDate);
                            return formattedDate;
                          }

                          return itemListCV(
                              context,
                              snapshot.data![index].tieuDe.toString(),
                              snapshot.data![index].noiDung.toString(),
                              "${formatTime(snapshot.data![index].gioBatDau.toString())} - ${formatTime(snapshot.data![index].gioKetThuc.toString())}",
                              // ngaybatdau - ngayketthuc
                              "${formatDate(snapshot.data![index].ngayBatDau.toString())} - ${formatDate(snapshot.data![index].ngayKetThuc.toString())}",
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
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

Widget itemListCV(
    BuildContext context,
    String tieuDe,
    String noiDung,
    String gio,
    String ngay,
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
                trangThai: trangThai,
                tienDo: tienDo,
                ghiChu: ghiChu,
                maNguoiLam: maNguoiLam,
              ),
              gio: gio,
              ngay: ngay,
            ),
          ),
        );
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
                    builder: (context) => const UpdateTaskPage(),
                  ),
                );
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
              onPressed: (BuildContext context) {},
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
                  Text(gio),
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
                  Text(ngay),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
