part of 'profile_page_bloc.dart';

@immutable
abstract class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

class ProfilePageInitial extends ProfilePageState {}

class GetInfoLoading extends ProfilePageState {}

class GetInfoLoaded extends ProfilePageState {
  final List<NguoiDung> userList;

  const GetInfoLoaded({required this.userList});
}

class GetInfoError extends ProfilePageState {
  final String? error;

  const GetInfoError(this.error);
}

class ChangingInfo extends ProfilePageState {}

class ChangeInfoSuccess extends ProfilePageState {
  final String msg;
  const ChangeInfoSuccess(this.msg);
}

class ChangeInfoError extends ProfilePageState {
  final String? error;

  const ChangeInfoError({required this.error});
}
