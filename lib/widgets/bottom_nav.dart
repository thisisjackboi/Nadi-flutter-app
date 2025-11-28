import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../types.dart';
import '../constants.dart';

class BottomNav extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;
  final Language lang;

  const BottomNav({
    super.key,
    required this.activeTab,
    required this.onTabChange,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    final t = TRANSLATIONS[lang]!;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 12,
        top: 12,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildNavItem(
            context,
            icon: LucideIcons.home,
            label: t['home']!,
            isActive: activeTab == 'home',
            onTap: () => onTabChange('home'),
          ),
          Transform.translate(
            offset: const Offset(0, -24),
            child: GestureDetector(
              onTap: () => onTabChange('submit'),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.orange, Colors.red],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(LucideIcons.plus, color: Colors.white, size: 32),
              ),
            ),
          ),
          _buildNavItem(
            context,
            icon: LucideIcons.user,
            label: t['profile']!,
            isActive: activeTab == 'profile',
            onTap: () => onTabChange('profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required IconData icon, required String label, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? AppColors.orange : Colors.grey[400],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.orange : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
