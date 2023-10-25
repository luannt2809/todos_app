class LogCongViec {
  int? maLogCV;
  int? maCV;
  String? tieuDe;
  String? noiDung;
  String? gioBatDau;
  String? gioKetThuc;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? trangThai;
  int? tienDo;
  String? ghiChu;
  int? maNguoiLam;
  int? maNguoiGiao;
  int? kieu;
  String? moTa;
  String? thoiGian;
  String? hoTen;
  String? error;

  LogCongViec(
      {this.maLogCV,
      this.maCV,
      this.tieuDe,
      this.noiDung,
      this.gioBatDau,
      this.gioKetThuc,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.trangThai,
      this.tienDo,
      this.ghiChu,
      this.maNguoiLam,
      this.maNguoiGiao,
      this.kieu,
      this.moTa,
      this.thoiGian,
      this.hoTen,
      this.error});

  LogCongViec.fromJson(Map<String, dynamic> json) {
    maLogCV = json['MaLogCV'];
    maCV = json['MaCV'];
    tieuDe = json['TieuDe'];
    noiDung = json['NoiDung'];
    gioBatDau = json['GioBatDau'];
    gioKetThuc = json['GioKetThuc'];
    ngayBatDau = json['NgayBatDau'];
    ngayKetThuc = json['NgayKetThuc'];
    trangThai = json['TrangThai'];
    tienDo = json['TienDo'];
    ghiChu = json['GhiChu'];
    maNguoiLam = json['MaNguoiLam'];
    maNguoiGiao = json['MaNguoiGiao'];
    kieu = json['Kieu'];
    moTa = json['MoTa'];
    thoiGian = json['ThoiGian'];
    hoTen = json['HoTen'];
    json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MaLogCV'] = maLogCV;
    data['MaCV'] = maCV;
    data['TieuDe'] = tieuDe;
    data['NoiDung'] = noiDung;
    data['GioBatDau'] = gioBatDau;
    data['GioKetThuc'] = gioKetThuc;
    data['NgayBatDau'] = ngayBatDau;
    data['NgayKetThuc'] = ngayKetThuc;
    data['TrangThai'] = trangThai;
    data['TienDo'] = tienDo;
    data['GhiChu'] = ghiChu;
    data['MaNguoiLam'] = maNguoiLam;
    data['MaNguoiGiao'] = maNguoiGiao;
    data['Kieu'] = kieu;
    data['MoTa'] = moTa;
    data['ThoiGian'] = thoiGian;
    data['HoTen'] = hoTen;
    return data;
  }

  LogCongViec.withError(String message) {
    error = message;
  }
}
