import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_header_section.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_image_slider.dart';

import '../../../design_system/theme/app_theme.dart';
import 'owner_section.dart';

class RoomDetailsBody extends StatelessWidget {
  RoomDetailsBody({super.key});

  final List<String> roomImages = const [
    'assets/images/room_image.png',
    'assets/images/room_image.png',
    'assets/images/room_image.png',
    'assets/images/room_image.png',
  ];
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  final String roomName = 'Modern study room';
  final String location = 'Baghdad, Iraq';
  final List<Service> services = [
    Service(name: 'WiFi', imagePath: 'assets/icons/wifi.svg'),
    Service(name: 'whiteboard', imagePath: 'assets/icons/whiteboard.svg'),
    Service(name: 'power backup', imagePath: 'assets/icons/power_backup.svg'),
    Service(name: 'A/C', imagePath: 'assets/icons/ac.svg'),
  ];

  final String ownerName = 'Ali Kareem Mohammed';
  final String ownerRole = 'Owner';
  final String ownerImagePath = 'assets/images/owner.png';
  final String roomDescription = '''
A modern study room equipped with everything you need for an ideal study experience.
It features comfortable desks, optimal lighting, fully air-conditioned rooms, fast Wi-Fi, and a smart writing tablet for jotting down notes and ideas.
The calming atmosphere helps you focus and accomplish your goals, whether you're studying alone or in a group.
The location is close to public facilities, with easy access and convenient parking.
The room can be booked by the hour, with the option to extend the time directly through the app. A modern study room equipped with everything you need for an ideal study experience.
It features comfortable desks, optimal lighting, fully air-conditioned rooms, fast Wi-Fi, and a smart writing tablet for jotting down notes and ideas.
The calming atmosphere helps you focus and accomplish your goals, whether you're studying alone or in a group.
The location is close to public facilities, with easy access and convenient parking.
The room can be booked by the hour, with the option to extend the time directly through the app.
''';

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final theme = AppTheme.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: RoomImageSlider(
                  images: roomImages,
                  currentIndex: _currentIndex,
                  controller: pageController,
                  rate: '5',
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 240,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoomHeaderSection(
                  title: roomName,
                  location: location,
                  services: services,
                ),

                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: const Color(0x1F1F1F14),
                ),

                RoomOwnerSection(
                  name: ownerName,
                  role: ownerRole,
                  imagePath: ownerImagePath,
                ),

                Container(
                  width: double.infinity,
                  height: 0.5,
                  color: const Color(0x1F1F1F14),
                ),

                Padding(
                  padding:  EdgeInsets.only(
                    top: 12,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).padding.bottom,
                    ),
                  child: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      physics:  BouncingScrollPhysics(),
                      child: Text(
                        roomDescription,
                        style: theme.typography.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: theme.colors.body,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
