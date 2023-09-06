import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todos_app/models/CongViec.dart';
import 'package:todos_app/services/api/api_congviec.dart';

class TaskDetailsPage extends StatefulWidget {
  // final String maCV;
  final CongViec congViec;
  final String gio;
  final String ngay;

  const TaskDetailsPage(
      {super.key,
      required this.congViec,
      required this.gio,
      required this.ngay});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  String hoTen = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<dynamic> getUser() async {
    try {
      Dio dio = Dio();

      Response response = await dio.get(
          "http://192.168.1.23:3000/api/nguoidung/${widget.congViec.maNguoiLam}");

      setState(() {
        hoTen = response.data[0]['HoTen'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(maCV);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.orangeAccent,
              size: 20,
            ),
          ),
          title: const Text(
            "Chi tiết",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(widget.congViec.tieuDe.toString()),
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
                                  text: widget.gio,
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
                            text: widget.ngay,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RowItem(
                            icon: Icons.person_outline_outlined,
                            text: hoTen,
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
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
                  TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    indicatorColor: Colors.orangeAccent,
                    labelColor: Colors.deepOrangeAccent,
                    unselectedLabelColor: Colors.grey,
                    indicator: CircleTabIndicator(
                        color: Colors.deepOrangeAccent, radius: 4),
                    tabs: const [
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
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Nội dung của Tab 1
              ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                // children: listItem,
              ),
              // Nội dung của Tab 2
              const Center(child: Text('Tab 2 Content')),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

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
      child: _tabBar,
      padding: const EdgeInsets.only(bottom: 5),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
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
