import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class BottomNavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const BottomNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

/// The sleek dark bottom navigation bar matching the design.
/// Features 5 tabs: Home, Community, Reflect, Prayer, Profile,
/// with the bottom gesture home indicator bar.
class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    final items = const [
      BottomNavItem(
        label: 'Home',
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
      ),
      BottomNavItem(
        label: 'Community',
        icon: Icons.groups_outlined,
        activeIcon: Icons.groups_rounded,
      ),
      BottomNavItem(
        label: 'Reflect',
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book_rounded,
      ),
      BottomNavItem(
        label: 'Prayer',
        icon: Icons.bookmarks_outlined,
        activeIcon: Icons.bookmarks_rounded,
      ),
      BottomNavItem(
        label: 'Profile',
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF09120C),
        border: Border(
          top: BorderSide(
            color: Color(0xFF16251C),
            width: 1.2,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isSelected = index == currentIndex;

                  return GestureDetector(
                    onTap: () => onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox(
                      width: 64,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? item.activeIcon : item.icon,
                            size: 24,
                            color: isSelected
                                ? AppColors.brandLime
                                : const Color(0xFF67786E),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.brandLime
                                  : const Color(0xFF67786E),
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Bottom Home Gesture Indicator Pill
            if (bottomInset > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Container(
                  width: 135,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF45554B),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
