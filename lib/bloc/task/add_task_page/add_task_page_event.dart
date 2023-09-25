part of 'add_task_page_bloc.dart';

@immutable
abstract class AddTaskPageEvent extends Equatable {
  @override
  List<Object> get props => [];

  const AddTaskPageEvent();
}

class AddTask extends AddTaskPageEvent {
  final String tieuDe;
  final String noiDung;
  final String ngayBD;
  final String ngayKT;
  final String gioBD;
  final String gioKT;
  final String trangThai;
  final String tienDo;
  final String ghiChu;

  const AddTask(
      {required this.tieuDe,
      required this.noiDung,
      required this.ngayBD,
      required this.ngayKT,
      required this.gioBD,
      required this.gioKT,
      required this.trangThai,
      required this.tienDo,
      required this.ghiChu});
}
