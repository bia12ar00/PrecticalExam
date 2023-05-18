import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = "https://test-otp-api.7474224.xyz";
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}
