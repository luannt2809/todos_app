import 'package:dio/dio.dart';
import 'package:todos_app/services/providers/login_provider.dart';

class LoginRepository {
  LoginProvider loginProvider = LoginProvider();

  Future<Response> login(String username, String passwd) {
    return loginProvider.login(username, passwd);
  }
}
