import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/services/providers/phong_ban_provider.dart';

class PhongBanRepository {
  PhongBanProvider phongBanProvider = PhongBanProvider();

  Future<List<PhongBan>> getListDepartment() {
    return phongBanProvider.getListDepartment();
  }
}