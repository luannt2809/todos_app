import 'package:dio/dio.dart';
import 'package:todos_app/models/log_cong_viec.dart';
import 'package:todos_app/services/config/api_config.dart';

class LogCongViecProvider {
  Future<List<LogCongViec>> getListLogCongViec (int? maCV) async {
    try {
      Response response = await ApiConfig.dio.get("${ApiConfig.BASE_URL}/logcongviec/$maCV");

      List<dynamic> value = response.data;

      return value.map((e) => LogCongViec.fromJson(e)).toList();
    } catch (e) {
      if(e.toString().contains("SocketException")) {
        return [LogCongViec.withError("Check Internet Connection")];
      }
      return [LogCongViec.withError(e.toString())];
    }
  }
}