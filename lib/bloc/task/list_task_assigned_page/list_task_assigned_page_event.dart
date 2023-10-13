part of 'list_task_assigned_page_bloc.dart';

@immutable
abstract class ListTaskAssignedPageEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class GetListTaskAssigned extends ListTaskAssignedPageEvent {
  final String trangThai;

  GetListTaskAssigned({required this.trangThai});
}
