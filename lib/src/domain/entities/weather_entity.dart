

import '../../common/weather_condition_enum.dart';

class WeatherEntity {

  final double temperature;
  final WeatherConditionEnum condition;
  final String label;

  WeatherEntity({
    required this.temperature,
    required this.condition,
    required this.label
  });
}