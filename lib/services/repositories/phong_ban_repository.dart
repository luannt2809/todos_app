import 'package:dio/dio.dart';
import 'package:todos_app/models/phong_ban.dart';
import 'package:todos_app/services/providers/phong_ban_provider.dart';

class PhongBanRepository {
  PhongBanProvider phongBanProvider = PhongBanProvider();

  Future<List<PhongBan>> getListDepartment() {
    return phongBanProvider.getListDepartment();
  }

  Future<Response> addDepartment(String tenPB) async {
    return phongBanProvider.addDepartment(tenPB);
  }

  Future<Response> updateDepartment(int maPB, String tenPB) async {
    return phongBanProvider.updateDepartment(maPB, tenPB);
  }
}