import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_loading_indicator.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/notification_permission_sheet.dart';

/// Home Screen foundation.
/// Clean, maintainable UI layout ready for pixel-perfect Figma styling.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (bottomSheetContext) => NotificationPermissionSheet(
          onEnable: () {
            Navigator.of(bottomSheetContext).pop();
            context
                .read<HomeBloc>()
                .add(const HomeNotificationPermissionPromptDismissed());
          },
          onDismiss: () {
            Navigator.of(bottomSheetContext).pop();
            context
                .read<HomeBloc>()
                .add(const HomeNotificationPermissionPromptDismissed());
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              _checkNotificationPrompt();
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status == HomeStatus.loading || state.dashboard == null) {
            return const AppLoadingIndicator();
          }

          final data = state.dashboard!;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const HomeDashboardRequested());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.paddingPage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hijri Date & Location Card
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            data.location,
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Text(
                        data.hijriDate,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Next Prayer Banner Card
                  AppCard(
                    color: AppColors.primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          AppStrings.nextPrayer,
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.nextPrayerName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '-${data.nextPrayerTimeRemaining}',
                              style: const TextStyle(
                                color: AppColors.accentLight,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Today's 5 Prayers List
                  Text(
                    AppStrings.todayPrayers,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...data.prayers.map((prayer) {
                    final isCompleted = prayer.status == 'completed';
                    final isOngoing = prayer.status == 'ongoing';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: AppCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isCompleted
                                      ? Icons.check_circle_rounded
                                      : (isOngoing
                                          ? Icons.radio_button_checked_rounded
                                          : Icons.radio_button_unchecked_rounded),
                                  color: isCompleted
                                      ? AppColors.success
                                      : (isOngoing
                                          ? AppColors.primary
                                          : AppColors.borderLight),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Text(
                                  prayer.name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: isOngoing
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              prayer.time,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: AppSpacing.lg),

                  // Daily Reflection Card
                  if (data.dailyReflection != null) ...[
                    Text(
                      AppStrings.dailyReflection,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppCard(
                      child: Text(
                        data.dailyReflection!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
