import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class PrayerTimelineItem {
  final String name;
  final String time;
  final IconData icon;
  final bool isActive;

  const PrayerTimelineItem({
    required this.name,
    required this.time,
    required this.icon,
    this.isActive = false,
  });
}

/// The top atmospheric scenic header card matching the Figma design.
/// Features scenic mountain and mosque background image, glowing sun,
/// location chip, Hijri date, digital clock, countdown, and interactive prayer timeline.
class IslamicHeaderCard extends StatelessWidget {
  final String location;
  final String hijriDate;
  final String time;
  final String date;
  final String nextPrayerCountdown;
  final String selectedPrayer;
  final ValueChanged<String>? onPrayerSelected;
  final VoidCallback? onLocationTap;

  const IslamicHeaderCard({
    super.key,
    this.location = 'Gulshan, Dhaka',
    this.hijriDate = '3 Jumada Al-Awwal, 1447 H',
    this.time = '18:55',
    this.date = 'Sat, 25 Oct 2025',
    this.nextPrayerCountdown = 'Maghrib in 0h 29m 3s left',
    this.selectedPrayer = 'Dhuhr',
    this.onPrayerSelected,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    final prayers = [
      const PrayerTimelineItem(
        name: 'Fajr',
        time: '04:03',
        icon: Icons.nightlight_round,
      ),
      const PrayerTimelineItem(
        name: 'Dhuhr',
        time: '11:37',
        icon: Icons.wb_sunny_rounded,
        isActive: true,
      ),
      const PrayerTimelineItem(
        name: 'Asr',
        time: '15:00',
        icon: Icons.cloud_rounded,
      ),
      const PrayerTimelineItem(
        name: 'Maghrib',
        time: '17:48',
        icon: Icons.wb_twilight_rounded,
      ),
      const PrayerTimelineItem(
        name: 'Isha',
        time: '19:02',
        icon: Icons.dark_mode_rounded,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF16251D),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        child: Stack(
          children: [
            // 1. Background Mosque & Mountain Artwork Image
            Positioned.fill(
              child: Image.asset(
                AppAssets.homeHeaderBg,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),

            // 2. Atmospheric Gradient Overlay (ensures contrast & readability)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.22),
                      Colors.transparent,
                      const Color(0xFF16251D).withValues(alpha: 0.38),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),

            // 3. Radiant Glowing Sun in top-right
            Positioned(
              right: 24,
              top: topPadding + 14,
              child: IgnorePointer(
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFFEE58).withValues(alpha: 0.85),
                        const Color(0xFFFFD54F).withValues(alpha: 0.45),
                        const Color(0xFFFFA000).withValues(alpha: 0.15),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.35, 0.65, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            // 4. Top Header Content
            Padding(
              padding: EdgeInsets.only(
                top: topPadding + 8,
                bottom: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Location Pill
                  Center(
                    child: GestureDetector(
                      onTap: onLocationTap,
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x730E1B14),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0x403F5C4A),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 14,
                              color: AppColors.brandLime,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Hijri Date
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      hijriDate,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Big Digital Time & Gregorian Date
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                            color: AppColors.brandLime,
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -1.0,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Next Prayer Countdown Pill
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x660B1510),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0x38415C4B),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 13.5,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 6),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                const TextSpan(text: 'Maghrib in '),
                                const TextSpan(
                                  text: '0h 29m 3s left',
                                  style: TextStyle(
                                    color: AppColors.brandLime,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Horizontal Prayer Timeline
                  _buildPrayerTimeline(context, prayers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimeline(
    BuildContext context,
    List<PrayerTimelineItem> prayers,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Connecting Horizontal Line
          Positioned(
            top: 36,
            left: 24,
            right: 24,
            child: Container(
              height: 1.5,
              color: const Color(0xFF384D3F).withValues(alpha: 0.6),
            ),
          ),

          // Prayer Items Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: prayers.map((p) {
              final isCurrent = (p.name == selectedPrayer) || p.isActive;

              return GestureDetector(
                onTap: () => onPrayerSelected?.call(p.name),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Time Text
                      Text(
                        p.time,
                        style: TextStyle(
                          fontSize: isCurrent ? 12.5 : 11,
                          fontWeight:
                              isCurrent ? FontWeight.w700 : FontWeight.w500,
                          color: isCurrent
                              ? AppColors.brandLime
                              : Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Circle Icon
                      Container(
                        width: isCurrent ? 44 : 36,
                        height: isCurrent ? 44 : 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCurrent
                              ? AppColors.brandLime
                              : const Color(0xFF132018),
                          border: Border.all(
                            color: isCurrent
                                ? AppColors.brandLime
                                : const Color(0xFF2C3E32),
                            width: 1.5,
                          ),
                          boxShadow: isCurrent
                              ? [
                                  BoxShadow(
                                    color:
                                        AppColors.brandLime.withValues(alpha: 0.45),
                                    blurRadius: 14,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(
                          p.icon,
                          size: isCurrent ? 22 : 17,
                          color: isCurrent
                              ? const Color(0xFF111814)
                              : Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Name Text
                      Text(
                        p.name,
                        style: TextStyle(
                          fontSize: isCurrent ? 13 : 11.5,
                          fontWeight:
                              isCurrent ? FontWeight.w700 : FontWeight.w500,
                          color: isCurrent
                              ? AppColors.brandLime
                              : Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
