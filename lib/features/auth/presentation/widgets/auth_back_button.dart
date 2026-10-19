import 'package:flutter/material.dart';

class AuthBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AuthBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF1B201C),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF262E28),
            width: 1.2,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.chevron_left_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
