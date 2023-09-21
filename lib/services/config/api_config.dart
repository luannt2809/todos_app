import 'package:dio/dio.dart';

class ApiConfig {
  static Dio dio = Dio();
  static const BASE_URL = "http://192.168.11.109:3000/api";
}