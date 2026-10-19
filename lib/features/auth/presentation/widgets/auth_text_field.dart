import 'package:flutter/material.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above field (shown when filled or focused, matching Figma)
        if (hasText || _isFocused) ...[
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Focus(
          onFocusChange: (focused) {
            setState(() {
              _isFocused = focused;
            });
          },
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.inputBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: _isFocused ? AppColors.brandLime : AppColors.inputBorder,
                width: _isFocused ? 1.5 : 1.2,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword && _obscureText,
              keyboardType: widget.keyboardType,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: AppColors.brandLime,
              onChanged: (val) {
                setState(() {});
                widget.onChanged?.call(val);
              },
              decoration: InputDecoration(
                hintText: (hasText || _isFocused) ? '' : (widget.hintText ?? widget.label),
                hintStyle: const TextStyle(
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
                          color: const Color(0xFF6B7A72),
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
        ),
      ],
    );
  }
}
