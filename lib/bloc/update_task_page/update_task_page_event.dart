part of 'update_task_page_bloc.dart';

@immutable
abstract class UpdateTaskPageEvent extends Equatable {
  @override
  List<Object> get props => [];

  const UpdateTaskPageEvent();
}

class UpdateTask extends UpdateTaskPageEvent {
  final int maCV;
  final String tieuDe;
  final String noiDung;
  final String ngayBD;
  final String ngayKT;
  final String gioBD;
  final String gioKT;
  final String trangThai;
  final String tienDo;
  final String ghiChu;

  const UpdateTask(
      {required this.maCV,
      required this.tieuDe,
      required this.noiDung,
      required this.ngayBD,
      required this.ngayKT,
      required this.gioBD,
      required this.gioKT,
      required this.trangThai,
      required this.tienDo,
      required this.ghiChu});
}
