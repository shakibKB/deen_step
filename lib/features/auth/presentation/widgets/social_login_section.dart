import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  const SocialLoginSection({
    super.key,
    this.onGoogleTap,
    this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with OR
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFF263029),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'OR',
                style: TextStyle(
                  color: Color(0xFF6B7A72),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFF263029),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // "Log In With" Label
        const Text(
          'Log In With',
          style: TextStyle(
            color: Color(0xFF8A9890),
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Social Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Google Button (White squircle)
            GestureDetector(
              onTap: onGoogleTap,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.network(
                    'https://www.gstatic.com/images/branding/product/2x/googleg_48dp.png',
                    width: 22,
                    height: 22,
                    errorBuilder: (_, _, _) => const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Apple Button (Dark squircle)
            GestureDetector(
              onTap: onAppleTap,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B201D),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF29332C),
                    width: 1.2,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.apple,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
