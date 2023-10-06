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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['HoTenNguoiLam'] = this.hoTenNguoiLam;
    data['HoTenNguoiGiao'] = this.hoTenNguoiGiao;
    return data;
  }

  CongViec.withError(String message) {
    error = message;
  }
}
