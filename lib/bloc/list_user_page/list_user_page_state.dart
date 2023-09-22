part of 'list_user_page_bloc.dart';

@immutable
abstract class ListUserPageState extends Equatable {
  const ListUserPageState();

  @override
  List<Object> get props => [];
}

class ListUserPageInitial extends ListUserPageState {}

class ListUserPageLoading extends ListUserPageState {}

class ListUserPageLoaded extends ListUserPageState {
  final List<NguoiDung> listUser;

  const ListUserPageLoaded({required this.listUser});
}

class ListUserPageError extends ListUserPageState {
  final String? error;

  const ListUserPageError({this.error});
}

class GetListUserEmpty extends ListUserPageState {}