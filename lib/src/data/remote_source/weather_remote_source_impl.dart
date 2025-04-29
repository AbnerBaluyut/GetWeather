import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../api_client/weather_api_client.dart';
import '../models/weather_model.dart';
import 'weather_remote_source.dart';

class WeatherRemoteSourceImpl implements WeatherRemoteSource {

  final WeatherApiClient client;

  WeatherRemoteSourceImpl({
    required this.client
  });
  
  @override
  TaskEither<String, WeatherModel> getWeather(body) {
    
    return TaskEither.tryCatch(() async {

      final response = await client.get(
        "v1/forecast",
        queryParameters: body
      );

      return WeatherModel.fromJson(response.data?['current_weather']);

    }, (err, _) {
      if (err is DioException) {
        return err.error.toString();
      }
      return "An error occurred. Please try again.";
    });
  } 
}