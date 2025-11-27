import 'package:flutter/material.dart';

import '../../util/get_service_icon_path.dart';
import 'custom_chip.dart';

class AmenitiesRow extends StatelessWidget {
  final List<String> amenities;

  const AmenitiesRow({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: 4.0,
      runSpacing: 4.0,
      children: amenities.map((amenity) {
        return CustomChip(label: amenity, icon: getServiceIconPath(amenity));
      }).toList(),
    );
  }
}
