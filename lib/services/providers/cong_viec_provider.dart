import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/config/api_config.dart';

class CongViecProvider {
  Future<List<CongViec>> getAllCongViecByMaND(String startDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maND = prefs.getInt("maND");

    try {
      Response response = await ApiConfig.dio.get(
          "${ApiConfig.BASE_URL}/congviec/search?MaND=$maND&StartDate=$startDate");

      List<dynamic> value = response.data;
      return value.map((e) => CongViec.fromJson(e)).toList();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return [CongViec.withError("Check Internet Connection")];
      }
      return [CongViec.withError(e.toString())];
    }
  }
}
