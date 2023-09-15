import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/config/api_config.dart';

class ApiCongViec {

  static Future<List<CongViec>>? getAllCongViecByMaND(String startDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? maND = prefs.getInt("maND");
    var response = await ApiConfig.dio.get(
        "${ApiConfig.BASE_URL}/congviec/search?MaND=$maND&StartDate=$startDate");

    final List<dynamic> responseData = response.data;
    List<CongViec> listCV =
        responseData.map((json) => CongViec.fromJson(json)).toList();

    return listCV;
  }

  // static Future<List<CongViec>> getCongViecByMaCV(int maCV) async {
  //   Response response = await ApiConfig.dio.get("${ApiConfig.BASE_URL}/congviec/${maCV}");
  //
  //   final List<dynamic> responseData = response.data;
  //   List<CongViec> congViec = [];
  //   if (response.statusCode == 200) {
  //     congViec = responseData.map((json) => CongViec.fromJson(json)).toList();
  //   } else {
  //     print("Yêu cầu không thành công: ${response.statusCode}");
  //   }
  //   print(congViec);
  //   return congViec;
  // }
}
