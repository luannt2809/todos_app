part of 'delete_task_bloc.dart';

@immutable
abstract class DeleteTaskEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class DeleteTask extends DeleteTaskEvent {
  final int maCV;

  DeleteTask(this.maCV);
}