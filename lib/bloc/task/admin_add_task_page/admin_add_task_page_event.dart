part of 'admin_add_task_page_bloc.dart';

@immutable
abstract class AdminAddTaskPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AdminAddTaskEvent extends AdminAddTaskPageEvent {
  final String tieuDe;
  final String noiDung;
  final String ngayBD;
  final String ngayKT;
  final String gioBD;
  final String gioKT;
  final String trangThai;
  final String tienDo;
  final String ghiChu;
  final int maNguoiLam;
  final int? maNguoiGiao;
  final int? kieu;

  AdminAddTaskEvent({
    required this.tieuDe,
    required this.noiDung,
    required this.ngayBD,
    required this.ngayKT,
    required this.gioBD,
    required this.gioKT,
    required this.trangThai,
    required this.tienDo,
    required this.ghiChu,
    required this.maNguoiLam,
    required this.maNguoiGiao,
    this.kieu});
}
