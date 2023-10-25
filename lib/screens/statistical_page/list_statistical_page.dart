import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/bloc/task/list_statistical_page/list_statistical_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/task_details_page.dart';
import 'package:todos_app/themes/styles.dart';

class ListStatisticalPage extends StatelessWidget {
  final String trangThai;
  final NguoiDung nguoiDung;

  const ListStatisticalPage(
      {super.key, required this.trangThai, required this.nguoiDung});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListStatisticalPageBloc()
        ..add(GetListStatisticalTaskEvent(trangThai: trangThai)),
      child: BlocListener<ListStatisticalPageBloc, ListStatisticalPageState>(
        listener: (context, state) {
          if (state is ListStatisticalPageError) {
            customToast(
                context: context,
                title: "Lỗi",
                message: state.error.toString(),
                contentType: ContentType.failure);
          }
        },
        child: BlocBuilder<ListStatisticalPageBloc, ListStatisticalPageState>(
          builder: (context, state) {
            if (state is ListStatisticalPageLoading) {
              return circularProgressIndicator();
            } else if (state is ListStatisticalPageLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  CongViec congViec = state.listTask[index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailsPage(
                                nguoiDung: nguoiDung, congViec: congViec),
                          ),
                        ).then((value) async {
                          if (value != null && value[0] == 'Reload') {
                            BlocProvider.of<ListStatisticalPageBloc>(context)
                                .add(GetListStatisticalTaskEvent(
                                    trangThai: trangThai));
                          }
                        });
                      },
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  congViec.trangThai.toString(),
                                  style: TextStyle(
                                      color: congViec.trangThai != "Quá hạn"
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
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
                  );
                },
                itemCount: state.listTask.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              );
            } else if (state is ListStatisticalEmpty) {
              return const Center(
                child: Text("Không có dữ liệu"),
              );
            } else {
              return Container();
            }
          },
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
}
