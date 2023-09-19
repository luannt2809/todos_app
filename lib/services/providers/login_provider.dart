import 'package:dio/dio.dart';
import 'package:todos_app/services/config/api_config.dart';

class LoginProvider {
  Future<Response> login(String username, String passwd) async {
    Response response = await ApiConfig.dio
        .post('${ApiConfig.BASE_URL}/nguoidung/login', data: {
      'TenNguoiDung': username,
      'MatKhau': passwd,
    });
    return response;
  }
}
