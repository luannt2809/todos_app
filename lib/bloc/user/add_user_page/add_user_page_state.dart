part of 'add_user_page_bloc.dart';

@immutable
abstract class AddUserPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserPageInitial extends AddUserPageState {}

class AddUserLoading extends AddUserPageState {}

class AddUserLoaded extends AddUserPageState {
  final String msg;

  AddUserLoaded({required this.msg});
}

class AddUserError extends AddUserPageState {
  final String? error;

  AddUserError({required this.error});
}
