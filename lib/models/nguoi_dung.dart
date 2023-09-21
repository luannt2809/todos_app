
class NguoiDung {
  int maNd;
  String tenNguoiDung;
  String matKhau;
  String email;
  String hoTen;
  String soDienThoai;
  int maVt;
  int maPb;
  bool trangThai;
  String tenPhongBan;
  String tenVaiTro;

  NguoiDung({
    required this.maNd,
    required this.tenNguoiDung,
    required this.matKhau,
    required this.email,
    required this.hoTen,
    required this.soDienThoai,
    required this.maVt,
    required this.maPb,
    required this.trangThai,
    required this.tenPhongBan,
    required this.tenVaiTro,
  });

  NguoiDung copyWith({
    int? maNd,
    String? tenNguoiDung,
    String? matKhau,
    String? email,
    String? hoTen,
    String? soDienThoai,
    int? maVt,
    int? maPb,
    bool? trangThai,
    String? tenPhongBan,
    String? tenVaiTro,
  }) =>
      NguoiDung(
        maNd: maNd ?? this.maNd,
        tenNguoiDung: tenNguoiDung ?? this.tenNguoiDung,
        matKhau: matKhau ?? this.matKhau,
        email: email ?? this.email,
        hoTen: hoTen ?? this.hoTen,
        soDienThoai: soDienThoai ?? this.soDienThoai,
        maVt: maVt ?? this.maVt,
        maPb: maPb ?? this.maPb,
        trangThai: trangThai ?? this.trangThai,
        tenPhongBan: tenPhongBan ?? this.tenPhongBan,
        tenVaiTro: tenVaiTro ?? this.tenVaiTro,
      );

  factory NguoiDung.fromJson(Map<String, dynamic> json) => NguoiDung(
    maNd: json["MaND"],
    tenNguoiDung: json["TenNguoiDung"],
    matKhau: json["MatKhau"],
    email: json["Email"],
    hoTen: json["HoTen"],
    soDienThoai: json["SoDienThoai"],
    maVt: json["MaVT"],
    maPb: json["MaPB"],
    trangThai: json["TrangThai"],
    tenPhongBan: json["TenPhongBan"],
    tenVaiTro: json["TenVaiTro"],
  );

  Map<String, dynamic> toJson() => {
    "MaND": maNd,
    "TenNguoiDung": tenNguoiDung,
    "MatKhau": matKhau,
    "Email": email,
    "HoTen": hoTen,
    "SoDienThoai": soDienThoai,
    "MaVT": maVt,
    "MaPB": maPb,
    "TrangThai": trangThai,
    "TenPhongBan": tenPhongBan,
    "TenVaiTro": tenVaiTro,
  };
}
