class CongViec {
  String _tieuDe;
  String _noiDung;
  String _gioBatDau;
  String _gioKetThuc;
  String _ngayBatDau;
  String _ngayKetThuc;
  String _trangThai;
  double _tienDo;
  String _ghiChu;
  int _maNguoiLam;
  int _maNguoiGiao;
  int _Kieu;

  CongViec(
      this._tieuDe,
      this._noiDung,
      this._gioBatDau,
      this._gioKetThuc,
      this._ngayBatDau,
      this._ngayKetThuc,
      this._trangThai,
      this._tienDo,
      this._ghiChu,
      this._maNguoiLam,
      this._maNguoiGiao,
      this._Kieu);

  int get Kieu => _Kieu;

  set Kieu(int value) {
    _Kieu = value;
  }

  int get maNguoiGiao => _maNguoiGiao;

  set maNguoiGiao(int value) {
    _maNguoiGiao = value;
  }

  int get maNguoiLam => _maNguoiLam;

  set maNguoiLam(int value) {
    _maNguoiLam = value;
  }

  String get ghiChu => _ghiChu;

  set ghiChu(String value) {
    _ghiChu = value;
  }

  double get tienDo => _tienDo;

  set tienDo(double value) {
    _tienDo = value;
  }

  String get trangThai => _trangThai;

  set trangThai(String value) {
    _trangThai = value;
  }

  String get ngayKetThuc => _ngayKetThuc;

  set ngayKetThuc(String value) {
    _ngayKetThuc = value;
  }

  String get ngayBatDau => _ngayBatDau;

  set ngayBatDau(String value) {
    _ngayBatDau = value;
  }

  String get gioKetThuc => _gioKetThuc;

  set gioKetThuc(String value) {
    _gioKetThuc = value;
  }

  String get gioBatDau => _gioBatDau;

  set gioBatDau(String value) {
    _gioBatDau = value;
  }

  String get noiDung => _noiDung;

  set noiDung(String value) {
    _noiDung = value;
  }

  String get tieuDe => _tieuDe;

  set tieuDe(String value) {
    _tieuDe = value;
  }
}
