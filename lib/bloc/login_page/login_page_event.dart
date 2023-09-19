part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends LoginPageEvent {
  final String username;
  final String passwd;

  const LoginEvent({required this.username, required this.passwd});
}
