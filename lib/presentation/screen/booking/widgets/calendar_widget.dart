import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../resources/app_strings.dart';
import '../../../design_system/colors/app_color.dart';
import '../../../design_system/typography/app_typography.dart';
import '../constant_folder/months.dart';

class CalendarWidget extends StatefulWidget {
  final Set<DateTime> unavailableDates;
  final Function(DateTime) onDateSelected;

  const CalendarWidget({
    super.key,
    this.unavailableDates = const {},
    required this.onDateSelected,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  late Set<DateTime> fakeUnavailableDates;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    _focusedDay = DateTime(now.year, now.month, 1);
    _selectedDay = null;

    fakeUnavailableDates = {
      DateTime(now.year, now.month, 2),
      DateTime(now.year, now.month, 3),
      DateTime(now.year, now.month, 14),
      DateTime(now.year, now.month, 23),
    };
  }

  bool _isUnavailable(DateTime day) {
    return fakeUnavailableDates.any(
          (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  String _monthName(int m) {
    return months[m - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.bookingSelectADateTitle,
              style: AppTypography().textTheme.titleSmall?.copyWith(
                color: AppColors.light.title,
              ),
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                        1,
                      );
                    });
                  },
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: SvgPicture.asset(
                      'assets/icons/arrow_left.svg',
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                        AppColors.light.title,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _focusedDay,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      initialEntryMode: DatePickerEntryMode.calendar,
                    );

                    if (picked != null) {
                      setState(() {
                        _focusedDay = DateTime(picked.year, picked.month, 1);
                        _selectedDay = null;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          '${_monthName(_focusedDay.month)}, ${_focusedDay.year}',
                          style: AppTypography().textTheme.labelSmall?.copyWith(
                            color: AppColors.light.title,
                          ),
                        ),
                        const SizedBox(width: 2),
                        SvgPicture.asset(
                          'assets/icons/arrow_down.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            AppColors.light.title,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                        1,
                      );
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: SvgPicture.asset(
                        'assets/icons/arrow_right_book_room_screen.svg',
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          AppColors.light.title,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['S', 'S', 'M', 'T', 'W', 'T', 'F']
              .map(
                (d) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                width: 43.43,
                height: 40,
                child: Center(
                  child: Text(
                    d,
                    style: AppTypography().textTheme.titleSmall?.copyWith(
                      color: AppColors.light.title,
                    ),
                  ),
                ),
              ),
            ),
          )
              .toList(),
        ),

        TableCalendar(
          firstDay: DateTime(2000, 1, 1),
          lastDay: DateTime(2100, 12, 31),
          focusedDay: _focusedDay,
          startingDayOfWeek: StartingDayOfWeek.saturday,
          daysOfWeekVisible: false,
          headerVisible: false,
          selectedDayPredicate: (day) =>
          _selectedDay != null &&
              day.year == _selectedDay!.year &&
              day.month == _selectedDay!.month &&
              day.day == _selectedDay!.day,
          onDaySelected: (selectedDay, focusedDay) {
            if (_isUnavailable(selectedDay)) return;
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDateSelected(selectedDay);
          },
          enabledDayPredicate: (day) => !_isUnavailable(day),
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
            markersMaxCount: 0,
            cellMargin: EdgeInsets.zero,
          ),
          availableGestures: AvailableGestures.none,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              final isUnavailable = _isUnavailable(day);
              return _DayCell(
                day: day.day,
                isSelected: false,
                isUnavailable: isUnavailable,
              );
            },
            selectedBuilder: (context, day, focusedDay) {
              return _DayCell(
                day: day.day,
                isSelected: true,
                isUnavailable: false,
              );
            },
            disabledBuilder: (context, day, focusedDay) {
              return _DayCell(
                day: day.day,
                isSelected: false,
                isUnavailable: true,
              );
            },
            todayBuilder: (context, day, focusedDay) {
              final isUnavailable = _isUnavailable(day);
              return _DayCell(
                day: day.day,
                isSelected:
                _selectedDay != null &&
                    _selectedDay!.day == day.day &&
                    _selectedDay!.month == day.month &&
                    _selectedDay!.year == day.year,
                isUnavailable: isUnavailable,
                isToday: true,
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        if (_selectedDay != null && !_isUnavailable(_selectedDay!))
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.bookingThisDayIsAvailableNote,
                style: AppTypography().textTheme.labelSmall?.copyWith(
                  color: AppColors.light.green,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool isSelected;
  final bool isUnavailable;
  final bool isToday;

  const _DayCell({
    Key? key,
    required this.day,
    this.isSelected = false,
    this.isUnavailable = false,
    this.isToday = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = isSelected
        ? AppTypography().textTheme.titleSmall?.copyWith(
      color: AppColors.light.primary,
    )
        : isUnavailable
        ? TextStyle(
      color: AppColors.light.red,
      fontSize: 13,
      fontFamily: 'Inter',
      decoration: TextDecoration.lineThrough,
      decorationColor: AppColors.light.red,
      decorationThickness: 1,
    )
        : TextStyle(
      color: AppColors.light.title,
      fontSize: 16,
      fontFamily: 'Inter',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: 43.43,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isUnavailable)
              Container(
                width: 43.43,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xFFFFEEEF),
                ),
              ),
            if (isSelected)
              Container(
                width: 43.43,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.light.blueVariant,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: AppColors.light.primary, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x3D84E2FE),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            Text('$day', style: textStyle),
          ],
        ),
      ),
    );
  }
}
