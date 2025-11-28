import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../types.dart';
import '../constants.dart';
import '../widgets/button.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;
  final Language lang;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.onLogout,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    // final t = TRANSLATIONS[lang]!; // Unused for now in this snippet but good to have

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 100),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 128,
                  decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(0.2),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.orange, width: 4),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: const Icon(LucideIcons.user, size: 40, color: AppColors.orange),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name ?? "Citizen",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.text),
                    ),
                    Text(
                      "+91 ${user.phoneNumber}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            _buildProfileItem(
              icon: LucideIcons.checkCircle,
              iconColor: AppColors.green,
              bg: Colors.green[50]!,
              label: "Identity Status",
              value: "Verified",
              valueColor: Colors.white,
              valueBg: AppColors.green,
            ),
            const SizedBox(height: 12),
            _buildProfileItem(
              icon: LucideIcons.globe,
              iconColor: AppColors.orange,
              bg: Colors.orange[50]!,
              label: "Language",
              value: lang.toString().split('.').last,
              valueColor: Colors.grey,
              valueBg: Colors.transparent,
            ),

            const SizedBox(height: 48),
            NadiButton(
              text: "Sign Out",
              variant: ButtonVariant.outline,
              fullWidth: true,
              icon: const Icon(LucideIcons.logOut, size: 20, color: Colors.red),
              onPressed: onLogout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required Color iconColor,
    required Color bg,
    required String label,
    required String value,
    required Color valueColor,
    required Color valueBg,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: valueBg, borderRadius: BorderRadius.circular(4)),
            child: Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: valueColor)),
          ),
        ],
      ),
    );
  }
}
