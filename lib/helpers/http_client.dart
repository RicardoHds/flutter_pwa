import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:login/helpers/interceptor.dart';
import 'package:login/helpers/dio_connectivity_request_retrier.dart';

class HttpClient {
  Dio _dio;

  HttpClient() {
    _dio = Dio();
    _dio.interceptors.add(InterceptorClass(
        requestRetrier: DioConnectivityRequestRetrier(
            dio: Dio(), connectivity: Connectivity())));
  }

  Future<Response> get(String url) => _dio.get(url);
  Future<Response> post(String url, {dynamic body}) =>
      _dio.post(url, data: body);
  Future<Response> put(String url, {dynamic body}) => _dio.put(url, data: body);
  Future<Response> delete(String url, {dynamic body}) => _dio.delete(url);
}
