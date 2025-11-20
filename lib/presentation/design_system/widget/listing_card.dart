import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/design_system/widget/custom_chip.dart';

import '../../util/get_service_icon_path.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageWithRating(theme),
            const SizedBox(width: 8),
            details(theme),
          ],
        ),
        const SizedBox(height: 4),
        amenitiesRow(theme),
      ],
    );
  }

  Widget imageWithRating(AppTheme theme) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            width: 106,
            height: 68,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              "assets/images/room_image.png",
              width: 106,
              height: 68,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child: CustomChip(
            label: rating.toInt().toString(),
            labelColor: theme.colors.yellow,
            icon: "assets/icons/star.svg",
          ),
        ),
      ],
    );
  }

  Widget details(AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            title,
            style: theme.typography.textTheme.titleMedium?.copyWith(
              color: theme.colors.title,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset("assets/icons/attach_money.svg", width: 16),
            const SizedBox(width: 4),
            Text(
              price,
              style: AppTypography.labelXSmall.copyWith(
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
            SizedBox(
              width: 150,
              child: Text(
                location,
                style: AppTypography.labelXSmall.copyWith(
                  color: theme.colors.body,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget amenitiesRow(AppTheme theme) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: 4.0,
      runSpacing: 4.0,
      children: amenities.map((amenity) {
        return CustomChip(label: amenity, icon: getServiceIconPath(amenity));
      }).toList(),
    );
  }
}
