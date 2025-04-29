import 'package:fpdart/fpdart.dart';
import 'package:get_weather/src/data/models/weather_model.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/payload/weather_param.dart';
import '../remote_source/weather_remote_source.dart';
import 'weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {

  final WeatherRemoteSource remoteSource;

  WeatherRepositoryImpl({
    required this.remoteSource
  }); 

  @override
  TaskEither<String, WeatherEntity> getWeather({required WeatherParams params}) {
    final result = remoteSource.getWeather(params.toJson());
    return result.map((model) => model.toEntity());
  }
}