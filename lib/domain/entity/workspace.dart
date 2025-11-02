
import 'dart:ffi';

class Workspace {
  final Long id;
  final String name;
  final String locationName;
  final double longitude;
  final double latitude;
  final double rate;
  final double pricePerHour;
  final List<Services> services;
  final List<String> imageUrl;
  final String description;
  final String rules;
  final Long ownerId;

  Workspace({
    required this.id,
    required this.name,
    required this.locationName,
    required this.longitude,
    required this.latitude,
    required this.rate,
    required this.pricePerHour,
    required this.services,
    required this.imageUrl,
    required this.description,
    required this.rules,
    required this.ownerId,
  });
}


enum Services {
  wifi,
  ac,
  whiteboard,
  powerBackup
}