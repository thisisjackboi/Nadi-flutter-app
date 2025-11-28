import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../types.dart';
import '../constants.dart';
import '../widgets/politician_avatar.dart';
import '../widgets/marketing_card.dart';
import '../widgets/button.dart';

class DashboardScreen extends StatelessWidget {
  final User user;
  final List<Grievance> grievances;
  final Function(Grievance) onGrievanceClick;
  final VoidCallback onViewAll;
  final Language lang;

  const DashboardScreen({
    super.key,
    required this.user,
    required this.grievances,
    required this.onGrievanceClick,
    required this.onViewAll,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    final t = TRANSLATIONS[lang]!;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Space for BottomNav
        child: Column(
          children: [
            // Header Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.orange, Color(0xFFFF9933), Colors.orangeAccent],
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -40,
                    top: -40,
                    child: Opacity(
                      opacity: 0.1,
                      child: const PoliticianAvatar(size: 300),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 24, 24, 64),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${t['namaskar']},",
                                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  user.name ?? t['citizen']!,
                                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                _buildHeaderIcon(LucideIcons.globe),
                                const SizedBox(width: 8),
                                _buildHeaderIcon(LucideIcons.bell),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Hero Card
                        Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  "https://i.ibb.co/gFZtW6N/Designer-1.jpg",
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => const Icon(Icons.person, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "\"Sabka Saath,\nSabka Vikas\"",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.1),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Hon'ble Minister",
                                  style: TextStyle(color: Colors.orange[100], fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Main Content - Overlapping
            Transform.translate(
              offset: const Offset(0, -40),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Quick Actions
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                        border: Border.all(color: Colors.grey[100]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildQuickAction(LucideIcons.trendingUp, "Progress", AppColors.green, Colors.green[50]!),
                          _buildQuickAction(LucideIcons.award, "Schemes", AppColors.orange, Colors.orange[50]!),
                          _buildQuickAction(LucideIcons.playCircle, "Live", Colors.blue, Colors.blue[50]!),
                          _buildQuickAction(LucideIcons.heart, "Donate", Colors.red, Colors.red[50]!),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Marketing Scroll
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(width: 4, height: 24, decoration: BoxDecoration(color: AppColors.orange, borderRadius: BorderRadius.circular(2))),
                              const SizedBox(width: 8),
                              Text(t['marketingTitle']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text)),
                            ],
                          ),
                          const Icon(LucideIcons.chevronRight, color: Colors.grey, size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: MARKETING_UPDATES.map((update) {
                          final titleMap = update['title'] as Map<Language, String>;
                          return MarketingCard(
                            title: titleMap[lang] ?? titleMap[Language.ENGLISH]!,
                            image: update['image'],
                            date: update['date'],
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Grievances
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.grey[100]!),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(t['myGrievances']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.text)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                                child: Text("${grievances.length} Active", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...grievances.take(2).map((g) => _buildGrievanceItem(g)),
                          const SizedBox(height: 16),
                          NadiButton(
                            text: "View All Reports",
                            variant: ButtonVariant.outline,
                            fullWidth: true,
                            onPressed: onViewAll,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrievanceItem(Grievance g) {
    return GestureDetector(
      onTap: () => onGrievanceClick(g),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[100]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Text(CATEGORY_ICONS[g.category] ?? '📝', style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(g.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text(g.dateSubmitted, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: g.status == GrievanceStatus.RESOLVED ? AppColors.green : AppColors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color, Color bg) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
