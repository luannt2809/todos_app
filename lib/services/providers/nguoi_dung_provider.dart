import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/services/config/api_config.dart';

class NguoiDungProvider {
  Future<List<NguoiDung>> getInfoUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int? maND = sharedPreferences.getInt('maND');

    try {
      Response response =
          await ApiConfig.dio.get("${ApiConfig.BASE_URL}/nguoidung/$maND");

      List<dynamic> value = response.data;
      return value.map((e) => NguoiDung.fromJson(e)).toList();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return [];
      }
      print(e.toString());
      return [];
    }
  }

  Future<Response> updateInfo(
      String userName,
      String email,
      String fullName,
      String phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maND = prefs.getInt("maND");

    Response response = await ApiConfig.dio
        .put("${ApiConfig.BASE_URL}/nguoidung/update/$maND", data: {
      'TenNguoiDung': userName,
      'Email': email,
      'HoTen': fullName,
      'SoDienThoai': phone,
    });

    return response;
  }
}
