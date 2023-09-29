import 'package:dio/dio.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/services/config/api_config.dart';

class PhongBanProvider {
  Future<List<PhongBan>> getListDepartment() async {
    Response response =
        await ApiConfig.dio.get("${ApiConfig.BASE_URL}/phongban/list");

    List<dynamic> value = response.data;
    return value.map((e) => PhongBan.fromJson(e)).toList();
  }

  Future<Response> addDepartment(String tenPB, String arrMaVT) async {
    Response response = await ApiConfig.dio.post(
        "${ApiConfig.BASE_URL}/phongban/insert",
        data: {'TenPhongBan': tenPB, 'ArrMaVT': arrMaVT});
    return response;
  }

  Future<Response> updateDepartment(
      int maPB, String tenPB, String arrMaVT) async {
    Response response = await ApiConfig.dio.put(
        "${ApiConfig.BASE_URL}/phongban/update/$maPB",
        data: {'TenPhongBan': tenPB, 'ArrMaVT': arrMaVT});
    return response;
  }
}
