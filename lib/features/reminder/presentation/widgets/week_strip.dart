import 'package:flutter/material.dart';
import '../../../../core/styles/app_style.dart';
import 'package:intl/intl.dart';

class WeekStrip extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const WeekStrip({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<WeekStrip> createState() => _WeekStripState();
}

class _WeekStripState extends State<WeekStrip> {
  late DateTime _startDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startDate = now.subtract(Duration(days: now.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    final weekMonth = _startDate.add(const Duration(days: 3));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    DateFormat('MMMM yyyy').format(weekMonth),
                    style: AppStyle.titleLarge,
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.calendar_today, size: 20),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _startDate = _startDate.subtract(
                          const Duration(days: 7),
                        );
                      });
                    },
                    icon: const Icon(Icons.chevron_left),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _startDate = _startDate.add(const Duration(days: 7));
                      });
                    },
                    icon: const Icon(Icons.chevron_right),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (index) {
                final date = _startDate.add(Duration(days: index));
                final isSelected = DateUtils.isSameDay(
                  date,
                  widget.selectedDate,
                );

                return GestureDetector(
                  onTap: () => widget.onDateSelected(date),
                  child: Container(
                    width: 40,
                    height: 70,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppStyle.primaryColor
                          : AppStyle.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('d').format(date),
                          style: AppStyle.labelLarge.copyWith(
                            color: isSelected ? AppStyle.white : AppStyle.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('E').format(date).substring(0, 1),
                          style: AppStyle.bodyMedium.copyWith(
                            color: isSelected ? AppStyle.white : AppStyle.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
