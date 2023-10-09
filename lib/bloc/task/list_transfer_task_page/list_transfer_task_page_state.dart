part of 'list_transfer_task_page_bloc.dart';

@immutable
abstract class ListTransferTaskPageState extends Equatable {

  @override
  List<Object> get props => [];
}

class ListTransferTaskPageInitial extends ListTransferTaskPageState {}

class ListTransferTaskPageLoading extends ListTransferTaskPageState {}

class ListTransferTaskPageLoaded extends ListTransferTaskPageState {
  final List<CongViec> listTransferTask;

  ListTransferTaskPageLoaded({required this.listTransferTask});
}

class ListTransferTaskPageError extends ListTransferTaskPageState {
  final String? error;
  ListTransferTaskPageError({this.error});
}

class GetListTransferTaskEmpty extends ListTransferTaskPageState {}
