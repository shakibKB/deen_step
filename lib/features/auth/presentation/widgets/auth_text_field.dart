import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;
    final isActive = _isFocused || hasText;
    final showTitle = _isFocused || hasText;

    // Default: fillColor: 1A1A1A, border: 0F0F0F
    // When selected/typing: transparent (background color) with visible border line
    final fillColor = isActive ? Colors.transparent : const Color(0xFF1A1A1A);
    final borderColor = isActive
        ? const Color(0xFF2C2E2D)
        : const Color(0xFF0F0F0F);

    return Focus(
      onFocusChange: (focused) {
        setState(() {
          _isFocused = focused;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title label above field (shows when selected or has text)
          if (showTitle) ...[
            Text(
              widget.label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
          ],
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 54,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: borderColor, width: 1.2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword && _obscureText,
              keyboardType: widget.keyboardType,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.w400,
              ),
              cursorColor: Colors.white,
              onChanged: (val) {
                setState(() {});
                widget.onChanged?.call(val);
              },
              decoration: InputDecoration(
                fillColor: fillColor,
                filled: true,
                hintText: showTitle ? '' : (widget.hintText ?? widget.label),
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.inputHint,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                suffixIcon: widget.isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Color(0xFF6B7280),
                          size: 20,
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
