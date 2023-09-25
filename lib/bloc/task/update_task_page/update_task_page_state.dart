part of 'update_task_page_bloc.dart';

@immutable
abstract class UpdateTaskPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateTaskPageInitial extends UpdateTaskPageState {}

class UpdateTaskPageLoading extends UpdateTaskPageState {}

class UpdateTaskPageLoaded extends UpdateTaskPageState {
  final String msg;

  UpdateTaskPageLoaded(this.msg);
}

class UpdateTaskPageError extends UpdateTaskPageState {
  final String? error;

  UpdateTaskPageError({required this.error});
}
