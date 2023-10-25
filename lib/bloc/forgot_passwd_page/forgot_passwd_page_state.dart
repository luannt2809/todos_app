part of 'forgot_passwd_page_bloc.dart';

abstract class ForgotPasswdPageState extends Equatable {
  const ForgotPasswdPageState();
}

class ForgotPasswdPageInitial extends ForgotPasswdPageState {
  @override
  List<Object> get props => [];
}

class ForgotPasswdPageLoading extends ForgotPasswdPageState {
  @override
  List<Object> get props => [];
}

class ForgotPasswdPageLoaded extends ForgotPasswdPageState {
  final String msg;

  const ForgotPasswdPageLoaded({required this.msg});

  @override
  List<Object> get props => [msg];
}

class ForgotPasswdPageError extends ForgotPasswdPageState {
  final String error;

  const ForgotPasswdPageError({required this.error});

  @override
  List<Object> get props => [];
}
