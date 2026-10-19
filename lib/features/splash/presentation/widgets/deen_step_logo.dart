import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';

/// The official Deen-Step brand logo icon.
/// Displays the exact brand mark asset with subtle neon lime glow.
class DeenStepLogo extends StatelessWidget {
  final double size;

  const DeenStepLogo({super.key, this.size = 64.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        AppAssets.logo,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
