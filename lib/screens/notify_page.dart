import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/notify_page/notify_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/models/thong_bao.dart';
import 'package:todos_app/themes/styles.dart';

class NotifyPage extends StatelessWidget {
  const NotifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotifyPageBloc notifyPageBloc = NotifyPageBloc();

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: const Text(
          "Thông báo",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => notifyPageBloc..add(GetListNotifyEvent()),
        child: BlocListener<NotifyPageBloc, NotifyPageState>(
          listener: (context, state) {
            if (state is NotifyPageError) {
              customToast(
                  context: context,
                  title: "Lỗi",
                  message: state.error.toString(),
                  contentType: ContentType.failure);
            }
          },
          child: BlocBuilder<NotifyPageBloc, NotifyPageState>(
            builder: (context, state) {
              if (state is NotifyPageLoading) {
                return circularProgressIndicator();
              } else if (state is GetListNotifyEmpty) {
                return const Center(
                  child: Text("Không có thông báo"),
                );
              } else if (state is NotifyPageLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    ThongBao thongBao = state.notifyList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: Styles.boxDecoration,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/notification_bell.png',
                              height: 50,
                            ),
                            const SizedBox(width: 16,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    thongBao.tieuDe.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(thongBao.noiDung.toString())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.notifyList.length,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                );
              } else {
                return const Center(
                  child: Text("Không có thông báo"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
