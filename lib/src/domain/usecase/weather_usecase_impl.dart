import 'package:fpdart/fpdart.dart';

import '../../data/repository/weather_repository.dart';
import '../entities/weather_entity.dart';
import '../payload/weather_param.dart';
import 'weather_usecase.dart';

class WeatherUseCaseImpl implements WeatherUseCase {

  final WeatherRepository repository;

  WeatherUseCaseImpl({
    required this.repository
  });

  @override
  TaskEither<String, WeatherEntity> execute({required double latitude, required double longitude,}) {
    final params = WeatherParams(
      latitude: latitude,
      longitude: longitude,
      isCurrentWeather: true
    );
    return repository.getWeather(params: params);
  }
}