import 'dart:math' as math;
import 'package:flutter/material.dart';
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
/// Features scenic sunset sky with glowing sun, flying birds, mosque silhouette,
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
        time: '11.37',
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
            // Background Mosque Scenery & Sun
            Positioned.fill(
              child: CustomPaint(
                painter: _MosqueSunsetPainter(),
              ),
            ),

            // Top Header Content
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

/// Custom painter for the atmospheric sunset sky, glowing sun,
/// flying birds, distant hills, and mosque silhouette.
class _MosqueSunsetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Sky Gradient
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1A3026),
          Color(0xFF25392D),
          Color(0xFF3B442A),
          Color(0xFF222C21),
        ],
        stops: [0.0, 0.45, 0.85, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // 2. Radiant Glowing Sun (Top-Right)
    final sunCenter = Offset(w * 0.78, h * 0.26);

    // Outer ambient halo
    final haloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFD54F).withValues(alpha: 0.35),
          const Color(0xFFFFA000).withValues(alpha: 0.12),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: sunCenter, radius: 95));
    canvas.drawCircle(sunCenter, 95, haloPaint);

    // Mid sun glow
    final midSunPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFEE58).withValues(alpha: 0.9),
          const Color(0xFFFFCA28).withValues(alpha: 0.6),
          const Color(0xFFFFA000).withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: sunCenter, radius: 48));
    canvas.drawCircle(sunCenter, 48, midSunPaint);

    // Inner glowing core
    final coreSunPaint = Paint()
      ..color = const Color(0xFFFFF59D)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(sunCenter, 20, coreSunPaint);

    // 3. Birds Silhouettes in Flight
    final birdPaint = Paint()
      ..color = const Color(0xFF16251C).withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round;

    _drawBird(canvas, birdPaint, Offset(w * 0.18, h * 0.19), 7);
    _drawBird(canvas, birdPaint, Offset(w * 0.23, h * 0.16), 5.5);
    _drawBird(canvas, birdPaint, Offset(w * 0.70, h * 0.18), 6);
    _drawBird(canvas, birdPaint, Offset(w * 0.73, h * 0.195), 4.5);

    // 4. Distant Mountain Ridge
    final mountainPaint = Paint()
      ..color = const Color(0xFF263A2D).withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    final mountainPath = Path();
    mountainPath.moveTo(0, h);
    mountainPath.lineTo(0, h * 0.68);
    mountainPath.quadraticBezierTo(w * 0.25, h * 0.62, w * 0.5, h * 0.69);
    mountainPath.quadraticBezierTo(w * 0.75, h * 0.60, w, h * 0.66);
    mountainPath.lineTo(w, h);
    mountainPath.close();
    canvas.drawPath(mountainPath, mountainPaint);

    // 5. Grand Mosque Silhouette
    final mosquePaint = Paint()
      ..color = const Color(0xFF16241C)
      ..style = PaintingStyle.fill;

    final mosquePath = Path();
    mosquePath.moveTo(0, h);

    // Left base
    mosquePath.lineTo(0, h * 0.78);

    // Leftmost minaret
    mosquePath.lineTo(w * 0.08, h * 0.78);
    mosquePath.lineTo(w * 0.08, h * 0.48);
    mosquePath.lineTo(w * 0.07, h * 0.47);
    mosquePath.lineTo(w * 0.09, h * 0.40); // Spire tip
    mosquePath.lineTo(w * 0.11, h * 0.47);
    mosquePath.lineTo(w * 0.10, h * 0.48);
    mosquePath.lineTo(w * 0.10, h * 0.74);

    // Left secondary dome
    mosquePath.lineTo(w * 0.15, h * 0.74);
    mosquePath.quadraticBezierTo(w * 0.21, h * 0.62, w * 0.28, h * 0.74);

    // Left inner minaret
    mosquePath.lineTo(w * 0.26, h * 0.54);
    mosquePath.lineTo(w * 0.25, h * 0.53);
    mosquePath.lineTo(w * 0.27, h * 0.44); // Spire tip
    mosquePath.lineTo(w * 0.29, h * 0.53);
    mosquePath.lineTo(w * 0.28, h * 0.54);
    mosquePath.lineTo(w * 0.28, h * 0.75);

    // Grand Central Dome
    mosquePath.lineTo(w * 0.35, h * 0.75);
    mosquePath.quadraticBezierTo(w * 0.38, h * 0.50, w * 0.50, h * 0.44);
    // Grand dome finial
    mosquePath.lineTo(w * 0.50, h * 0.39);
    mosquePath.lineTo(w * 0.505, h * 0.44);
    mosquePath.quadraticBezierTo(w * 0.62, h * 0.50, w * 0.65, h * 0.75);

    // Right inner minaret
    mosquePath.lineTo(w * 0.72, h * 0.75);
    mosquePath.lineTo(w * 0.72, h * 0.54);
    mosquePath.lineTo(w * 0.71, h * 0.53);
    mosquePath.lineTo(w * 0.73, h * 0.44); // Spire tip
    mosquePath.lineTo(w * 0.75, h * 0.53);
    mosquePath.lineTo(w * 0.74, h * 0.54);
    mosquePath.lineTo(w * 0.74, h * 0.74);

    // Right secondary dome
    mosquePath.lineTo(w * 0.72, h * 0.74);
    mosquePath.quadraticBezierTo(w * 0.79, h * 0.62, w * 0.85, h * 0.74);

    // Rightmost minaret
    mosquePath.lineTo(w * 0.90, h * 0.74);
    mosquePath.lineTo(w * 0.90, h * 0.48);
    mosquePath.lineTo(w * 0.89, h * 0.47);
    mosquePath.lineTo(w * 0.91, h * 0.40); // Spire tip
    mosquePath.lineTo(w * 0.93, h * 0.47);
    mosquePath.lineTo(w * 0.92, h * 0.48);
    mosquePath.lineTo(w * 0.92, h * 0.78);

    mosquePath.lineTo(w, h * 0.78);
    mosquePath.lineTo(w, h);
    mosquePath.close();

    canvas.drawPath(mosquePath, mosquePaint);

    // 6. Mosque Glowing Arched Windows
    final windowPaint = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    _drawArchedWindow(canvas, windowPaint, Offset(w * 0.45, h * 0.70), 8, 14);
    _drawArchedWindow(canvas, windowPaint, Offset(w * 0.50, h * 0.68), 9, 16);
    _drawArchedWindow(canvas, windowPaint, Offset(w * 0.55, h * 0.70), 8, 14);

    // 7. Silhouetted Palm Fronds on Left and Right edges
    final palmPaint = Paint()
      ..color = const Color(0xFF111D16).withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    _drawPalmTree(canvas, palmPaint, Offset(w * 0.03, h * 0.82), 40);
    _drawPalmTree(canvas, palmPaint, Offset(w * 0.97, h * 0.82), 40, flip: true);
  }

  void _drawBird(Canvas canvas, Paint paint, Offset pos, double size) {
    final path = Path();
    path.moveTo(pos.dx - size, pos.dy);
    path.quadraticBezierTo(pos.dx - size / 2, pos.dy - size * 0.6, pos.dx, pos.dy);
    path.quadraticBezierTo(pos.dx + size / 2, pos.dy - size * 0.6, pos.dx + size, pos.dy);
    canvas.drawPath(path, paint);
  }

  void _drawArchedWindow(
    Canvas canvas,
    Paint paint,
    Offset center,
    double width,
    double height,
  ) {
    final rect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + height * 0.2),
      width: width,
      height: height * 0.6,
    );
    canvas.drawRect(rect, paint);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - height * 0.1),
        width: width,
        height: height * 0.6,
      ),
      math.pi,
      math.pi,
      true,
      paint,
    );
  }

  void _drawPalmTree(
    Canvas canvas,
    Paint paint,
    Offset base,
    double height, {
    bool flip = false,
  }) {
    final trunkPath = Path();
    final direction = flip ? -1.0 : 1.0;
    trunkPath.moveTo(base.dx, base.dy);
    trunkPath.quadraticBezierTo(
      base.dx + direction * 6,
      base.dy - height * 0.5,
      base.dx + direction * 10,
      base.dy - height,
    );
    trunkPath.lineTo(base.dx + direction * 12, base.dy - height);
    trunkPath.quadraticBezierTo(
      base.dx + direction * 8,
      base.dy - height * 0.5,
      base.dx + 2,
      base.dy,
    );
    trunkPath.close();
    canvas.drawPath(trunkPath, paint);

    // Fronds
    final top = Offset(base.dx + direction * 11, base.dy - height);
    for (int i = -3; i <= 3; i++) {
      final angle = i * 0.4 + (flip ? math.pi * 0.8 : math.pi * 0.2);
      final frond = Path();
      frond.moveTo(top.dx, top.dy);
      frond.quadraticBezierTo(
        top.dx + math.cos(angle) * 16,
        top.dy - math.sin(angle) * 8 - 4,
        top.dx + math.cos(angle) * 22,
        top.dy + math.sin(angle) * 6 + 6,
      );
      frond.quadraticBezierTo(
        top.dx + math.cos(angle) * 14,
        top.dy - math.sin(angle) * 4,
        top.dx,
        top.dy,
      );
      canvas.drawPath(frond, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
