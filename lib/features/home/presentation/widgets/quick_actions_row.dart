import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class QuickActionItem {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color circleBg;
  final Color circleBorder;
  final VoidCallback? onTap;

  const QuickActionItem({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.circleBg,
    required this.circleBorder,
    this.onTap,
  });
}

/// The row of 4 quick Islamic feature actions: Qibla, Hijri, Zakat, Times.
class QuickActionsRow extends StatelessWidget {
  final ValueChanged<String>? onActionTap;

  const QuickActionsRow({
    super.key,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickActionItem(
        label: 'Qibla',
        icon: Icons.explore_rounded,
        iconColor: AppColors.brandLime,
        circleBg: const Color(0xFF16291F),
        circleBorder: const Color(0xFF223A2C),
        onTap: () => onActionTap?.call('Qibla'),
      ),
      QuickActionItem(
        label: 'Hijri',
        icon: Icons.nightlight_round,
        iconColor: const Color(0xFF64B5F6),
        circleBg: const Color(0xFF142433),
        circleBorder: const Color(0xFF1E3547),
        onTap: () => onActionTap?.call('Hijri'),
      ),
      QuickActionItem(
        label: 'Zakat',
        icon: Icons.attach_money_rounded,
        iconColor: const Color(0xFFFFB300),
        circleBg: const Color(0xFF2B2314),
        circleBorder: const Color(0xFF3F341F),
        onTap: () => onActionTap?.call('Zakat'),
      ),
      QuickActionItem(
        label: 'Times',
        icon: Icons.calendar_month_rounded,
        iconColor: const Color(0xFFF06292),
        circleBg: const Color(0xFF2B1824),
        circleBorder: const Color(0xFF3E2335),
        onTap: () => onActionTap?.call('Times'),
      ),
    ];

    return Row(
      children: actions.map((item) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: item.onTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.homeCardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.homeCardBorder,
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon Circle Badge
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.circleBg,
                        border: Border.all(
                          color: item.circleBorder,
                          width: 1.2,
                        ),
                      ),
                      child: Icon(
                        item.icon,
                        size: 20,
                        color: item.iconColor,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Label
                    Text(
                      item.label,
                      style: const TextStyle(
                        color: Color(0xFF9EAAA0),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
