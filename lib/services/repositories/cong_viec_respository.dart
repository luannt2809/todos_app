import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/providers/cong_viec_provider.dart';

class CongViecRepository {
  final CongViecProvider congViecProvider = CongViecProvider();

  Future<List<CongViec>> getAllCongViecByMaND(String startDate) {
    return congViecProvider.getAllCongViecByMaND(startDate);
  }
}

class NetworkError extends Error {}