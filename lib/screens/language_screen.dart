import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../types.dart';

class LanguageScreen extends StatelessWidget {
  final Function(Language) onSelect;

  const LanguageScreen({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 8,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.orange, Colors.white, AppColors.green],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(LucideIcons.globe, size: 40, color: AppColors.orange),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Select Language",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Choose your preferred language / আপোনাৰ পছন্দৰ ভাষা বাছক",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.lightText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 48),
                _buildLanguageOption(
                  context,
                  label: "English",
                  color: AppColors.orange,
                  onTap: () => onSelect(Language.ENGLISH),
                ),
                const SizedBox(height: 16),
                _buildLanguageOption(
                  context,
                  label: "অসমীয়া",
                  color: AppColors.green,
                  onTap: () => onSelect(Language.ASSAMESE),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, {required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[100]!, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[200]!, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
