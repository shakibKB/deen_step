import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

enum PermissionType {
  location,
  notification,
}

/// Modal Permission Dialog matching the exact Figma/image design.
/// Features a dark rounded card, circular icon badge, bold title,
/// highlighted RichText description, and vibrant neon lime action button.
/// Includes a signature frosted white shadow background overlay over the home screen.
class PermissionPromptDialog extends StatelessWidget {
  final PermissionType type;
  final VoidCallback onEnable;
  final VoidCallback? onDismiss;

  const PermissionPromptDialog({
    super.key,
    this.type = PermissionType.location,
    required this.onEnable,
    this.onDismiss,
  });

  /// Displays the dialog with a signature translucent white shadow / frosted background overlay.
  static Future<bool?> show({
    required BuildContext context,
    PermissionType type = PermissionType.location,
    required VoidCallback onEnable,
    VoidCallback? onDismiss,
    bool barrierDismissible = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.white.withValues(alpha: 0.40),
      builder: (dialogContext) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: PermissionPromptDialog(
          type: type,
          onEnable: () {
            Navigator.of(dialogContext).pop(true);
            onEnable();
          },
          onDismiss: () {
            Navigator.of(dialogContext).pop(false);
            onDismiss?.call();
          },
        ),
      ),
    );

    if (result == null && onDismiss != null) {
      onDismiss();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final isLocation = type == PermissionType.location;

    final title = isLocation ? 'Enable Location' : 'Enable Notification';
    final buttonText =
        isLocation ? 'Turn On Location' : 'Turn On Notification';

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 34),
        decoration: BoxDecoration(
          color: const Color(0xFF111A14),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: const Color(0xFF1E2E23),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 30,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Circular Icon Badge
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF16251C),
                border: Border.all(
                  color: const Color(0xFF243B2D),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: isLocation
                    ? Image.asset(
                        AppAssets.locationPin,
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                      )
                    : const Icon(
                        Icons.notifications_none_rounded,
                        size: 28,
                        color: AppColors.brandLime,
                      ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),

            // Description with highlighted words
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: isLocation
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFF9EAAA0),
                          fontSize: 13.5,
                          height: 1.48,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'To provide you with highly accurate prayer times and the correct Qibla direction, ',
                          ),
                          TextSpan(
                            text: 'We need to access',
                            style: TextStyle(
                              color: AppColors.brandLime,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: " your device's location.",
                          ),
                        ],
                      ),
                    )
                  : RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFF9EAAA0),
                          fontSize: 13.5,
                          height: 1.48,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text:
                                'To provide you with timely prayer reminders and Adhan alerts, ',
                          ),
                          TextSpan(
                            text: 'We need to send',
                            style: TextStyle(
                              color: AppColors.brandLime,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' notifications to your device.',
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 30),

            // Main Action Button (Neon Lime)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: onEnable,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandLime,
                  foregroundColor: const Color(0xFF111814),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Color(0xFF111814),
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
