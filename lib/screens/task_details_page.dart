import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/screens/assigned_task_to_others_page.dart';
import 'package:todos_app/screens/list_log_task_page.dart';
import 'package:todos_app/screens/list_transfer_task_page.dart';
import 'package:todos_app/themes/styles.dart';

class TaskDetailsPage extends StatefulWidget {
  final NguoiDung nguoiDung;
  final CongViec congViec;

  const TaskDetailsPage(
      {super.key, required this.congViec, required this.nguoiDung});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
          title: const Text(
            "Chi tiết",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  Share.share(
                      "Tiêu đề: ${widget.congViec.tieuDe}\nNội dung: ${widget.congViec.noiDung}"
                      "\nTiến độ: ${widget.congViec.tienDo}%\n Trạng thái: ${widget.congViec.trangThai}",
                      subject: widget.congViec.tieuDe);
                },
                child: Icon(
                  Icons.share,
                  size: 20,
                  color: Colors.orangeAccent,
                ),
              ),
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin:
                          const EdgeInsets.only(top: 10, left: 16, right: 16),
                      decoration: Styles.boxDecoration,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child:
                                        Text(widget.congViec.tieuDe.toString()),
                                  ),
                                  Text(
                                    widget.congViec.trangThai.toString(),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: RowItem(
                                      icon: Icons.access_time,
                                      text:
                                          "${DateFormat.jm().format(DateTime.parse(widget.congViec.gioBatDau.toString()))} - "
                                          "${DateFormat.jm().format(DateTime.parse(widget.congViec.gioKetThuc.toString()))}",
                                    ),
                                  ),
                                  Text(
                                    "${widget.congViec.tienDo}%",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepOrange,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RowItem(
                                icon: Icons.calendar_month_outlined,
                                text:
                                    "${DateFormat('dd/MM/y').format(DateTime.parse(widget.congViec.ngayBatDau.toString()))} - "
                                    "${DateFormat('dd/MM/y').format(DateTime.parse(widget.congViec.ngayKetThuc.toString()))}",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RowItem(
                                icon: Icons.person_outline_outlined,
                                text: widget.congViec.hoTenNguoiLam ??
                                    widget.nguoiDung.hoTen.toString(),
                              ),
                            ],
                          ),
                          Visibility(
                            visible:
                                widget.congViec.trangThai == "Hoàn thành" &&
                                    widget.congViec.tienDo == 100,
                            child: Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => AssignedTaskToOther(
                                        congViec: widget.congViec,
                                        nguoiDung: widget.nguoiDung,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: Styles.boxDecoration,
                                  child: Icon(
                                    Icons.navigate_next,
                                    size: 20,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: const Row(
                        children: <Widget>[
                          Icon(
                            Icons.description,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Nội dung",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        widget.congViec.noiDung.toString(),
                        softWrap: true,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: const Row(
                        children: <Widget>[
                          Icon(
                            Icons.notes,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Ghi chú",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Text(
                        widget.congViec.ghiChu.toString() == "null"
                            ? "Không có ghi chú"
                            : widget.congViec.ghiChu.toString(),
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(left: 20, right: 20),
                    indicatorColor: Colors.orangeAccent,
                    labelColor: Colors.deepOrangeAccent,
                    unselectedLabelColor: Colors.grey,
                    indicator: CircleTabIndicator(
                        color: Colors.deepOrangeAccent, radius: 4),
                    tabs: [
                      Tab(text: 'Nhật ký'),
                      Tab(text: 'Công việc khác'),
                    ],
                  ),
                ),
                pinned: true,
              )
            ];
          },
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              // Nội dung của Tab 1
              // FutureBuilder<List<dynamic>>(
              //   future: getListLogCV(),
              //   builder: (BuildContext context,
              //       AsyncSnapshot<List<dynamic>> snapshot) {
              //     if (snapshot.hasData) {
              //       return ListView.builder(
              //         itemBuilder: (BuildContext context, int index) {
              //           // item
              //           return itemListLogCV(
              //               snapshot.data![index]['TieuDe'].toString(),
              //               snapshot.data![index]['ThoiGian'].toString(),
              //               snapshot.data![index]['HoTen'].toString(),
              //               snapshot.data![index]['TrangThai'].toString(),
              //               snapshot.data![index]['TienDo'].toDouble(),
              //               snapshot.data![index]['MoTa'].toString(),
              //               context);
              //         },
              //         itemCount: snapshot.data!.length,
              //         physics: const BouncingScrollPhysics(),
              //         padding: const EdgeInsets.only(
              //           left: 16,
              //           right: 16,
              //           bottom: 16,
              //         ),
              //       );
              //     } else {
              //       return const Center(
              //         child: Text("Chưa có dữ liệu"),
              //       );
              //     }
              //   },
              // ),
              // Nội dung của Tab 2
              ListLogTaskPage(congViec: widget.congViec),
              ListTransferTaskPage(
                congViec: widget.congViec,
                nguoiDung: widget.nguoiDung,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 5),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

Widget itemListLogCV(String tieuDe, String thoiGian, String hoTenNguoiLam,
    String trangThai, double tienDo, String moTa, BuildContext context) {
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
                tieuDe,
                softWrap: true,
              )),
              Text(
                DateFormat('dd-MM-yyyy   hh:mm a')
                    .format(DateTime.parse(thoiGian))
                    .toString(),
                softWrap: true,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RowItem(icon: Icons.person_outline_outlined, text: hoTenNguoiLam),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trangThai,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                    fontSize: 15),
              ),
              Text(
                "$tienDo%",
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
                  text: moTa,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
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
