import 'package:get_it/get_it.dart';

import '../api_client/weather_api_client.dart';
import '../api_client/weather_api_client_impl.dart';
import '../data/remote_source/weather_remote_source.dart';
import '../data/remote_source/weather_remote_source_impl.dart';
import '../data/repository/weather_repository.dart';
import '../data/repository/weather_repository_impl.dart';
import '../domain/usecase/weather_usecase.dart';
import '../domain/usecase/weather_usecase_impl.dart';

final injector = GetIt.I;

Future<void> setupDI() async {
  
  injector.registerLazySingleton<WeatherApiClient>(
    () => WeatherApiClientImpl()
  );

  injector.registerLazySingleton<WeatherRemoteSource>(
    () => WeatherRemoteSourceImpl(client: injector())
  );

  injector.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteSource: injector())
  );

  injector.registerLazySingleton<WeatherUseCase>(
    () => WeatherUseCaseImpl(repository: injector())
  );
}