import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/screens/addtaskpage.dart';
import 'package:todos_app/screens/taskdetailspage.dart';
import 'package:todos_app/screens/updatetaskpage.dart';
import 'package:todos_app/themes/styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    initializeDateFormatting("vi_VN", null);

    Future<List<dynamic>> fetchApi() async {
      Dio dio = Dio();

      var response =
          await dio.get("http://192.168.1.44:3000/api/congviec/list");
      print(response.data.toString());

      return response.data;
    }

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
                  ],
                ),
              ),
              Expanded(
                  child: FutureBuilder<List<dynamic>>(
                future: fetchApi(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
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
                          String formattedDate = date.split("T")[0];
                          return formattedDate;
                        }

                        return itemLisCV(
                            context,
                            snapshot.data![index]['TieuDe'],
                            "${formatTime(snapshot.data![index]['GioBatDau']
                                    .toString())} - ${formatTime(snapshot.data![index]['GioKetThuc']
                                    .toString())}",
                            // ngaybatdau - ngayketthuc
                            "${formatDate(snapshot.data![index]['NgayBatDau']
                                    .toString())} - ${formatDate(snapshot.data![index]['NgayBatDau']
                                    .toString())}", snapshot.data![index]['MaCV']);
                      },
                      itemCount: snapshot.data!.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.deepOrangeAccent,),
                    );
                  }
                },
              )),
            ],
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

    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

    return Text(
      formattedDate.toUpperCase(),
      style: Styles.textTimeDisplay,
    );
  }
}

Widget itemLisCV(BuildContext context, String tieuDe, String gio, String ngay, int id) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsPage(maCV: id),
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
