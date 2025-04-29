
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_weather/src/common/int_ext.dart';

import '../../domain/entities/weather_entity.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {

  const factory WeatherModel({
    required double temperature,
    @JsonKey(name: 'weathercode') required int weatherCode
  }) = _WeatherModel; 
  
  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
}

extension WeatherModelX on WeatherModel {

  WeatherEntity toEntity() {
    return WeatherEntity(
      temperature: temperature, 
      condition: weatherCode.toCondition, 
      label: weatherCode.toSpecificLabel
    );
  }
}