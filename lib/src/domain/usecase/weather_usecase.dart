import 'package:fpdart/fpdart.dart';

import '../entities/weather_entity.dart';

abstract class WeatherUseCase {

  TaskEither<String, WeatherEntity> execute({required double latitude, required double longitude,});
}