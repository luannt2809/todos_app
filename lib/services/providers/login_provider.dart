import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/services/config/api_config.dart';

class LoginProvider {
  Future<Response> login(String username, String passwd) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String? tokenUser =
    sharedPreferences.getString("TokenUser");

    Response response = await ApiConfig.dio
        .post('${ApiConfig.BASE_URL}/nguoidung/login', data: {
      'TenNguoiDung': username,
      'MatKhau': passwd,
      'TokenUser': tokenUser
    });
    return response;
  }
}
