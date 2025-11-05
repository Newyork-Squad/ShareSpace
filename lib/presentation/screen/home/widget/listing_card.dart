import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';

class ListingCard extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final String title;
  final String price;
  final String location;
  final List<String> amenities;

  const ListingCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.title,
    required this.price,
    required this.location,
    required this.amenities,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWithRating(),
            const SizedBox(width: 8),
            Details(theme),
          ],
        ),
        const SizedBox(height: 12),
        Amenities(theme),
      ],
    );
  }

  Widget ImageWithRating() {
    return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 106,
              height: 68,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }

  Widget Details(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.typography.textTheme.titleMedium?.copyWith(
            color: theme.colors.title,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            SvgPicture.asset("assets/icons/attach_money.svg", width: 16),
            const SizedBox(width: 4),
            Text(
              price,
              style: theme.typography.textTheme.labelSmall?.copyWith(
                color: theme.colors.body,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SvgPicture.asset("assets/icons/location.svg", width: 16),
            const SizedBox(width: 4),
            Text(
              price,
              style: theme.typography.textTheme.labelSmall?.copyWith(
                color: theme.colors.body,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget Amenities(AppTheme theme) {
    return Wrap(
      spacing: 6.0,
      runSpacing: 4.0,
      children: amenities.map((amenity) {
        return Chip(
          label: Text(amenity, style: theme.typography.textTheme.labelSmall),
        );
      }).toList(),
    );
  }
}
