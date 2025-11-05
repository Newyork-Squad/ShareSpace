import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

class RoomImageSlider extends StatelessWidget {
  final List<String> images;
  final String rate;
  final ValueNotifier<int> currentIndex;
  final PageController controller;

  const RoomImageSlider({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.controller,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 266,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            onPageChanged: (index) => currentIndex.value = index,
            itemBuilder: (context, index) => Image.asset(
              images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            ),
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
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),

                child: ValueListenableBuilder<int>(
                  valueListenable: currentIndex,
                  builder: (_, current, __) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: current == index ? 8 : 5,
                          height: current == index ? 8 : 5,
                          decoration: BoxDecoration(
                            color: current == index
                                ? theme.colors.onPrimary
                                : theme.colors.onPrimaryBody,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
