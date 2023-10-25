class PhongBan {
  int? maPB;
  String? tenPhongBan;
  String? arrMaVT;
  String? danhSachVaiTro;

  PhongBan({this.maPB, this.tenPhongBan, this.arrMaVT, this.danhSachVaiTro});

  PhongBan.fromJson(Map<String, dynamic> json) {
    maPB = json['MaPB'];
    tenPhongBan = json['TenPhongBan'];
    arrMaVT = json['ArrMaVT'];
    danhSachVaiTro = json['DanhSachVaiTro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MaPB'] = maPB;
    data['TenPhongBan'] = tenPhongBan;
    data['ArrMaVT'] = arrMaVT;
    data['DanhSachVaiTro'] = danhSachVaiTro;
    return data;
  }
}
