import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/thong_bao.dart';
import 'package:todos_app/services/config/api_config.dart';

class ThongBaoProvider {
  Future<List<ThongBao>> getListThongBao() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maND = prefs.getInt("maND");

    Response response = await ApiConfig.dio.get
      ("${ApiConfig.BASE_URL}/thongbao/list/$maND");

    List<dynamic> value = response.data;
    return value.map((e) => ThongBao.fromJson(e)).toList();
  }
}