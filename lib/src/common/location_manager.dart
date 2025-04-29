import 'package:geolocator/geolocator.dart';

import 'enums/location_status.dart';
import 'location_result.dart';

class LocationManager {

  Future<LocationResult> getCurrentLocation() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return LocationResult(status: LocationStatus.serviceDisabled);
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return LocationResult(status: LocationStatus.permissionDenied);
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationResult(status: LocationStatus.permissionDeniedForever);
    }

    try {
      LocationSettings locationSettings = const LocationSettings(accuracy: LocationAccuracy.high);
      final position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      return LocationResult(status: LocationStatus.success, position: position);
    } catch (e) {
      return LocationResult(status: LocationStatus.error);
    }
  }

}