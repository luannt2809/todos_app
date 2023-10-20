class ThongBao {
  int? maTB;
  String? tieuDe;
  String? noiDung;
  int? maCV;
  int? maND;

  ThongBao({this.maTB, this.tieuDe, this.noiDung, this.maCV, this.maND});

  ThongBao.fromJson(Map<String, dynamic> json) {
    maTB = json['MaTB'];
    tieuDe = json['TieuDe'];
    noiDung = json['NoiDung'];
    maCV = json['MaCV'];
    maND = json['MaND'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MaTB'] = this.maTB;
    data['TieuDe'] = this.tieuDe;
    data['NoiDung'] = this.noiDung;
    data['MaCV'] = this.maCV;
    data['MaND'] = this.maND;
    return data;
  }
}
