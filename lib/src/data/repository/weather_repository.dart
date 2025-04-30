import 'package:fpdart/fpdart.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/payload/weather_param.dart';

abstract class WeatherRepository {

  TaskEither<String, WeatherEntity> getWeather({required WeatherParams params});
  void cancel();
}