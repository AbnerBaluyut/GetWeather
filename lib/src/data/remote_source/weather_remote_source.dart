import 'package:fpdart/fpdart.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteSource {

  TaskEither<String, WeatherModel> getWeather(body);
  void cancel();
}