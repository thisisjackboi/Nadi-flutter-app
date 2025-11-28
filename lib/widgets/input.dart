import 'package:flutter/material.dart';
import '../theme.dart';

class NadiInput extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final String value;
  final ValueChanged<String> onChange;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool autoFocus;
  final Widget? prefixIcon;
  final TextAlign textAlign;
  final TextStyle? style;

  const NadiInput({
    super.key,
    this.label,
    this.placeholder,
    required this.value,
    required this.onChange,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.autoFocus = false,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            controller: TextEditingController(text: value)
              ..selection = TextSelection.fromPosition(TextPosition(offset: value.length)),
            onChanged: onChange,
            keyboardType: keyboardType,
            maxLength: maxLength,
            autofocus: autoFocus,
            textAlign: textAlign,
            style: style ?? const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              counterText: "", // Hide character counter
              prefixIcon: prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
