import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_app/models/cong_viec.dart';
import 'package:todos_app/services/config/api_config.dart';

class CongViecProvider {
  // get list task
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

  // Future<List<CongViec>> getAllCongViecByMaND(String startDate, String inputTime) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final int? maND = prefs.getInt("maND");
  //
  //   try {
  //     Response response = await ApiConfig.dio.get(
  //         "${ApiConfig.BASE_URL}/congviec/search?MaND=$maND&StartDate=$startDate&InputTime=$inputTime");
  //
  //     List<dynamic> value = response.data;
  //     return value.map((e) => CongViec.fromJson(e)).toList();
  //   } catch (e) {
  //     if (e.toString().contains("SocketException")) {
  //       return [CongViec.withError("Check Internet Connection")];
  //     }
  //     return [CongViec.withError(e.toString())];
  //   }
  // }

  // lấy danh sách công việc theo mã người dùng (mã người làm) và status của công việc
  Future<List<CongViec>> getAllTaskWithStatus(String trangThai) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maND = prefs.getInt("maND");

    try {
      Response response = await ApiConfig.dio.get(
          "${ApiConfig.BASE_URL}/congviec/list-task-status?MaNguoiLam=$maND&TrangThai=$trangThai");

      List<dynamic> value = response.data;
      return value.map((e) => CongViec.fromJson(e)).toList();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return [CongViec.withError("Check Internet Connection")];
      }
      return [CongViec.withError(e.toString())];
    }
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maNguoiLam = prefs.getInt("maND");

    Response response = await ApiConfig.dio
        .post("${ApiConfig.BASE_URL}/congviec/insert", data: {
      'TieuDe': tieuDe,
      'NoiDung': noiDung,
      'GioBatDau': gioBD,
      'GioKetThuc': gioKT,
      'NgayBatDau': ngayBD,
      'NgayKetThuc': ngayKT,
      'TrangThai': trangThai,
      'TienDo': tienDo,
      'GhiChu': ghiChu,
      'MaNguoiLam': maNguoiLam
    });

    return response;
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
      int maNguoiLam,
      int? maNguoiGiao,
      int? kieu) async {

    Response response = await ApiConfig.dio
        .post("${ApiConfig.BASE_URL}/congviec/insert", data: {
      'TieuDe': tieuDe,
      'NoiDung': noiDung,
      'GioBatDau': gioBD,
      'GioKetThuc': gioKT,
      'NgayBatDau': ngayBD,
      'NgayKetThuc': ngayKT,
      'TrangThai': trangThai,
      'TienDo': tienDo,
      'GhiChu': ghiChu,
      'MaNguoiGiao': maNguoiGiao,
      'MaNguoiLam': maNguoiLam,
      'Kieu': kieu
    });

    return response;
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
      String ghiChu,
      int maNguoiLam) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final int? maNguoiLam = prefs.getInt("maND");

    Response response = await ApiConfig.dio
        .put("${ApiConfig.BASE_URL}/congviec/update/$maCV", data: {
      'TieuDe': tieuDe,
      'NoiDung': noiDung,
      'GioBatDau': gioBD,
      'GioKetThuc': gioKT,
      'NgayBatDau': ngayBD,
      'NgayKetThuc': ngayKT,
      'TrangThai': trangThai,
      'TienDo': tienDo,
      'GhiChu': ghiChu,
      'MaNguoiLam': maNguoiLam
    });

    return response;
  }

  Future<Response> adminUpdateTask(
      int maCV,
      String tieuDe,
      String noiDung,
      String ngayBD,
      String ngayKT,
      String gioBD,
      String gioKT,
      String trangThai,
      String tienDo,
      String ghiChu,
      int maNguoiLam,
      int? maNguoiGiao,
      int? kieu) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final int? maNguoiGiao = prefs.getInt("maND");

    Response response = await ApiConfig.dio
        .put("${ApiConfig.BASE_URL}/congviec/update/$maCV", data: {
      'TieuDe': tieuDe,
      'NoiDung': noiDung,
      'GioBatDau': gioBD,
      'GioKetThuc': gioKT,
      'NgayBatDau': ngayBD,
      'NgayKetThuc': ngayKT,
      'TrangThai': trangThai,
      'TienDo': tienDo,
      'GhiChu': ghiChu,
      'MaNguoiGiao': maNguoiGiao,
      'MaNguoiLam': maNguoiLam
    });

    return response;
  }

  // delete task
  Future<Response> deleteTask(int maCV) async {
    Response response = await ApiConfig.dio
        .delete("${ApiConfig.BASE_URL}/congviec/delete/$maCV");

    return response;
  }

  Future<List<CongViec>> getAllTaskAssigned(String trangThai) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? maND = prefs.getInt("maND");

    try {
      Response response = await ApiConfig.dio.get(
          "${ApiConfig.BASE_URL}/congviec/list-task-assigned",
          queryParameters: {
            'MaNguoiGiao': maND,
            'TrangThai': trangThai
          });

      List<dynamic> value = response.data;
      return value.map((e) => CongViec.fromJson(e)).toList();
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        return [CongViec.withError("Check Internet Connection")];
      }
      return [CongViec.withError(e.toString())];
    }
  }

  Future<List<CongViec>> getAllTransferTask(int? maCV) async {
    try {
      Response response = await ApiConfig.dio
          .get("${ApiConfig.BASE_URL}/congviec/list-task-transfer/$maCV");

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
