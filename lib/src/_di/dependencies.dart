part of '/src/weather_service.dart';

final _injector = GetIt.I;

Future<void> _setupDI() async {

  _injector.registerSingleton<LocationManager>(
    LocationManager()
  );
  
  _injector.registerLazySingleton<WeatherApiClient>(
    () => WeatherApiClientImpl()
  );

  _injector.registerLazySingleton<WeatherRemoteSource>(
    () => WeatherRemoteSourceImpl(client: _injector())
  );

  _injector.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteSource: _injector())
  );

  _injector.registerLazySingleton<WeatherUseCase>(
    () => WeatherUseCaseImpl(repository: _injector())
  );
}