
import '../enums/weather_condition.dart';

extension IntExt on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
        return WeatherCondition.cloudy;
      case 45:
      case 48:
        return WeatherCondition.foggy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
        return WeatherCondition.rainy;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy;
      case 95:
      case 96:
      case 99:
        return WeatherCondition.thunderstorm;
      default:
        return WeatherCondition.unknown;
    }
  }

  String get toSpecificLabel {
    switch (this) {
      case 0: return "Clear sky";
      case 1: return "Mainly clear";
      case 2: return "Partly cloudy";
      case 3: return "Overcast";
      case 45: return "Fog";
      case 48: return "Rime fog";
      case 51: return "Light drizzle";
      case 53: return "Moderate drizzle";
      case 55: return "Dense drizzle";
      case 56: return "Light freezing drizzle";
      case 57: return "Heavy freezing drizzle";
      case 61: return "Light rain";
      case 63: return "Moderate rain";
      case 65: return "Heavy rain";
      case 66: return "Light freezing rain";
      case 67: return "Heavy freezing rain";
      case 71: return "Light snowfall";
      case 73: return "Moderate snowfall";
      case 75: return "Heavy snowfall";
      case 77: return "Snow grains";
      case 80: return "Light rain showers";
      case 81: return "Moderate rain showers";
      case 82: return "Violent rain showers";
      case 85: return "Light snow showers";
      case 86: return "Heavy snow showers";
      case 95: return "Thunderstorm";
      case 96: return "Thunderstorm with light hail";
      case 99: return "Thunderstorm with heavy hail";
      default: return "Unknown weather";
    }
  }
}