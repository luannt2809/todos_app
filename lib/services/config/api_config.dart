import 'package:dio/dio.dart';

class ApiConfig {
  static Dio dio = Dio();
  static const BASE_URL = "http://192.168.1.19:3000/api";
}