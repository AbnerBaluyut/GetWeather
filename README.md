# Weather App

This Flutter app allows users to fetch weather information based on their location or by providing latitude and longitude coordinates.

## Features

- **Weather Service**: Fetch weather data using a weather API.
- **Location Service**: Get the user's current location using GPS.
- **Dependency Injection**: Setup dependencies with `WeatherService` class.

## Setup & Initialization

Before using the `WeatherService` class, you must initialize it to set up the required dependencies.

### 1. Initialize `WeatherService`

In your `main.dart`, call `WeatherService.initialize()` to set up the dependency injection (DI) and make sure all services are ready to use before the app starts.

#### Example: `main.dart`

```dart
import 'package:flutter/material.dart';
import 'weather_service.dart'; // Import your WeatherService class

void main() async {
  // Ensure Flutter is initialized before setting up WeatherService
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize WeatherService (sets up DI and dependencies)
  await WeatherService.initialize();

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _weatherInfo = 'Fetching weather...';

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  // Function to fetch weather based on latitude and longitude
  Future<void> _getWeather() async {
    // Example coordinates (latitude, longitude)
    double latitude = 37.7749;
    double longitude = -122.4194;

    // Fetch weather data using WeatherService
    final result = await WeatherService().getWeather(latitude: latitude, longitude: longitude);
    result.fold(
      (error) {
        setState(() {
          _weatherInfo = 'Error: $error';
        });
      },
      (weatherEntity) {
        setState(() {
          _weatherInfo = 'Weather: ${weatherEntity.description}';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: Text(_weatherInfo),
      ),
    );
  }
}