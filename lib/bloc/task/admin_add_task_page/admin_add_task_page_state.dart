part of 'admin_add_task_page_bloc.dart';

@immutable
abstract class AdminAddTaskPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdminAddTaskPageInitial extends AdminAddTaskPageState {}

class AdminAddTaskPageLoading extends AdminAddTaskPageState {}

class AdminAddTaskPageLoaded extends AdminAddTaskPageState {
  final String msg;

  AdminAddTaskPageLoaded(this.msg);
}

class AdminAddTaskPageError extends AdminAddTaskPageState {
  final String? error;

  AdminAddTaskPageError(this.error);
}
