part of 'list_task_assigned_page_bloc.dart';

@immutable
abstract class ListTaskAssignedPageState extends Equatable {
  const ListTaskAssignedPageState();

  @override
  List<Object> get props => [];
}

class ListTaskAssignedPageInitial extends ListTaskAssignedPageState {}

class ListTaskAssignedPageLoading extends ListTaskAssignedPageState {}

class ListTaskAssignedPageLoaded extends ListTaskAssignedPageState {
  final List<CongViec> listTaskAssigned;

  const ListTaskAssignedPageLoaded({required this.listTaskAssigned});
}

class ListTaskAssignedPageError extends ListTaskAssignedPageState {
  final String? error;
  const ListTaskAssignedPageError({this.error});
}

class ListTaskAssignedPageEmpty extends ListTaskAssignedPageState {}
