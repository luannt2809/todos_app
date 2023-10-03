part of 'update_user_page_bloc.dart';

@immutable
abstract class UpdateUserPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateUserPageInitial extends UpdateUserPageState {}

class UpdatingUser extends UpdateUserPageState {}

class UpdatedUser extends UpdateUserPageState {
  final String msg;

  UpdatedUser(this.msg);
}

class UpdateUserError extends UpdateUserPageState {
  final String? error;

  UpdateUserError(this.error);
}
