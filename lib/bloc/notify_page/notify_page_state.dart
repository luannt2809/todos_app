part of 'notify_page_bloc.dart';

abstract class NotifyPageState extends Equatable {
  const NotifyPageState();
}

class NotifyPageInitial extends NotifyPageState {
  @override
  List<Object> get props => [];
}

class NotifyPageLoading extends NotifyPageState {
  @override
  List<Object> get props => [];
}

class NotifyPageLoaded extends NotifyPageState {
  final List<ThongBao> notifyList;
  const NotifyPageLoaded({required this.notifyList});

  @override
  List<Object> get props => [notifyList];
}

class NotifyPageError extends NotifyPageState {
  final String error;
  const NotifyPageError({required this.error});

  @override
  List<Object> get props => [error];
}

class GetListNotifyEmpty extends NotifyPageState {
  @override
  List<Object> get props => [];
}