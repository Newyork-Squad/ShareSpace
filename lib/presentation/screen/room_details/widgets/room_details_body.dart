import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_details_appbar.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_header_section.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_image_slider.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_tab_section.dart';
import '../state/room_details/room_details_state.dart';
import 'owner_section.dart';

class RoomDetailsBody extends StatelessWidget {
  final RoomDetailsLoaded state;
  RoomDetailsBody({super.key, required this.state,});
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      body: Stack(
        children: [
          /// Scrollable content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: RoomImageSlider(
                  images: state.roomImages,
                  currentIndex: _currentIndex,
                  controller: pageController,
                  rate: state.rate,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RoomHeaderSection(
                        title: state.roomName,
                        location: state.location,
                        services: state.services,
                      ),

                      Divider(color: const Color(0x1F1F1F14), height: 1),

                      RoomOwnerSection(
                        name: state.ownerName,
                        role: state.ownerRole,
                        imagePath: state.ownerImagePath,
                      ),

                      Divider(color: const Color(0x1F1F1F14), height: 1),

                        RoomTabsSection(description: state.roomDescription),

                    ],
                  ),
                ),
              ),
            ],
          ),

          /// Fixed appbar (doesn't scroll)
           RoomDetailsAppbar(rate: state.rate, isScrolled: true),
        ],
      ),
    );
  }
}
