import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/search/widget/range_chip.dart';
import 'package:share_space/presentation/screen/search/widget/range_slider.dart';
import 'package:share_space/presentation/screen/search/widget/rating_filter.dart';
import 'package:share_space/presentation/screen/search/widget/services_filter.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _currentRange = const RangeValues(100, 500);
  List<String> rateOptions = ["All", "1", "2", "3", "4", "5"];
  List<int> selectedRateIndices = [0];
  List<String> servicesOptions = [
    "All",
    "Wifi",
    "A/C",
    "Whiteboard",
    "Power Backup",
  ];
  List<int> selectedServicesIndices = [0];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSliderWidget(
          maxRange: const RangeValues(0, 1000),
          currentRange: _currentRange,
          onChange: (newRange) {
            setState(() {
              _currentRange = newRange;
            });
          },
          currency: "IQD",
        ),
        Row(
          children: [
            Expanded(
              child: RangeChip(
                label: "Min",
                value: _currentRange.start.toInt(),
                image: "assets/icons/arrow_down.svg",
                unit: "IQD",
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RangeChip(
                label: "Max",
                value: _currentRange.end.toInt(),
                image: "assets/icons/arrow_down.svg",
                unit: "IQD",
              ),
            ),
          ],
        ),
        RatingFilter(
          options: rateOptions,
          selectedIndices: selectedRateIndices,
          onSelect: (index) {
            setState(() {
              if (selectedRateIndices.contains(index)) {
                selectedRateIndices.remove(index);
                if (selectedRateIndices.isEmpty) {
                  selectedRateIndices.add(0);
                }
              } else {
                if (index == 0) {
                  selectedRateIndices.clear();
                }
                if (selectedRateIndices.length == 1 &&
                    selectedRateIndices.first == 0) {
                  selectedRateIndices.clear();
                }
                selectedRateIndices.add(index);
              }
            });
          },
        ),
        ServicesFilter(
          options: servicesOptions,
          selectedIndices: selectedServicesIndices,
          onSelect: (index) {
            setState(() {
              if (selectedServicesIndices.contains(index)) {
                selectedServicesIndices.remove(index);
                if (selectedServicesIndices.isEmpty) {
                  selectedServicesIndices.add(0);
                }
              } else {
                if (index == 0) {
                  selectedServicesIndices.clear();
                }
                if (selectedServicesIndices.length == 1 &&
                    selectedServicesIndices.first == 0) {
                  selectedServicesIndices.clear();
                }
                selectedServicesIndices.add(index);
              }
            });
          },
        ),
      ],
    );
  }
}
