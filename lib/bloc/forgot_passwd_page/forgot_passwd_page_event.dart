part of 'forgot_passwd_page_bloc.dart';

abstract class ForgotPasswdPageEvent extends Equatable {
  const ForgotPasswdPageEvent();
}

class ForgotPasswdEvent extends ForgotPasswdPageEvent {
  final String tenND;
  final String matKhau;

  const ForgotPasswdEvent({required this.tenND, required this.matKhau});

  @override
  List<Object> get props => [tenND, matKhau];
}
