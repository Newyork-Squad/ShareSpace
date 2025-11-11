import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/home/state/category.dart';

import '../../../design_system/theme/app_theme.dart';
import '../../../util/service_mapper.dart';
import 'listing_card.dart';

class WorkspacesGrid extends StatelessWidget {
  const WorkspacesGrid({
    required this.category,
    required this.onClick,
    super.key,
  });

  final Category category;
  final Function(String) onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 208,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        scrollDirection: Axis.horizontal,
        itemCount: category.workspaces.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 8,
          childAspectRatio: 96 / 328,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onClick(category.workspaces[index].id.toString()),
          child: ListingCard(
            imageUrl: category.workspaces[index].imageUrls[0],
            rating: category.workspaces[index].rate,
            title: category.workspaces[index].name,
            price: "${category.workspaces[index].pricePerHour.toInt().toString()}/h",
            location: category.workspaces[index].locationName,
            amenities: category.workspaces[index].services
                .map((e) => serviceLabel(e))
                .toList(),
          ),
        ),
      ),
    );
  }
}
