import 'package:dio/dio.dart';
import 'package:todos_app/models/nguoi_dung.dart';

import 'package:todos_app/services/providers/nguoi_dung_provider.dart';

class NguoiDungRepository {
  final NguoiDungProvider nguoiDungProvider = NguoiDungProvider();

  Future<List<NguoiDung>> getListUser() {
    return nguoiDungProvider.getListUser();
  }

  Future<List<NguoiDung>> getInfoUser() {
    return nguoiDungProvider.getInfoUser();
  }

  Future<List<NguoiDung>> getListOthers() {
    return nguoiDungProvider.getListOthers();
  }

  Future<Response> insertUser(String userName, String passwd, String email,
      String fullName, String phone, String maPB, int status) async {
    return nguoiDungProvider.insertUser(
        userName, passwd, email, fullName, phone, maPB, status);
  }

  Future<Response> insertUserWithImage(String userName, String passwd, String email,
      String fullName, String phone, String maPB, int status, String anh) async {
    return nguoiDungProvider.insertUserWithImage(userName, passwd, email, fullName, phone, maPB, status, anh);
  }

  Future<Response> updateInfo(
      String userName, String email, String fullName, String phone, String anh) {
    return nguoiDungProvider.updateInfo(userName, email, fullName, phone, anh);
  }

  Future<Response> updateInfoNoImage(String userName, String email, String fullName, String phone){
    return nguoiDungProvider.updateInfoNoImage(userName, email, fullName, phone);
  }

  Future<Response> updateUser(
    int maND,
    String userName,
    String passWd,
    String email,
    String fullName,
    String phone,
    String maPB,
    int status,
  ) {
    return nguoiDungProvider.updateUser(
        maND, userName, passWd, email, fullName, phone, maPB, status);
  }

  Future<Response> updateUserWithImage(int maND,
      String userName,
      String passWd,
      String email,
      String fullName,
      String phone,
      String maPB,
      int status, String anh) {
    return nguoiDungProvider.updateUserWithImage(maND, userName, passWd, email, fullName, phone, maPB, status, anh);
  }

  Future<Response> forgotPasswd(String tenND, String matKhau) async {
    return nguoiDungProvider.forgotPasswd(tenND, matKhau);
  }
}
