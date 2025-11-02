import 'package:flutter/material.dart';
import 'package:share_space/presentation/screen/search/widget/range_chip.dart';
import 'package:share_space/presentation/screen/search/widget/range_slider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RangeValues _currentRange = const RangeValues(100, 500);

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
      ],
    );
  }
}

/*
* onPressed: () {
          showBaseBottomSheet(
            context: context,
            child: FilterBottomSheet(),
            label: "Filter",
            onClose: () {},
            height: 0.65,
          );
        },
* */
