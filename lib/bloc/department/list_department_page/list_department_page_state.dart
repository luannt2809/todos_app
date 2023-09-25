part of 'list_department_page_bloc.dart';

@immutable
abstract class ListDepartmentPageState extends Equatable {
  const ListDepartmentPageState();

  @override
  List<Object> get props => [];
}

class ListDepartmentPageInitial extends ListDepartmentPageState {}

class ListDepartmentPageLoading extends ListDepartmentPageState {}

class ListDepartmentPageLoaded extends ListDepartmentPageState {
  final List<PhongBan> listDepartment;

  const ListDepartmentPageLoaded({required this.listDepartment});
}

class ListDepartmentPageError extends ListDepartmentPageState {
  final String? error;

  const ListDepartmentPageError({this.error});
}

class GetListDepartmentEmpty extends ListDepartmentPageState {}