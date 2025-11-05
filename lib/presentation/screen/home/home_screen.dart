import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/home/widget/booking_card.dart';
import 'package:share_space/presentation/screen/home/widget/home_app_bar.dart';

import '../../design_system/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String tempImage =
      "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  List<String> categories = ["All", "Rooms", "Apartments", "Offices"];

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
                            label: 'slekfmkls${categories[index]}',
                            description: 'fklzsemklfzm',
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
        ],
      ),
    );
  }
}
