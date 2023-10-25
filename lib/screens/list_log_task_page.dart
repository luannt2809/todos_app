import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todos_app/bloc/task/list_log_task_page/list_log_task_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/models/log_cong_viec.dart';
import 'package:todos_app/themes/styles.dart';

class ListLogTaskPage extends StatelessWidget {
  final CongViec congViec;

  const ListLogTaskPage({super.key, required this.congViec});

  @override
  Widget build(BuildContext context) {
    final ListLogTaskPageBloc listLogTaskPageBloc = ListLogTaskPageBloc();

    return BlocProvider(
      create: (_) => listLogTaskPageBloc..add(GetListLogTaskEvent(maCV: congViec.maCV)),
      child: BlocListener<ListLogTaskPageBloc, ListLogTaskPageState>(
        listener: (context, state) {
          if (state is ListLogTaskPageError) {
            customToast(
                context: context,
                title: "Lỗi",
                message: state.error.toString(),
                contentType: ContentType.failure);
          }
        },
        child: BlocBuilder<ListLogTaskPageBloc, ListLogTaskPageState>(
          builder: (context, state) {
            if (state is ListLogTaskPageLoading) {
              return circularProgressIndicator();
            } else if (state is GetListLogCongViecEmpty) {
              return const Center(
                child: Text("Không có dữ liệu"),
              );
            } else if (state is ListLogTaskPageLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  LogCongViec logCongViec = state.listLogCongViec[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
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
                                logCongViec.tieuDe.toString(),
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy - hh:mm a')
                                    .format(DateTime.parse(
                                        logCongViec.thoiGian.toString()))
                                    .toString(),
                                softWrap: true,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RowItem(
                              icon: Icons.person_outline_outlined,
                              text: logCongViec.hoTen.toString()),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                logCongViec.trangThai.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: logCongViec.trangThai != "Quá hạn"
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 15),
                              ),
                              Text(
                                "${logCongViec.tienDo}%",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Mô tả: ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: logCongViec.moTa.toString(),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: state.listLogCongViec.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const RowItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(text),
      ],
    );
  }
}
