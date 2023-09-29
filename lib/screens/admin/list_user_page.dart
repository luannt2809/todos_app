import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/bloc/user/list_user_page/list_user_page_bloc.dart';
import 'package:todos_app/components/process_indicator.dart';
import 'package:todos_app/components/toast.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/admin/add_user_page.dart';
import 'package:todos_app/themes/styles.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final ListUserPageBloc listUserPageBloc = ListUserPageBloc();

  @override
  void initState() {
    // TODO: implement initState
    listUserPageBloc.add(GetListUser());
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
          "Danh sách người dùng",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => listUserPageBloc,
        child: BlocListener<ListUserPageBloc, ListUserPageState>(
          listener: (context, state) {
            if (state is ListUserPageError) {
              toast(state.error.toString());
            }
          },
          child: BlocBuilder<ListUserPageBloc, ListUserPageState>(
            builder: (context, state) {
              if (state is ListUserPageLoading) {
                return circularProgressIndicator();
              } else if (state is GetListUserEmpty) {
                return const Center(
                  child: Text("Không có dữ liệu"),
                );
              } else if (state is ListUserPageLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    NguoiDung nguoiDung = state.listUser[index];
                    String trangThai = "";
                    if (nguoiDung.trangThai == true) {
                      trangThai = "Hoạt động";
                    } else {
                      trangThai = "Không hoạt động";
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: Styles.boxDecoration,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/officer.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(nguoiDung.hoTen.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(nguoiDung.tenPhongBan.toString()),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(nguoiDung.danhSachVaiTro.toString())
                                ],
                              ),
                            ),
                            Text(
                              trangThai,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: nguoiDung.trangThai ?? false
                                      ? Colors.green
                                      : Colors.deepOrange),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.listUser.length,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddUserPage()))
              .then((value) => getData());
        },
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 3,
        highlightElevation: 3,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  getData() {
    listUserPageBloc.add(GetListUser());
  }
}
