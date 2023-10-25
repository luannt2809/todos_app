part of 'add_user_page_bloc.dart';

@immutable
abstract class AddUserPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserEvent extends AddUserPageEvent {
  final String userName;
  final String passWd;
  final String email;
  final String fullName;
  final String phone;
  final String maPB;
  final int status;

  AddUserEvent(
      {required this.userName,
      required this.passWd,
      required this.email,
      required this.fullName,
      required this.phone,
      required this.maPB,
      required this.status});
}

class AddUserWithImageEvent extends AddUserPageEvent {
  final String userName;
  final String passWd;
  final String email;
  final String fullName;
  final String phone;
  final String maPB;
  final int status;
  final String anh;

  AddUserWithImageEvent(
      {required this.userName,
      required this.passWd,
      required this.email,
      required this.fullName,
      required this.phone,
      required this.maPB,
      required this.status,
      required this.anh});
}
