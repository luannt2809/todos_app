part of 'add_department_bloc.dart';

@immutable
abstract class AddDepartmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddDepartment extends AddDepartmentEvent {
  final String tenPB;
  final String arrMaVT;
  AddDepartment(this.tenPB, this.arrMaVT);
}
