part of 'profile_page_bloc.dart';

@immutable
abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object> get props => [];
}

class GetInfoEvent extends ProfilePageEvent {}

class ChangeInfoEvent extends ProfilePageEvent {
  final String userName;
  final String email;
  final String fullName;
  final String phone;
  final String anh;

  const ChangeInfoEvent(
      {required this.userName,
      required this.email,
      required this.fullName,
      required this.phone,
      required this.anh});
}

class ChangeInfoNoImageEvent extends ProfilePageEvent {
  final String userName;
  final String email;
  final String fullName;
  final String phone;

  const ChangeInfoNoImageEvent(
      {required this.userName,
      required this.email,
      required this.fullName,
      required this.phone});
}
