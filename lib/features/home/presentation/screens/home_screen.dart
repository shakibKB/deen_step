import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/abundance_verse_card.dart';
import '../widgets/ai_reflection_card.dart';
import '../widgets/home_bottom_nav_bar.dart';
import '../widgets/islamic_header_card.dart';
import '../widgets/permission_prompt_dialog.dart';
import '../widgets/prayer_check_card.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/stat_cards_row.dart';

/// The Main Dashboard and Navigation screen.
/// Implements the pixel-perfect Figma design with atmospheric Islamic header,
/// prayer tracking cards, AI reflection, abundance verse, quick actions, and bottom navigation.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  String _selectedPrayer = 'Dhuhr';

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeDashboardRequested());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNotificationPrompt();
    });
  }

  void _checkNotificationPrompt() {
    final state = context.read<HomeBloc>().state;
    if (state.shouldShowNotificationPrompt) {
      _showPermissionDialog(type: PermissionType.location);
    }
  }

  void _showPermissionDialog({PermissionType type = PermissionType.location}) {
    PermissionPromptDialog.show(
      context: context,
      type: type,
      onEnable: () {
        context
            .read<HomeBloc>()
            .add(const HomeNotificationPermissionPromptDismissed());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.homeCardBg,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: AppColors.homeCardBorder,
              ),
            ),
            content: Text(
              type == PermissionType.location
                  ? 'Location enabled successfully!'
                  : 'Notification enabled successfully!',
              style: const TextStyle(
                color: AppColors.brandLime,
                fontWeight: FontWeight.w600,
              ),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      onDismiss: () {
        context
            .read<HomeBloc>()
            .add(const HomeNotificationPermissionPromptDismissed());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          // Tab 0: Home Screen
          _buildHomeTab(context),

          // Tab 1: Community
          _buildPlaceholderTab(
            title: 'Community',
            icon: Icons.groups_rounded,
            description: 'Connect with fellow Muslims and share spiritual milestones.',
          ),

          // Tab 2: Reflect
          _buildPlaceholderTab(
            title: 'Reflections',
            icon: Icons.menu_book_rounded,
            description: 'Journal your Quran reflections and spiritual notes.',
          ),

          // Tab 3: Prayer
          _buildPlaceholderTab(
            title: 'Prayer Tracker',
            icon: Icons.bookmarks_rounded,
            description: 'View monthly prayer times and comprehensive logs.',
          ),

          // Tab 4: Profile
          _buildPlaceholderTab(
            title: 'Profile & Settings',
            icon: Icons.person_rounded,
            description: 'Manage your spiritual goals, preferences, and account.',
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentTabIndex,
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
    );
  }

  /// The complete Home Tab matching the screenshot with all components.
  Widget _buildHomeTab(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final data = state.dashboard;

        return RefreshIndicator(
          color: AppColors.brandLime,
          backgroundColor: AppColors.homeCardBg,
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeDashboardRequested());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Atmospheric Mosque Scenery Header
                IslamicHeaderCard(
                  location: data?.location ?? 'Gulshan, Dhaka',
                  hijriDate: data?.hijriDate ?? '3 Jumada Al-Awwal, 1447 H',
                  time: '18:55',
                  date: 'Sat, 25 Oct 2025',
                  nextPrayerCountdown: 'Maghrib in 0h 29m 3s left',
                  selectedPrayer: _selectedPrayer,
                  onPrayerSelected: (prayer) {
                    setState(() {
                      _selectedPrayer = prayer;
                    });
                  },
                  onLocationTap: () {
                    _showPermissionDialog(type: PermissionType.location);
                  },
                ),
                const SizedBox(height: 16),

                // 2. Card Content Body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // "Have you prayed Dhuhr?" Card
                      PrayerCheckCard(
                        prayerName: _selectedPrayer,
                        completedCount: data?.dailyGoalProgress ?? 2,
                        totalCount: 5,
                        onToggle: () {
                          // Feedback indicator
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.homeCardBg,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: AppColors.homeCardBorder,
                                ),
                              ),
                              content: Text(
                                'Alhamdulillah! $_selectedPrayer prayer tracked.',
                                style: const TextStyle(
                                  color: AppColors.brandLime,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // Daily Goal & Current Streak Row
                      StatCardsRow(
                        dailyGoalProgress: data?.dailyGoalProgress ?? 0,
                        dailyGoalTarget: 5,
                        streakDays: data?.streakDays ?? 0,
                      ),
                      const SizedBox(height: 14),

                      // AI Reflection Card
                      AiReflectionCard(
                        message: data?.dailyReflection,
                      ),
                      const SizedBox(height: 14),

                      // Abundance Verse Card
                      AbundanceVerseCard(
                        onTap: () {
                          // Action when tapping verse
                        },
                      ),
                      const SizedBox(height: 14),

                      // Quick Actions (Qibla, Hijri, Zakat, Times)
                      QuickActionsRow(
                        onActionTap: (action) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.homeCardBg,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: AppColors.homeCardBorder,
                                ),
                              ),
                              content: Text(
                                '$action feature opened',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Placeholder tab for the other 4 bottom navigation items.
  Widget _buildPlaceholderTab({
    required String title,
    required IconData icon,
    required String description,
  }) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.homeCardBg,
                  border: Border.all(
                    color: AppColors.homeCardBorder,
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: AppColors.brandLime,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textMutedGreen,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
