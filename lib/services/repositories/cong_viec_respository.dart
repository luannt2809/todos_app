import 'package:dio/dio.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/providers/cong_viec_provider.dart';

class CongViecRepository {
  final CongViecProvider congViecProvider = CongViecProvider();

  // get list task
  Future<List<CongViec>> getAllCongViecByMaND(String startDate) {
    return congViecProvider.getAllCongViecByMaND(startDate);
  }

  // add task
  Future<Response> addTask(
      String tieuDe,
      String noiDung,
      String ngayBD,
      String ngayKT,
      String gioBD,
      String gioKT,
      String trangThai,
      String tienDo,
      String ghiChu) async {
    return congViecProvider.addTask(tieuDe, noiDung, ngayBD, ngayKT, gioBD,
        gioKT, trangThai, tienDo, ghiChu);
  }

  Future<Response> adminAddTask(
      String tieuDe,
      String noiDung,
      String ngayBD,
      String ngayKT,
      String gioBD,
      String gioKT,
      String trangThai,
      String tienDo,
      String ghiChu,
      int maNguoiLam) async {
    return congViecProvider.adminAddTask(tieuDe, noiDung, ngayBD, ngayKT, gioBD,
        gioKT, trangThai, tienDo, ghiChu, maNguoiLam);
  }

  // update task
  Future<Response> updateTask(
      int maCV,
      String tieuDe,
      String noiDung,
      String ngayBD,
      String ngayKT,
      String gioBD,
      String gioKT,
      String trangThai,
      String tienDo,
      String ghiChu) async {
    return congViecProvider.updateTask(maCV, tieuDe, noiDung, ngayBD, ngayKT,
        gioBD, gioKT, trangThai, tienDo, ghiChu);
  }

  // delete task
  Future<Response> deleteTask(int maCV) {
    return congViecProvider.deleteTask(maCV);
  }
}

class NetworkError extends Error {}
