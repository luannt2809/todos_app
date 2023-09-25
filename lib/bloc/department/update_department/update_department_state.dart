part of 'update_department_bloc.dart';

@immutable
abstract class UpdateDepartmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateDepartmentInitial extends UpdateDepartmentState {}

class UpdatingDepartment extends UpdateDepartmentState {}

class UpdatedDepartment extends UpdateDepartmentState {
  final String msg;
  UpdatedDepartment(this.msg);
}

class UpdateDepartmentError extends UpdateDepartmentState {
  final String? error;
  UpdateDepartmentError(this.error);
}
