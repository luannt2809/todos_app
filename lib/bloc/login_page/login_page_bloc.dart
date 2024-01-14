import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/nguoi_dung.dart';

import 'package:todos_app/services/repositories/login_repository.dart';

part 'login_page_event.dart';

part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitial()) {
    on<LoginPageEvent>((event, emit) async {
      LoginRepository loginRepository = LoginRepository();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event is LoginEvent) {
        emit(LoginPageLoading());
        try {
          Response response = await loginRepository.login(event.username, event.passwd);
          if (response.statusCode == 200) {
            // cách lấy object từ sv gửi về
            var value = response.data["nguoiDung"];
            NguoiDung nguoiDung = NguoiDung.fromJson(value);

            // chuyển sang trạng thái thành công
            emit(LoginPageSuccess(msg: response.data['msg'].toString(), nguoiDung: nguoiDung));
            await prefs.setInt("maND", nguoiDung.maND!);
          }
        } on DioException catch (e) {
          if (e.type == DioExceptionType.badResponse) {
            emit(LoginPageError("Error: ${e.response?.data}"));
          } else {
            emit(LoginPageError(e.toString()));
          }
        }
      }
    });
  }
}
