
class PhongBan {
  int maPb;
  String tenPhongBan;

  PhongBan({
    required this.maPb,
    required this.tenPhongBan,
  });

  PhongBan copyWith({
    int? maPb,
    String? tenPhongBan,
  }) =>
      PhongBan(
        maPb: maPb ?? this.maPb,
        tenPhongBan: tenPhongBan ?? this.tenPhongBan,
      );

  factory PhongBan.fromJson(Map<String, dynamic> json) => PhongBan(
    maPb: json["MaPB"],
    tenPhongBan: json["TenPhongBan"],
  );

  Map<String, dynamic> toJson() => {
    "MaPB": maPb,
    "TenPhongBan": tenPhongBan,
  };
}
