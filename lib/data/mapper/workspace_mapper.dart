// Map DTO to Domain Entity
import '../../domain/entity/workspace.dart';
import '../remote/dto/WorkspaceResponse.dart';

extension WorkspaceResponseMapper on WorkspaceResponse {
  Workspace mapToEntity() {
    return Workspace(
      id: id,
      name: title,
      locationName: location,
      longitude: longitude,
      latitude: latitude,
      rate: rating ?? 0.0,
      pricePerHour: price,
      services: _mapAmenities(amenities),
      imageUrls: images ?? [],
      description: description,
      rules: houseRules ?? '',
      ownerId: 0,
    );
  }
}

// Map amenities to Services enum
List<Services> _mapAmenities(List<String> amenities) {
  List<Services> services = [];
  for (var amenity in amenities) {
    switch (amenity.toLowerCase()) {
      case 'wi_fi':
        services.add(Services.wifi);
        break;
      case 'ac':
      case 'air_conditioning':
        services.add(Services.ac);
        break;
      case 'whiteboard':
        services.add(Services.whiteboard);
        break;
      case 'coffe_machine':
        services.add(Services.coffee);
        break;
      case 'power_backup':
      case 'powerbackup':
        services.add(Services.powerBackup);
        break;
    }
  }
  return services;
}
