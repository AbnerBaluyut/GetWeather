import 'package:geolocator/geolocator.dart';

import 'enums/location_status.dart';

class LocationResult {
  final LocationStatus status;
  final Position? position;

  LocationResult({required this.status, this.position});
}