part of 'update_department_bloc.dart';

@immutable
abstract class UpdateDepartmentEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class UpdateDepartment extends UpdateDepartmentEvent {
  final int maPB;
  final String tenPB;
  UpdateDepartment({required this.maPB, required this.tenPB});
}
