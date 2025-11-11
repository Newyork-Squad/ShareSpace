import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

class RoomImageSlider extends StatelessWidget {
  static const _placeholderImage = 'assets/images/room_image.png';

  final List<String> images;
  final String rate;
  final int currentIndex;
  final PageController controller;
  final ValueChanged<int> onPageChanged;

  const RoomImageSlider({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.controller,
    required this.rate,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final displayImages =
        images.isNotEmpty ? images : const [_placeholderImage];

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 266,
          child: PageView.builder(
            controller: controller,
            itemCount: displayImages.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) =>
                _buildImage(displayImages[index]),
          ),
        ),
        Positioned(
          top: 210,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: theme.colors.onPrimaryStroke,
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    displayImages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == index ? 8 : 5,
                      height: currentIndex == index ? 8 : 5,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? theme.colors.onPrimary
                            : theme.colors.onPrimaryBody,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String image) {
    final isNetworkImage = image.startsWith('http');
    final placeholder = Image.asset(
      _placeholderImage,
      fit: BoxFit.cover,
      width: double.infinity,
    );

    if (isNetworkImage) {
      return Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder;
        },
        errorBuilder: (_, __, ___) => placeholder,
      );
    }

    return Image.asset(
      image,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => Image.asset(
        "assets/images/room_image.png",
        fit: BoxFit.cover,
        width: double.infinity,
      )
    );
  }
}
