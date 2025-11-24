import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/design_system/typography/app_typography.dart';
import 'package:share_space/presentation/design_system/widget/amenities_row.dart';
import 'package:share_space/presentation/design_system/widget/booking_card/booking_status_chip.dart';
import 'package:share_space/presentation/design_system/widget/custom_chip.dart';
import 'package:share_space/presentation/screen/shared/ui_state/booking_ui_state.dart';

class BookingCard extends StatelessWidget {
  final String imageUrl;
  final double rating;
  final String title;
  final String price;
  final String location;
  final List<String> amenities;
  final BookingStatusUiState status;
  final String date;
  final String time;

  const BookingCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.title,
    required this.price,
    required this.location,
    required this.amenities,
    required this.status,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colors.stroke, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageWithRating(theme),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [details(theme)],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            AmenitiesRow(amenities: amenities),
            const SizedBox(height: 12),
            _buildStatusAndTime(theme),
            const SizedBox(height: 12),
            _buildActionButtons(context),
          ],
        ),
      ),
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

  Widget _buildStatusAndTime(AppTheme theme) {
    return Row(
      children: [
        BookingStatusChip(status: status),
        const SizedBox(width: 8),
        Text(
          date,
          style: theme.typography.textTheme.labelSmall?.copyWith(
            color: theme.colors.body,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.circle, size: 4, color: theme.colors.stroke),
        const SizedBox(width: 8),
        Text(
          time,
          style: theme.typography.textTheme.labelSmall?.copyWith(
            color: theme.colors.body,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final theme = AppTheme.of(context);
    switch (status) {
      case BookingStatusUiState.upcoming:
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.errorVariant,
                  foregroundColor: theme.colors.red,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "Cancel booking",
                  style: theme.typography.textTheme.labelSmall,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.blueVariant,
                  foregroundColor: theme.colors.primary,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "Extend booking",
                  style: theme.typography.textTheme.labelSmall,
                ),
              ),
            ),
          ],
        );
      case BookingStatusUiState.completed:
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: theme.colors.onPrimary,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "Book Again",
                  style: theme.typography.textTheme.labelSmall,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.blueVariant,
                  foregroundColor: theme.colors.primary,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "Rate",
                  style: theme.typography.textTheme.labelSmall,
                ),
              ),
            ),
          ],
        );
      case BookingStatusUiState.canceled:
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: theme.colors.onPrimary,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "Book Again",
                  style: theme.typography.textTheme.labelSmall,
                ),
              ),
            ),
          ],
        );
    }
  }
}
