import 'dart:io';
import 'package:dio/dio.dart';
import 'package:login/helpers/dio_connectivity_request_retrier.dart';
import 'package:flutter/foundation.dart';
import 'package:login/helpers/session.dart';

class InterceptorClass extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;
  HelpersSession _helperSession = HelpersSession();

  InterceptorClass({
    @required this.requestRetrier,
  });

  @override
  Future onRequest(RequestOptions request) async {
    final token = await _helperSession.getToken();

    if (token != null) {
      request.headers.addAll({
        "Authorization": 'Bearer $token',
      });
    }
    request.headers['content-Type'] = 'application/json; charset=UTF-8';

    
    return request;
  }

  @override
  Future onError(DioError err) async {
    //reintenta request
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.request);
      } catch (e) {
        return e;
      }
    }
    // Let the error "pass through" if it's not the error we're looking for
    return err;
  }

//validar que en realidad sea un error de conexion
  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }
}
