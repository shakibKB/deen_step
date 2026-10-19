import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// The "ABUNDANCE VERSE" card with Arabic Ayah, translation, and decorative background.
class AbundanceVerseCard extends StatelessWidget {
  final String title;
  final String reference;
  final String arabicText;
  final String translation;
  final VoidCallback? onTap;

  const AbundanceVerseCard({
    super.key,
    this.title = 'ABUNDANCE VERSE',
    this.reference = 'Surah Al-Ahqaf, 46:15',
    this.arabicText = 'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ',
    this.translation =
        '"My Lord, enable me to be grateful for Your favor which You have bestowed upon me."',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.homeCardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.homeCardBorder,
            width: 1.2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background Islamic Art on the Right
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                width: 150,
                child: CustomPaint(
                  painter: _QuranStandPainter(),
                ),
              ),

              // Gradient fade over the background artwork
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.homeCardBg,
                        AppColors.homeCardBg.withValues(alpha: 0.95),
                        AppColors.homeCardBg.withValues(alpha: 0.60),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.50, 0.75, 1.0],
                    ),
                  ),
                ),
              ),

              // Content Overlaid
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 16,
                          color: AppColors.brandLime,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          reference,
                          style: const TextStyle(
                            color: AppColors.textDarkMuted,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Arabic Ayah
                    Text(
                      arabicText,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Translation container box (amber tint matching Figma)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x2B3F3118),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0x38755627),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        translation,
                        style: const TextStyle(
                          color: Color(0xFFD6C197),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          height: 1.35,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Artistic painter rendering an open Quran on a wooden carved Rehal stand.
class _QuranStandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Wood colors
    final woodPaint = Paint()
      ..color = const Color(0xFF332115)
      ..style = PaintingStyle.fill;

    // Crossed Rehal legs
    final rehalPath = Path();
    rehalPath.moveTo(w * 0.3, h * 0.85);
    rehalPath.lineTo(w * 0.85, h * 0.35);
    rehalPath.lineTo(w * 0.92, h * 0.42);
    rehalPath.lineTo(w * 0.37, h * 0.92);
    rehalPath.close();

    rehalPath.moveTo(w * 0.85, h * 0.85);
    rehalPath.lineTo(w * 0.3, h * 0.35);
    rehalPath.lineTo(w * 0.37, h * 0.28);
    rehalPath.lineTo(w * 0.92, h * 0.78);
    rehalPath.close();

    canvas.drawPath(rehalPath, woodPaint);

    // Open Quran Book Pages
    final bookPaint = Paint()
      ..color = const Color(0xFF42372A)
      ..style = PaintingStyle.fill;

    final bookPath = Path();
    bookPath.moveTo(w * 0.58, h * 0.40); // spine
    bookPath.quadraticBezierTo(w * 0.40, h * 0.34, w * 0.25, h * 0.42);
    bookPath.lineTo(w * 0.25, h * 0.65);
    bookPath.quadraticBezierTo(w * 0.40, h * 0.58, w * 0.58, h * 0.66);
    bookPath.close();

    bookPath.moveTo(w * 0.58, h * 0.40);
    bookPath.quadraticBezierTo(w * 0.76, h * 0.34, w * 0.92, h * 0.42);
    bookPath.lineTo(w * 0.92, h * 0.65);
    bookPath.quadraticBezierTo(w * 0.76, h * 0.58, w * 0.58, h * 0.66);
    bookPath.close();

    canvas.drawPath(bookPath, bookPaint);

    // Golden bookmark ribbon
    final ribbonPaint = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: 0.6)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final ribbonPath = Path();
    ribbonPath.moveTo(w * 0.58, h * 0.40);
    ribbonPath.quadraticBezierTo(w * 0.60, h * 0.60, w * 0.55, h * 0.78);
    canvas.drawPath(ribbonPath, ribbonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
