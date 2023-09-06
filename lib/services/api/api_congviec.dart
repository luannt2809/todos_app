import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/CongViec.dart';
import 'package:todos_app/services/api/apiConfig.dart';

class ApiCongViec {

  static Dio dio = Dio();

  static Future<List<CongViec>>? getAllCongViecByMaND() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? maND = prefs.getInt("maND");
    var response = await dio.get("${ApiConfig.BASE_URL}/congviec/list/$maND");

    final List<dynamic> responseData = response.data;
    List<CongViec> listCV = responseData.map((json) => CongViec.fromJson(json)).toList();

    return listCV;
  }

}