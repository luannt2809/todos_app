class NguoiDung {
  int? maND;
  String? tenNguoiDung;
  String? matKhau;
  String? email;
  String? hoTen;
  String? soDienThoai;
  int? maPB;
  bool? trangThai;
  String? tenPhongBan;
  String? arrMaVT;
  String? danhSachVaiTro;

  NguoiDung(
      {this.maND,
        this.tenNguoiDung,
        this.matKhau,
        this.email,
        this.hoTen,
        this.soDienThoai,
        this.maPB,
        this.trangThai,
        this.tenPhongBan,
        this.arrMaVT,
        this.danhSachVaiTro});

  NguoiDung.fromJson(Map<String, dynamic> json) {
    maND = json['MaND'];
    tenNguoiDung = json['TenNguoiDung'];
    matKhau = json['MatKhau'];
    email = json['Email'];
    hoTen = json['HoTen'];
    soDienThoai = json['SoDienThoai'];
    maPB = json['MaPB'];
    trangThai = json['TrangThai'];
    tenPhongBan = json['TenPhongBan'];
    arrMaVT = json['ArrMaVT'];
    danhSachVaiTro = json['DanhSachVaiTro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MaND'] = this.maND;
    data['TenNguoiDung'] = this.tenNguoiDung;
    data['MatKhau'] = this.matKhau;
    data['Email'] = this.email;
    data['HoTen'] = this.hoTen;
    data['SoDienThoai'] = this.soDienThoai;
    data['MaPB'] = this.maPB;
    data['TrangThai'] = this.trangThai;
    data['TenPhongBan'] = this.tenPhongBan;
    data['ArrMaVT'] = this.arrMaVT;
    data['DanhSachVaiTro'] = this.danhSachVaiTro;
    return data;
  }
}
