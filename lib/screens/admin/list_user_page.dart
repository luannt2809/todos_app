import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todos_app/bloc/user/list_user_page/list_user_page_bloc.dart';
import 'package:todos_app/components/custom_toast.dart';
import 'package:todos_app/components/process_indicator.dart';

import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/admin/add_user_page.dart';
import 'package:todos_app/screens/admin/update_user_page.dart';
import 'package:todos_app/screens/admin/user_details_page.dart';
import 'package:todos_app/themes/styles.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final ListUserPageBloc listUserPageBloc = ListUserPageBloc();
  final ScrollController _scrollController = ScrollController();
  bool fabVisible = true;
  final ImageProvider imageProvider =
      const AssetImage("assets/images/officer.png");

  @override
  void initState() {
    // TODO: implement initState
    listUserPageBloc.add(GetListUser());
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        fabVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        fabVisible = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    _scrollController.removeListener(_scrollListener);
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
              customToast(
                  context: context,
                  title: "Lỗi",
                  message: state.error.toString(),
                  contentType: ContentType.failure);
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
                  controller: _scrollController,
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
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (_) => UpdateUserPage(
                                            nguoiDung: nguoiDung)))
                                    .then((value) => getData());
                              },
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                            )
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (_) =>
                                        UserDetailsPage(nguoiDung: nguoiDung)))
                                .then((value) => getData());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, left: 16),
                            decoration: Styles.boxDecoration,
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    // borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: nguoiDung.anh.toString() == "null"
                                      ? Image.asset("assets/images/officer.png")
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "http://192.168.1.30:3000/${nguoiDung.anh}",
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                          ),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: Colors.deepOrangeAccent,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nguoiDung.hoTen.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
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
                                const SizedBox(
                                  width: 8,
                                ),
                                Transform.rotate(
                                  angle: 3.14 / 2,
                                  child: const Icon(
                                    Icons.drag_handle,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
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
                return const Center(
                  child: Text("Không có dữ liệu"),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: fabVisible
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (_) => const AddUserPage()))
                    .then((value) => getData());
              },
              backgroundColor: Colors.deepOrangeAccent,
              elevation: 3,
              highlightElevation: 3,
              child: const Icon(
                Icons.add,
              ),
            )
          : null,
    );
  }

  getData() {
    listUserPageBloc.add(GetListUser());
  }
}
