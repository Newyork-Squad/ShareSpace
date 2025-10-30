import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_header_section.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_image_slider.dart';

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
    Service(name: 'WiFi',imagePath: 'assets/icons/wifi.svg'),
    Service(name: 'whiteboard',imagePath: 'assets/icons/whiteboard.svg'),
    Service(name: 'power backup',imagePath: 'assets/icons/power_backup.svg'),
    Service(name: 'A/C',imagePath: 'assets/icons/ac.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: RoomImageSlider(
            images: roomImages,
            currentIndex: _currentIndex,
            controller: pageController,
            rate: '5',
          ),
        ),
        SliverToBoxAdapter(
          child: RoomHeaderSection(
            title: roomName,
            location: location,
            services: services,
          ),
        ),
      ],
    );
  }
}
