part of 'list_transfer_task_page_bloc.dart';

@immutable
abstract class ListTransferTaskPageEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class GetListTransferTaskEvent extends ListTransferTaskPageEvent {
  final int? maCV;

  GetListTransferTaskEvent({this.maCV});
}
