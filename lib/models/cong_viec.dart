class CongViec {
  int? maCV;
  String? tieuDe;
  String? noiDung;
  String? gioBatDau;
  String? gioKetThuc;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? trangThai;
  double? tienDo;
  String? ghiChu;
  int? maNguoiLam;
  int? maNguoiGiao;
  int? kieu;
  String? hoTenNguoiLam;
  String? hoTenNguoiGiao;
  String? error;

  CongViec(
      {this.maCV,
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
      this.hoTenNguoiLam,
      this.hoTenNguoiGiao, this.error});

  factory CongViec.fromJson(Map<String, dynamic> json) {
    return CongViec(
      maCV: json['MaCV'],
      tieuDe: json['TieuDe'],
      noiDung: json['NoiDung'],
      gioBatDau: json['GioBatDau'],
      gioKetThuc: json['GioKetThuc'],
      ngayBatDau: json['NgayBatDau'],
      ngayKetThuc: json['NgayKetThuc'],
      trangThai: json['TrangThai'],
      tienDo: json['TienDo'].toDouble(),
      ghiChu: json['GhiChu'],
      maNguoiLam: json['MaNguoiLam'],
      maNguoiGiao: json['MaNguoiGiao'],
      kieu: json['Kieu'],
      hoTenNguoiLam: json['HoTenNguoiLam'],
      hoTenNguoiGiao: json['HoTenNguoiGiao'],
      error: json['error']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['HoTenNguoiLam'] = hoTenNguoiLam;
    data['HoTenNguoiGiao'] = hoTenNguoiGiao;
    return data;
  }

  CongViec.withError(String message) {
    error = message;
  }
}
