

import '../../common/enums/weather_condition.dart';

class WeatherEntity {

  final double temperature;
  final WeatherCondition condition;
  final String label;

  WeatherEntity({
    required this.temperature,
    required this.condition,
    required this.label
  });
}