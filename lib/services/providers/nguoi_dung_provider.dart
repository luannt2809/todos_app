import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/services/config/api_config.dart';

class NguoiDungProvider {
  Future<List<NguoiDung>> getListUser() async {
    Response response =
        await ApiConfig.dio.get("${ApiConfig.BASE_URL}/nguoidung/list");

    List<dynamic> value = response.data;
    return value.map((e) => NguoiDung.fromJson(e)).toList();
  }

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

  Future<List<NguoiDung>> getListOthers() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final int? maND = sharedPreferences.getInt('maND');

    try {
      Response response = await ApiConfig.dio
          .get("${ApiConfig.BASE_URL}/nguoidung/others/$maND");

      List<dynamic> value = response.data;
      return value.map((e) => NguoiDung.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> insertUser(String userName, String passwd, String email,
      String fullName, String phone, String maPB, int status) async {
    Response response = await ApiConfig.dio
        .post("${ApiConfig.BASE_URL}/nguoidung/register", data: {
      'TenNguoiDung': userName,
      'MatKhau': passwd,
      'Email': email,
      'HoTen': fullName,
      'SoDienThoai': phone,
      'MaPB': maPB,
      'TrangThai': status
    });

    return response;
  }

  Future<Response> insertUserWithImage(String userName, String passwd, String email,
      String fullName, String phone, String maPB, int status, String imageFile) async {
    final formData = FormData.fromMap({
      'TenNguoiDung': userName,
      'MatKhau': passwd,
      'Email': email,
      'HoTen': fullName,
      'SoDienThoai': phone,
      'MaPB': maPB,
      'TrangThai': status,
      'image': await MultipartFile.fromFile(imageFile)
    });

    Response response = await ApiConfig.dio.post("${ApiConfig.BASE_URL}/nguoidung/register", data: formData);

    return response;
  }

  Future<Response> updateInfo(String userName, String email, String fullName,
      String phone, String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maND = prefs.getInt("maND");

    final formData = FormData.fromMap({
      'TenNguoiDung': userName,
      'Email': email,
      'HoTen': fullName,
      'SoDienThoai': phone,
      'image': await MultipartFile.fromFile(imagePath)
    });

    Response response = await ApiConfig.dio.put(
        "${ApiConfig.BASE_URL}/nguoidung/update/$maND",
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));

    return response;
  }

  Future<Response> updateInfoNoImage(
      String userName, String email, String fullName, String phone) async {
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

  Future<Response> updateUser(
    int maND,
    String userName,
    String passWd,
    String email,
    String fullName,
    String phone,
    String maPB,
    int status,
  ) async {
    Response response = await ApiConfig.dio
        .put("${ApiConfig.BASE_URL}/nguoidung/update/$maND", data: {
      'TenNguoiDung': userName,
      'MatKhau': passWd,
      'Email': email,
      'HoTen': fullName,
      'SoDienThoai': phone,
      'MaPB': maPB,
      'TrangThai': status,
    });

    return response;
  }

  Future<Response> updateUserWithImage(
      int maND,
      String userName,
      String passWd,
      String email,
      String fullName,
      String phone,
      String maPB,
      int status,
      String imagePath) async {
    final formData = FormData.fromMap({
      'TenNguoiDung': userName,
      'MatKhau': passWd,
      'Email': email,
      'HoTen': fullName,
      'SoDienThoai': phone,
      'MaPB': maPB,
      'TrangThai': status,
      'image': await MultipartFile.fromFile(imagePath)
    });

    Response response = await ApiConfig.dio.put(
        "${ApiConfig.BASE_URL}/nguoidung/update/$maND",
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data; boundary=${formData.boundary}'}));

    return response;
  }

  Future<Response> forgotPasswd(String tenND, String matKhau) async {
    Response response = await ApiConfig.dio
        .put("${ApiConfig.BASE_URL}/nguoidung/forgot-passwd/$tenND", data: {
      'MatKhau': matKhau,
    });

    return response;
  }
}
