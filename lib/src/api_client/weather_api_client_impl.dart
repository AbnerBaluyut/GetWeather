import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'errors/network_exception.dart';
import 'errors/not_found_exception.dart';
import 'errors/server_exception.dart';
import 'errors/time_out_exception.dart';
import 'errors/unauthorized_exception.dart';
import 'errors/unknown_exception.dart';
import 'weather_api_client.dart';

class WeatherApiClientImpl implements WeatherApiClient {

  final Dio _dio;
  CancelToken? _cancelToken;
  

  static const _baseUrlWeather = 'https://api.open-meteo.com/';

  WeatherApiClientImpl() : _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrlWeather,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ),
  ) {
    _cancelToken = CancelToken();
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
          error: true,
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle the response here if needed
          return handler.next(response);
        },
        onError: (e, handler) async {
          if (e.type == DioExceptionType.cancel) return;
          return handler.reject(_mapError(e));
        },
      ),
    );
  }

  DioException _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout) {
      return DioException(requestOptions: e.requestOptions, error: TimeoutException());
    }

    if (e.type == DioExceptionType.badResponse) {
      
      final code = e.response?.statusCode ?? 0;
      final data = e.response?.data;

      switch (code) {
        case 400:
          return DioException(requestOptions: e.requestOptions, error: ServerException(data?['message'] ?? "Bad Request", code: code));
        case 401:
          return DioException(requestOptions: e.requestOptions, error: UnauthorizedException(data?['messages']?["message"] ?? data?['message'] ?? "Unauthorized", code: code));
        case 404:
          return DioException(requestOptions: e.requestOptions, error: NotFoundException());
        default:
          return DioException(requestOptions: e.requestOptions, error: ServerException("An error occurred. Please try again.", code: code));
      }
    }

    if (e.type == DioExceptionType.unknown) {
      return DioException(requestOptions: e.requestOptions, error: NetworkException("No Internet Connection"));
    }

    return DioException(requestOptions: e.requestOptions, error: UnknownException("An error occurred. Please try again."));
  }

  @override
  Future<Response<T>> get<T>(
    String url, 
    {
      Object? body, 
      Map<String, dynamic>? queryParameters, 
      Options? options, 
      ProgressCallback? onReceiveProgress
    }
  ) {
    cancelRequest();
    return _dio.get(
      url, 
      data: body,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress
    );
  }

  @override
  void cancelRequest() {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
  }
}