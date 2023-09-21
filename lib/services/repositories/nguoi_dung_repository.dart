import 'package:dio/dio.dart';
import 'package:todos_app/models/nguoi_dung.dart';
import 'package:todos_app/services/providers/nguoi_dung_provider.dart';

class NguoiDungRepository {
  final NguoiDungProvider nguoiDungProvider = NguoiDungProvider();

  Future<List<NguoiDung>> getInfoUser() {
    return nguoiDungProvider.getInfoUser();
  }

  Future<Response> updateUser(String userName,
      String email,
      String fullName,
      String phone) {
    return nguoiDungProvider.updateInfo(
        userName,
        email,
        fullName,
        phone);
  }
}