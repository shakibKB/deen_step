import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

/// The "ABUNDANCE VERSE" card matching the exact Figma design.
/// Features a dark rounded card, neon lime book icon, title, Hadith reference,
/// reflection prompt, and bookshelf illustration with space at the bottom.
class AbundanceVerseCard extends StatelessWidget {
  final String title;
  final String reference;
  final String description;
  final String? arabicText;
  final VoidCallback? onTap;

  const AbundanceVerseCard({
    super.key,
    this.title = 'ABUNDANCE VERSE',
    this.reference = 'Sahih al-Bukhari, 6412',
    this.description = 'Start your daily verse by input them in reflections.',
    this.arabicText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF111A14),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFF1E2E23),
            width: 1.2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // 1. Bookshelf artwork with space at the bottom (matching Figma)
              Positioned(
                top: 0,
                right: 0,
                bottom: 24,
                width: 125,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AppAssets.abundanceVerseBg,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                      ),
                      // Soft gradient blend on the left edge
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              const Color(0xFF111A14),
                              const Color(0xFF111A14).withValues(alpha: 0.5),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.35, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Card Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Row: Book icon + Title + Reference
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 18,
                          color: AppColors.brandLime,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            reference,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFFD6DFD9),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Body Description
                    Padding(
                      padding: const EdgeInsets.only(right: 75),
                      child: Text(
                        description,
                        style: const TextStyle(
                          color: Color(0xFF8A9A90),
                          fontSize: 14.5,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    if (arabicText != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        arabicText!,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
