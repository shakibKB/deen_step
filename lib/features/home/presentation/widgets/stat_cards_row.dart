import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Row of 2 stat cards: Daily Goal & Current Streak.
class StatCardsRow extends StatelessWidget {
  final int dailyGoalProgress;
  final int dailyGoalTarget;
  final int streakDays;

  const StatCardsRow({
    super.key,
    this.dailyGoalProgress = 0,
    this.dailyGoalTarget = 5,
    this.streakDays = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Daily Goal Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.homeCardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.homeCardBorder,
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daily Goal',
                      style: TextStyle(
                        color: Color(0xFF9EAAA0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.access_time_rounded,
                      size: 18,
                      color: const Color(0xFF5A7264).withValues(alpha: 0.8),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$dailyGoalProgress',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      ' /$dailyGoalTarget',
                      style: const TextStyle(
                        color: Color(0xFF7E9287),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Track a prayer to\nunlock goals',
                  style: TextStyle(
                    color: AppColors.brandLime,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),

        // Current Streak Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.homeCardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.homeCardBorder,
                width: 1.2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Streak',
                      style: TextStyle(
                        color: Color(0xFF9EAAA0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '🔥',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$streakDays',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Text(
                      ' days',
                      style: TextStyle(
                        color: Color(0xFF7E9287),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Log today to\nbegin streak',
                  style: TextStyle(
                    color: AppColors.streakGold,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
