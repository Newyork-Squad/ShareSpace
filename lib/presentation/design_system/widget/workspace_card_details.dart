import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/design_system/widget/custom_chip.dart';
import 'package:share_space/presentation/util/get_service_icon_path.dart';

class WorkspaceCardDetails extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final String title;
  final String price;
  final String location;
  final List<String> amenities;

  const WorkspaceCardDetails({
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
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colors.stroke,
          width: 0.5,
        ),
      ),
      child: Padding( 
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 12) ,
          child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          imageWithRating(theme),
          const SizedBox(width: 4),
          details(theme),
          const SizedBox(height: 4),
          amenitiesRow(theme),
        ],
      )),
    );
  }

  Widget imageWithRating(AppTheme theme) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: 142,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.network(
              'https://img-cdn.inc.com/image/upload/f_webp,c_fit,w_1920,q_auto/images/panoramic/getty_517610514_353435.jpg',
              width: double.infinity,
              height: 142,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          child: Row(
            children: [
              CustomChip(
                label: rating.toInt().toString(),
                labelColor: theme.colors.yellow,
                icon: "assets/icons/star.svg",
              ),
              const SizedBox(width: 4),
              CustomChip(label: price, icon: "assets/icons/attach_money.svg"),
            ],
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
          width: 300,
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
            SvgPicture.asset("assets/icons/location.svg", width: 12),
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
