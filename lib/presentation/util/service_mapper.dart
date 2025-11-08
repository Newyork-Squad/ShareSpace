import 'package:share_space/domain/entity/workspace.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_header_section.dart';

import 'get_service_icon_path.dart';

const _fallbackServiceIcon = 'assets/icons/wifi.svg';

List<Service> mapServicesToPresentation(List<Services> services) {
  return services
      .map((service) {
        final label = serviceLabel(service);
        final iconPath = getServiceIconPath(label);
        return Service(
          name: label,
          imagePath: iconPath.isNotEmpty ? iconPath : _fallbackServiceIcon,
        );
      })
      .toList();
}

String serviceLabel(Services service) {
  switch (service) {
    case Services.wifi:
      return 'WiFi';
    case Services.ac:
      return 'A/C';
    case Services.whiteboard:
      return 'Whiteboard';
    case Services.powerBackup:
      return 'Power Backup';
  }
}

