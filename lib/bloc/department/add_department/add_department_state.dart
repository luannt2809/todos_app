part of 'add_department_bloc.dart';

@immutable
abstract class AddDepartmentState extends Equatable {
  @override
  List<Object> get props => [];
}

// add department (them phong ban)
class AddDepartmentInitial extends AddDepartmentState {}

class AddDepartmentLoading extends AddDepartmentState {}

class AddDepartmentLoaded extends AddDepartmentState {
  final String msg;

  AddDepartmentLoaded(this.msg);
}

class AddDepartmentError extends AddDepartmentState {
  final String? error;

  AddDepartmentError(this.error);
}
