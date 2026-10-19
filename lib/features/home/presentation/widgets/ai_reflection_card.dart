import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// The "AI REFLECTION" card displaying personalized spiritual encouragement.
class AiReflectionCard extends StatelessWidget {
  final String? message;

  const AiReflectionCard({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    const defaultText =
        'Assalamu alaikum! Welcome to your space for spiritual growth. Every big journey begins with a small step. Log your first prayer today to start building a beautiful, consistent habit';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.homeCardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.homeCardBorder,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                size: 16,
                color: AppColors.brandLime,
              ),
              const SizedBox(width: 8),
              const Text(
                'AI REFLECTION',
                style: TextStyle(
                  color: AppColors.brandLime,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const Spacer(),
              // Glowing green status dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.brandLime,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.brandLime.withValues(alpha: 0.6),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Message Body
          Text(
            message ?? defaultText,
            style: const TextStyle(
              color: AppColors.textMutedGreen,
              fontSize: 13.5,
              height: 1.48,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
