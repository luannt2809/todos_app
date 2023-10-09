part of 'list_log_task_page_bloc.dart';

@immutable
abstract class ListLogTaskPageState extends Equatable {

  @override
  List<Object> get props => [];
}

class ListLogTaskPageInitial extends ListLogTaskPageState {}

class ListLogTaskPageLoading extends ListLogTaskPageState {}

class ListLogTaskPageLoaded extends ListLogTaskPageState {
  final List<LogCongViec> listLogCongViec;

  ListLogTaskPageLoaded({required this.listLogCongViec});
}

class ListLogTaskPageError extends ListLogTaskPageState {
  final String? error;
  ListLogTaskPageError({this.error});
}

class GetListLogCongViecEmpty extends ListLogTaskPageState {}