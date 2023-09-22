part of 'list_department_page_bloc.dart';

@immutable
abstract class ListDepartmentPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetListDepartment extends ListDepartmentPageEvent {}
