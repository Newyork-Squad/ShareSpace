import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_space/presentation/screen/room_details/widgets/service_item.dart';

import '../../../design_system/theme/app_theme.dart';

class RoomHeaderSection extends StatelessWidget {
  final String title;
  final String location;
  final List<Service> services;

  const RoomHeaderSection({
    super.key,
    required this.title,
    required this.location,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.typography.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color:theme.colors.title,
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/location.svg',
                width: 16,
                height: 16,
                color: theme.colors.secondary,
              ),
              Text(
                location,
                style: theme.typography.textTheme.labelSmall?.copyWith(
                  color: theme.colors.body,
                  fontWeight: FontWeight.w400,
                ) ,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Services label
        Text(
            "Services",
             style: theme.typography.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colors.title,
            ),
          ),
          const SizedBox(height: 8),

          // Dynamic Services List
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: services.map((service) {
              return ServiceItem(
                name: service.name,
                imagePath: service.imagePath,
              );
            }).toList(),
          ),
        ],
      )
    );
  }
}

class Service {
  final String name;
  final String imagePath;

  Service({required this.name, required this.imagePath});
}
