part of 'login_page_bloc.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();
}

class LoginPageInitial extends LoginPageState {
  @override
  List<Object> get props => [];
}

class LoginPageLoading extends LoginPageState {
  @override
  List<Object> get props => [];
}

class LoginPageSuccess extends LoginPageState {
  final String msg;
  final NguoiDung nguoiDung;

  const LoginPageSuccess({required this.msg, required this.nguoiDung});

  @override
  List<Object> get props => [];
}

class LoginPageError extends LoginPageState {
  final String? error;

  const LoginPageError(this.error);

  @override
  List<Object> get props => [];
}
