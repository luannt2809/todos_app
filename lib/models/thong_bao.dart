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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MaTB'] = maTB;
    data['TieuDe'] = tieuDe;
    data['NoiDung'] = noiDung;
    data['MaCV'] = maCV;
    data['MaND'] = maND;
    return data;
  }
}
