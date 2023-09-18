part of 'delete_task_bloc.dart';

@immutable
abstract class DeleteTaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteTaskInitial extends DeleteTaskState {}

class DeletingTask extends DeleteTaskState {}

class DeletedTask extends DeleteTaskState {
  final String msg;

  DeletedTask(this.msg);
}

class DeleteTaskError extends DeleteTaskState {
  final String? error;

  DeleteTaskError(this.error);
}
