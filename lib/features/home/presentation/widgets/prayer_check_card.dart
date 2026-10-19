import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// "Have you prayed Dhuhr?" interactive status card.
class PrayerCheckCard extends StatefulWidget {
  final String prayerName;
  final int completedCount;
  final int totalCount;
  final VoidCallback? onToggle;

  const PrayerCheckCard({
    super.key,
    this.prayerName = 'Dhuhr',
    this.completedCount = 2,
    this.totalCount = 5,
    this.onToggle,
  });

  @override
  State<PrayerCheckCard> createState() => _PrayerCheckCardState();
}

class _PrayerCheckCardState extends State<PrayerCheckCard> {
  bool _isMarked = false;

  @override
  Widget build(BuildContext context) {
    final currentCompleted =
        _isMarked ? widget.completedCount + 1 : widget.completedCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.homeCardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.homeCardBorder,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Have you prayed ${widget.prayerName}?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '$currentCompleted/${widget.totalCount} prayers tracked today',
                  style: const TextStyle(
                    color: AppColors.textDarkMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Action Button (Question mark / Checked)
          GestureDetector(
            onTap: () {
              setState(() {
                _isMarked = !_isMarked;
              });
              widget.onToggle?.call();
            },
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isMarked
                    ? AppColors.brandLime
                    : const Color(0xFF16251D),
                border: Border.all(
                  color: _isMarked
                      ? AppColors.brandLime
                      : const Color(0xFF26392D),
                  width: 1.5,
                ),
                boxShadow: _isMarked
                    ? [
                        BoxShadow(
                          color: AppColors.brandLime.withValues(alpha: 0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: _isMarked
                  ? const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF111814),
                      size: 20,
                    )
                  : const Text(
                      '?',
                      style: TextStyle(
                        color: AppColors.brandLime,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
