import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'location_service.dart';

class LocationServiceImpl implements LocationService {
  @override
  Future<String> getFormattedCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String city = placemark.locality ?? '';
        String country = placemark.country ?? '';

        if (city.isNotEmpty && country.isNotEmpty) {
          return '$city, $country';
        } else {
          return 'Unknown Location';
        }
      } else {
        return 'No address found for location';
      }
    } catch (e) {
      print('Error getting location: $e');
      rethrow;
    }
  }
}