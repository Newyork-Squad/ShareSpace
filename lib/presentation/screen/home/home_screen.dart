import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/home/widget/booking_card.dart';
import 'package:share_space/presentation/screen/home/widget/category_chip.dart';
import 'package:share_space/presentation/screen/home/widget/home_app_bar.dart';
import 'package:share_space/presentation/screen/home/widget/listing_card.dart';

import '../../design_system/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String tempImage =
      "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  List<String> categories = [
    "All",
    "Rooms",
    "Apartments",
    "Offices",
    "Hotels",
    "Hostels",
    "Resorts",
    "Guest Houses",
    "Guest Homes",
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      color: theme.colors.surfaceLow,
      child: CustomScrollView(
        slivers: [
          HomeAppBar(
            userName: "Ahmed Hussein",
            location: "Cairo, Egypt",
            profileImageUrl: tempImage,
          ),
          // Book now section
          SliverToBoxAdapter(
            child: SizedBox(
              height: 172,
              width: 200,
              child: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 2)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(12, 16, 4, 28),
                          child: BookingCard(
                            label: categories[index],
                            description: 'wow room',
                            imageUrl: tempImage,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    label: categories[index],
                    isSelected: _selectedIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListingCard(
                  imageUrl: tempImage,
                  rating: 4.5,
                  title: 'Night Owl Room',
                  price: '12,000 IQD/h',
                  location: 'Baghdad, Iraq',
                  amenities: const [
                    'WiFi',
                    'A/C',
                    'Whiteboard',
                    'Power Backup',
                  ],
                ),
              ),
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
