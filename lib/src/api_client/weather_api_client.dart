import 'package:dio/dio.dart';

abstract class WeatherApiClient {

  Future<Response<T>> get<T>(
    String url, {
    Object? body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  });

  void cancelRequest();
}