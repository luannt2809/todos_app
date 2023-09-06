import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/CongViec.dart';

class ApiCongViec {

  static Dio dio = Dio();

  static const String _baseUrl = "http://192.168.1.23:3000/api/congviec";

  static Future<List<CongViec>> getAllCongViecByMaND() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? maND = prefs.getInt("maND");
    var response = await dio.get("$_baseUrl/list/$maND");

    final List<dynamic> responseData = response.data;
    List<CongViec> listCV = responseData.map((json) => CongViec.fromJson(json)).toList();

    return listCV;
  }

}