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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MaPB'] = this.maPB;
    data['TenPhongBan'] = this.tenPhongBan;
    data['ArrMaVT'] = this.arrMaVT;
    data['DanhSachVaiTro'] = this.danhSachVaiTro;
    return data;
  }
}
