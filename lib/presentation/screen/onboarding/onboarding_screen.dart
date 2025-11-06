import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/colors/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../design_system/typography/app_typography.dart';
import '../login/login_screen.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.65, initialPage: 999);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final initialIndex = _controller.initialPage % onboardingData.length;
        setState(() {
          _currentPage = initialIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index % onboardingData.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = onboardingData[_currentPage];

    return Scaffold(
      backgroundColor: AppColors.light.primary,
      body: Stack(
        children: [
          Container(
            color: AppColors.light.blueVariant,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool(
                            'seenOnboarding',
                            true,
                          ); // حفظ الحالة

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Skip',
                          style: AppTypography().textTheme.labelMedium
                              ?.copyWith(color: AppColors.light.title),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final data =
                            onboardingData[index % onboardingData.length];
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            double value = 0.0;
                            if (!_controller.position.haveDimensions) {
                              value = (_controller.initialPage - index)
                                  .toDouble();
                            } else {
                              value = _controller.page! - index;
                            }

                            double scale = (1 - (value.abs() * 0.2)).clamp(
                              0.8,
                              1.0,
                            );
                            double rotation = value * -0.3;
                            double verticalOffset = -35 * value.abs();
                            double horizontalOverlap = 100 * value;
                            final isCenter = value.abs() < 0.5;

                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                if (!isCenter)
                                  _buildImageCard(
                                    data['image']!,
                                    horizontalOverlap,
                                    verticalOffset,
                                    rotation,
                                    scale,
                                  ),
                                if (isCenter)
                                  _buildImageCard(
                                    data['image']!,
                                    horizontalOverlap,
                                    verticalOffset,
                                    rotation,
                                    scale,
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 247,
            child: IgnorePointer(
              ignoring: true,
              child: Image.asset(
                'assets/images/onboarding_background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.31,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          current['title']!,
                          textAlign: TextAlign.center,
                          style: AppTypography().textTheme.titleSmall?.copyWith(
                            color: AppColors.light.title,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          current['subtitle']!,
                          textAlign: TextAlign.center,
                          style: AppTypography().textTheme.bodyMedium?.copyWith(
                            color: AppColors.light.body,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            onboardingData.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: _currentPage == index ? 4 : 3,
                              height: _currentPage == index ? 24 : 12,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? AppColors.light.primary
                                    : AppColors.light.primary.withValues(
                                        alpha: 0.3,
                                      ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: current['button'] == 'Start now'
                              ? () async {
                                  // حفظ حالة مشاهدة Onboarding
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool('seenOnboarding', true);

                                  // الانتقال للـ LoginScreen
                                  if (!mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                }
                              : _onNextPressed,
                          child: Text(
                            current['button']!,
                            style: AppTypography().textTheme.labelMedium
                                ?.copyWith(
                                  color: AppColors.light.primaryVariant,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard(
    String imagePath,
    double horizontalOverlap,
    double verticalOffset,
    double rotation,
    double scale,
  ) {
    return Positioned.fill(
      child: Transform.translate(
        offset: Offset(horizontalOverlap, verticalOffset),
        child: Transform.scale(
          scale: scale,
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.67,
              height: MediaQuery.of(context).size.height * 0.36,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F39BADF),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
