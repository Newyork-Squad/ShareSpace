import 'package:share_space/domain/entity/workspace.dart';
import 'package:share_space/presentation/screen/shared/ui_state/workspace_ui_state.dart';

WorkspaceUiState mapWorkToUiState(Workspace workspace) {
  return WorkspaceUiState(
    id: workspace.id,
    name: workspace.name,
    locationName: workspace.locationName,
    longitude: workspace.longitude,
    latitude: workspace.latitude,
    rate: workspace.rate,
    pricePerHour: workspace.pricePerHour,
    imageUrls: workspace.imageUrls,
    description: workspace.description,
    rules: workspace.rules,
    ownerId: workspace.ownerId,
    services: workspace.services.map(mapToUiState).toList(),
  );
}

ServicesUiState mapToUiState(Services service) {
  switch (service) {
    case Services.wifi:
      return ServicesUiState.wifi;
    case Services.ac:
      return ServicesUiState.ac;
    case Services.whiteboard:
      return ServicesUiState.whiteboard;
    case Services.powerBackup:
      return ServicesUiState.powerBackup;
    case Services.parking:
      return ServicesUiState.parking;
    case Services.coffee:
      return ServicesUiState.coffee;
  }
}
