import 'package:flutter/material.dart';
import 'package:share_space/presentation/design_system/theme/app_theme.dart';
import 'package:share_space/presentation/screen/search/widget/range_chip.dart';
import 'package:share_space/presentation/screen/search/widget/range_slider.dart';
import 'package:share_space/presentation/screen/search/widget/rating_filter.dart';
import 'package:share_space/presentation/screen/search/widget/services_filter.dart';
import 'package:share_space/presentation/screen/shared/ui_state/workspace_ui_state.dart';

import '../../design_system/widget/primary_button.dart';
import '../../design_system/widget/secondary_button.dart';

class FilterBottomSheet extends StatefulWidget {
  final RangeValues initialRange;
  RangeValues currentRange;
  final List<String> rateOptions;
  final int rateSelectedIndex;
  List<int> selectedRateIndices;
  final List<ServicesUiState> servicesOptions;
  List<int> selectedServicesIndices;

  FilterBottomSheet({
    super.key,
    this.initialRange = const RangeValues(10, 500),
    required this.currentRange,
    required this.rateSelectedIndex,
    this.rateOptions = const ["All", "1", "2", "3", "4", "5"],
    required this.selectedRateIndices,
    this.servicesOptions = ServicesUiState.values,
    required this.selectedServicesIndices,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Rate",
                  style: theme.typography.textTheme.titleSmall?.copyWith(
                    color: theme.colors.title,
                  ),
                ),
              ),
              SizedBox(height: 12),
              RatingFilter(
                options: widget.rateOptions,
                selectedIndices: widget.selectedRateIndices,
                onSelect: (index) {
                  setState(() {
                    if (widget.selectedRateIndices.contains(index)) {
                      widget.selectedRateIndices.remove(index);
                      if (widget.selectedRateIndices.isEmpty) {
                        widget.selectedRateIndices.add(0);
                      }
                    } else {
                      if (index == 0) {
                        widget.selectedRateIndices.clear();
                      }
                      if (widget.selectedRateIndices.length == 1 &&
                          widget.selectedRateIndices.first == 0) {
                        widget.selectedRateIndices.clear();
                      }
                      widget.selectedRateIndices.add(index);
                    }
                  });
                },
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Price Range",
                  style: theme.typography.textTheme.titleSmall?.copyWith(
                    color: theme.colors.title,
                  ),
                ),
              ),
              SizedBox(height: 12),
              RangeSliderWidget(
                maxRange: widget.initialRange,
                currentRange: widget.currentRange,
                onChange: (newRange) {
                  setState(() {
                    widget.currentRange = newRange;
                  });
                },
                currency: "/hr",
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RangeChip(
                      label: "Min",
                      value: widget.currentRange.start.toInt(),
                      image: "assets/icons/arrow_down.svg",
                      unit: "IQD",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RangeChip(
                      label: "Max",
                      value: widget.currentRange.end.toInt(),
                      image: "assets/icons/arrow_up.svg",
                      unit: "IQD",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Services",
                  style: theme.typography.textTheme.titleSmall?.copyWith(
                    color: theme.colors.title,
                  ),
                ),
              ),
              SizedBox(height: 12),
              ServicesFilter(
                options: widget.servicesOptions.map((e) => e.toString()).toList(),
                selectedIndices: widget.selectedServicesIndices,
                onSelect: (index) {
                  setState(() {
                    if (widget.selectedServicesIndices.contains(index)) {
                      widget.selectedServicesIndices.remove(index);
                      if (widget.selectedServicesIndices.isEmpty) {
                        widget.selectedServicesIndices.add(0);
                      }
                    } else {
                      if (index == 0) {
                        widget.selectedServicesIndices.clear();
                      }
                      if (widget.selectedServicesIndices.length == 1 &&
                          widget.selectedServicesIndices.first == 0) {
                        widget.selectedServicesIndices.clear();
                      }
                      widget.selectedServicesIndices.add(index);
                    }
                  });
                },
              ),
              // SizedBox(height: 16),
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     "Location",
              //     style: theme.typography.textTheme.titleSmall?.copyWith(
              //       color: theme.colors.title,
              //     ),
              //   ),
              // ),
              SizedBox(height: 12),
              // TODO: Add Location Filter Widget here
              SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SecondaryButton(
                      onPressed: () {},
                      label: "Clear",
                      isDisabled: true,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {},
                      label: "Apply Filters",
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
