import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/home/state/category.dart';

import 'listing_card.dart';

class WorkspacesGrid extends StatelessWidget {
  const WorkspacesGrid({required this.category, super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    // TODO: Filter workspaces based on the category.
    return SizedBox(
      height: 320,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: category.workspaces.length,
        separatorBuilder: (context, index) => const SizedBox(width: 4),
        itemBuilder: (context, index) => SizedBox(
          width: 328,
          child: ListingCard(
            imageUrl: category.workspaces[index].imageUrls[0],
            rating: category.workspaces[index].rate,
            title: category.workspaces[index].name,
            price: category.workspaces[index].pricePerHour.toInt().toString(),
            location: category.workspaces[index].locationName,
            amenities: category.workspaces[index].services
                .map((e) => e.name)
                .toList(),
          ),
        ),
      ),
    );
  }
}
