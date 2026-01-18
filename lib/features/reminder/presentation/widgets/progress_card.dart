import 'package:flutter/material.dart';
import '../../../../core/styles/app_style.dart';
import '../../../../core/widgets/glass_card.dart';

class ProgressCard extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;
  final bool isForToday;

  const ProgressCard({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
    this.isForToday = true,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = totalTasks == 0 ? 0 : completedTasks / totalTasks;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GlassCard(
        color: AppStyle.white,
        opacity: 0.9,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tasks ${isForToday ? 'Today' : ''} ($totalTasks)',
                  style: AppStyle.titleMedium,
                ),
                Text(
                  'Make it happen!',
                  style: AppStyle.bodyMedium.copyWith(
                    color: AppStyle.primaryColor,
                  ),
                ),
              ],
            ),

            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: percentage),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (context, value, _) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: value,
                        backgroundColor: AppStyle.secondaryColor,
                        color: AppStyle.primaryColor,
                        strokeWidth: 6,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      '${(value * 100).toInt()}%',
                      style: AppStyle.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppStyle.primaryColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
