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
  String? anh;

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
        this.danhSachVaiTro, this.anh});

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
    anh = json['Anh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MaND'] = maND;
    data['TenNguoiDung'] = tenNguoiDung;
    data['MatKhau'] = matKhau;
    data['Email'] = email;
    data['HoTen'] = hoTen;
    data['SoDienThoai'] = soDienThoai;
    data['MaPB'] = maPB;
    data['TrangThai'] = trangThai;
    data['TenPhongBan'] = tenPhongBan;
    data['ArrMaVT'] = arrMaVT;
    data['DanhSachVaiTro'] = danhSachVaiTro;
    data['Anh'] = anh;
    return data;
  }
}
