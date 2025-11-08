import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details/room_details_cubit.dart';
import 'package:share_space/presentation/screen/room_details/state/room_details/room_details_state.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_details_appbar.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_header_section.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_image_slider.dart';
import 'package:share_space/presentation/screen/room_details/widgets/room_tab_section.dart';

import 'owner_section.dart';

class RoomDetailsBody extends StatefulWidget {
  const RoomDetailsBody({super.key, required this.state});

  final RoomDetailsLoaded state;

  @override
  State<RoomDetailsBody> createState() => _RoomDetailsBodyState();
}

class _RoomDetailsBodyState extends State<RoomDetailsBody> {
  late final PageController _pageController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.state.currentImageIndex);
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void didUpdateWidget(covariant RoomDetailsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.currentImageIndex != oldWidget.state.currentImageIndex &&
        _pageController.hasClients &&
        _pageController.page?.round() != widget.state.currentImageIndex) {
      _pageController.jumpToPage(widget.state.currentImageIndex);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final cubit = context.read<RoomDetailsCubit>();
    final shouldBeScrolled = _scrollController.offset > 24;
    if (shouldBeScrolled != widget.state.isScrolled) {
      cubit.updateScroll(shouldBeScrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final state = widget.state;
    final cubit = context.read<RoomDetailsCubit>();

    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: RoomImageSlider(
                images: state.roomImages,
                controller: _pageController,
                currentIndex: state.currentImageIndex,
                onPageChanged: cubit.changeImageIndex,
                rate: state.rate,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: const BorderRadius.only(
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
                    Divider(color: theme.colors.stroke, height: 1),
                    RoomOwnerSection(
                      name: state.ownerName,
                      role: state.ownerRole,
                      imagePath: state.ownerImagePath,
                    ),
                    Divider(color: theme.colors.stroke, height: 1),
                    RoomTabsSection(
                      description: state.roomDescription,
                      rules: state.roomRules,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        RoomDetailsAppbar(rate: state.rate, isScrolled: state.isScrolled),
      ],
    );
  }
}
