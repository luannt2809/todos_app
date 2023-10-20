part of 'notify_page_bloc.dart';

abstract class NotifyPageEvent extends Equatable {
  const NotifyPageEvent();
}

class GetListNotifyEvent extends NotifyPageEvent {
  @override
  List<Object> get props => [];
}
