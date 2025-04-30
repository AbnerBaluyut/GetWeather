
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'api_client/weather_api_client.dart';
import 'api_client/weather_api_client_impl.dart';
import 'common/location_manager.dart';
import 'common/location_result.dart';
import 'data/remote_source/weather_remote_source.dart';
import 'data/remote_source/weather_remote_source_impl.dart';
import 'data/repository/weather_repository.dart';
import 'data/repository/weather_repository_impl.dart';
import 'domain/entities/weather_entity.dart';
import 'domain/usecase/weather_usecase.dart';
import 'domain/usecase/weather_usecase_impl.dart';

part '_di/dependencies.dart';

class WeatherService {

  static final WeatherService _instance = WeatherService._internal();

  factory WeatherService() => _instance;

  WeatherService._internal();

  // Initialize dependecies
  static Future<void> initialize() async => _setupDI();

  // Injected dependencies
  WeatherUseCase get _weatherUseCase => _injector();
  LocationManager get _locationManager => _injector();

  // Function to get current location
  Future<LocationResult> getCurrentLocation() => _locationManager.getCurrentLocation();

  // Function to get current weather based on latitude and longitude
  TaskEither<String, WeatherEntity> getWeather({
    required double latitude, 
    required double longitude
  }) => _weatherUseCase.execute(latitude: latitude, longitude: longitude);

  void cancel() => _weatherUseCase.cancel();
}