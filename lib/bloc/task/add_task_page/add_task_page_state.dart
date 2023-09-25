part of 'add_task_page_bloc.dart';

@immutable
abstract class AddTaskPageState extends Equatable {

  @override
  List<Object?> get props => [];
}

class AddTaskPageInitial extends AddTaskPageState {}

class AddTaskPageLoading extends AddTaskPageState {}

class AddTaskPageLoaded extends AddTaskPageState {
  final String msg;
  AddTaskPageLoaded(this.msg);
}

class AddTaskPageError extends AddTaskPageState {
  final String? error;

  AddTaskPageError({required this.error});
}
