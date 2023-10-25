part of 'update_user_page_bloc.dart';

@immutable
abstract class UpdateUserPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends UpdateUserPageEvent {
  final int maND;
  final String userName;
  final String passWd;
  final String email;
  final String fullName;
  final String phone;
  final String maPB;
  final int status;

  UpdateUserEvent(
      {required this.maND,
      required this.userName,
      required this.passWd,
      required this.email,
      required this.fullName,
      required this.phone,
      required this.maPB,
      required this.status});
}

class UpdateUserWithImageEvent extends UpdateUserPageEvent {
  final int maND;
  final String userName;
  final String passWd;
  final String email;
  final String fullName;
  final String phone;
  final String maPB;
  final int status;
  final String anh;

  UpdateUserWithImageEvent(
      {required this.maND,
      required this.userName,
      required this.passWd,
      required this.email,
      required this.fullName,
      required this.phone,
      required this.maPB,
      required this.status,
      required this.anh});
}
