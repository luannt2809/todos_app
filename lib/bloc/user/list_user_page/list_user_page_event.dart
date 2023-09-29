part of 'list_user_page_bloc.dart';

@immutable
abstract class ListUserPageEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class GetListUser extends ListUserPageEvent {}
