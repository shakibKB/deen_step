import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';

class NotificationPermissionSheet extends StatelessWidget {
  final VoidCallback onEnable;
  final VoidCallback onDismiss;

  const NotificationPermissionSheet({
    super.key,
    required this.onEnable,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: AppSpacing.paddingPage,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            const CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.primaryContainer,
              child: Icon(
                Icons.notifications_active_outlined,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              AppStrings.notificationPermissionTitle,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppStrings.notificationPermissionDesc,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              text: AppStrings.enableNotifications,
              onPressed: onEnable,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: AppStrings.maybeLater,
              variant: AppButtonVariant.text,
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}
