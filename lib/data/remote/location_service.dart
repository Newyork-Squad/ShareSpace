import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

abstract class LocationService {
  Future<String> getFormattedCurrentLocation();
}