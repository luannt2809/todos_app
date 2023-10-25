
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_app/services/repositories/nguoi_dung_repository.dart';

part 'forgot_passwd_page_event.dart';

part 'forgot_passwd_page_state.dart';

class ForgotPasswdPageBloc
    extends Bloc<ForgotPasswdPageEvent, ForgotPasswdPageState> {
  ForgotPasswdPageBloc() : super(ForgotPasswdPageInitial()) {
    on<ForgotPasswdPageEvent>((event, emit) async {
      NguoiDungRepository nguoiDungRepository = NguoiDungRepository();
      if (event is ForgotPasswdEvent) {
        emit(ForgotPasswdPageLoading());
        try {
          Response response = await nguoiDungRepository.forgotPasswd(
              event.tenND, event.matKhau);

          if (response.statusCode == 200) {
            emit(ForgotPasswdPageLoaded(msg: response.data));
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(ForgotPasswdPageError(error: e.response?.data));
          } else {
            emit(ForgotPasswdPageError(error: e.toString()));
          }
        }
      }
    });
  }
}
