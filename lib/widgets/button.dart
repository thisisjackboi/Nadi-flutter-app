import 'package:flutter/material.dart';
import '../theme.dart';

enum ButtonVariant { primary, secondary, outline, ghost, success }

class NadiButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final bool fullWidth;
  final bool isLoading;
  final bool disabled;
  final Widget? icon;

  const NadiButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.fullWidth = false,
    this.isLoading = false,
    this.disabled = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color? borderColor;
    double elevation = 0;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = AppColors.orange;
        textColor = Colors.white;
        elevation = 4;
        break;
      case ButtonVariant.secondary:
        backgroundColor = Colors.white;
        textColor = AppColors.orange;
        borderColor = AppColors.orange;
        break;
      case ButtonVariant.success:
        backgroundColor = AppColors.green;
        textColor = Colors.white;
        elevation = 4;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.white;
        textColor = Colors.grey[600]!;
        borderColor = Colors.grey[300];
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        textColor = AppColors.lightText;
        break;
    }

    if (disabled) {
      backgroundColor = backgroundColor.withOpacity(0.5);
      textColor = textColor.withOpacity(0.5);
      borderColor = borderColor?.withOpacity(0.5);
      elevation = 0;
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed:  onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: elevation,
          shadowColor: variant == ButtonVariant.primary ? Colors.orange[200] : (variant == ButtonVariant.success ? Colors.green[200] : null),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null ? BorderSide(color: borderColor, width: 2) : BorderSide.none,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[icon!, const SizedBox(width: 8)],
                  Text(
                    text,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
      ),
    );
  }
}
