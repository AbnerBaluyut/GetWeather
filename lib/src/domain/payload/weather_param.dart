class WeatherParams {

  final double latitude;
  final double longitude;
  final bool isCurrentWeather;

  WeatherParams({
    required this.latitude,
    required this.longitude,
    this.isCurrentWeather = false
  });

  
  toJson() => {
    'latitude': '$latitude',
    'longitude': '$longitude',
    'current_weather': isCurrentWeather,
  };
}