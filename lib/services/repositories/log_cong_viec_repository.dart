import 'package:todos_app/models/log_cong_viec.dart';
import 'package:todos_app/services/providers/log_cong_viec_provider.dart';

class LogCongViecRepository {
  LogCongViecProvider logCongViecProvider = LogCongViecProvider();
  Future<List<LogCongViec>> getListLogCongViec(int? maCV) {
    return logCongViecProvider.getListLogCongViec(maCV);
  }
}