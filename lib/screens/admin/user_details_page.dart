import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/themes/styles.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class UserDetailsPage extends StatefulWidget {
  final NguoiDung nguoiDung;

  const UserDetailsPage({super.key, required this.nguoiDung});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  String trangThai = "";
  final ImageProvider imageProvider =
      const AssetImage("assets/images/officer.png");

  @override
  void initState() {
    // TODO: implement initState
    if (widget.nguoiDung.trangThai == true) {
      setState(() {
        trangThai = "Hoạt động";
      });
    } else {
      setState(() {
        trangThai = "Hoạt động";
      });
    }
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
            "Thông tin chi tiết",
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, ["Reload"]);
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.orangeAccent,
              size: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
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
                child: widget.nguoiDung.anh.toString() == "null"
                    ? Image.asset("assets/images/officer.png")
                    : CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl:
                            "http://192.168.1.30:3000/${widget.nguoiDung.anh}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Colors.deepOrangeAccent,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Uri uri =
                              Uri.parse('tel:${widget.nguoiDung.soDienThoai}');
                          launcher.launchUrl(uri);
                        },
                        child: iconAction(Icons.call)),
                    GestureDetector(
                        onTap: () {
                          Uri uri =
                              Uri.parse('mailto:${widget.nguoiDung.email}');
                          launcher.launchUrl(uri);
                        },
                        child: iconAction(Icons.email))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: Styles.boxDecoration,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: Text("Username")),
                        Text("${widget.nguoiDung.tenNguoiDung}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Họ và tên")),
                        Text("${widget.nguoiDung.hoTen}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Số điện thoại")),
                        Text("${widget.nguoiDung.soDienThoai}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Email")),
                        Text("${widget.nguoiDung.email}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Phòng ban")),
                        Text("${widget.nguoiDung.tenPhongBan}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Quyền")),
                        Text("${widget.nguoiDung.danhSachVaiTro}")
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Expanded(child: Text("Trạng thái")),
                        Text(
                          trangThai,
                          style: TextStyle(
                              color: widget.nguoiDung.trangThai ?? false
                                  ? Colors.green
                                  : Colors.deepOrange),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget iconAction(IconData iconData) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(
        iconData,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}
