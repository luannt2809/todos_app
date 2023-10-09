part of 'list_log_task_page_bloc.dart';

@immutable
abstract class ListLogTaskPageEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class GetListLogTaskEvent extends ListLogTaskPageEvent {
  final int? maCV;

  GetListLogTaskEvent({this.maCV});
}
