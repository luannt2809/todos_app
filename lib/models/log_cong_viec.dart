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
        this.hoTen, this.error});

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
    error: json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MaLogCV'] = this.maLogCV;
    data['MaCV'] = this.maCV;
    data['TieuDe'] = this.tieuDe;
    data['NoiDung'] = this.noiDung;
    data['GioBatDau'] = this.gioBatDau;
    data['GioKetThuc'] = this.gioKetThuc;
    data['NgayBatDau'] = this.ngayBatDau;
    data['NgayKetThuc'] = this.ngayKetThuc;
    data['TrangThai'] = this.trangThai;
    data['TienDo'] = this.tienDo;
    data['GhiChu'] = this.ghiChu;
    data['MaNguoiLam'] = this.maNguoiLam;
    data['MaNguoiGiao'] = this.maNguoiGiao;
    data['Kieu'] = this.kieu;
    data['MoTa'] = this.moTa;
    data['ThoiGian'] = this.thoiGian;
    data['HoTen'] = this.hoTen;
    return data;
  }

  LogCongViec.withError(String message) {
    error = message;
  }
}
