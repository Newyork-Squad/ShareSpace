
class WorkspaceUiState {
  final String id;
  final String name;
  final String locationName;
  final double longitude;
  final double latitude;
  final double rate;
  final double pricePerHour;
  final List<ServicesUiState> services;
  final List<String> imageUrls;
  final String description;
  final String rules;
  final int ownerId;

  WorkspaceUiState({
    required this.id,
    required this.name,
    required this.locationName,
    required this.longitude,
    required this.latitude,
    required this.rate,
    required this.pricePerHour,
    required this.services,
    required this.imageUrls,
    required this.description,
    required this.rules,
    required this.ownerId,
  });
}


enum ServicesUiState {
  wifi,
  ac,
  whiteboard,
  powerBackup,
  parking,
  coffee;

  @override
  String toString() {
    switch (this) {
      case ServicesUiState.wifi:
        return 'WiFi';
      case ServicesUiState.ac:
        return 'A/C';
      case ServicesUiState.whiteboard:
        return 'Whiteboard';
      case ServicesUiState.powerBackup:
        return 'Power Backup';
      case ServicesUiState.parking:
        return 'Parking';
      case ServicesUiState.coffee:
        return 'Coffee';
    }
  }
}