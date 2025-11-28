import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../types.dart';
import '../constants.dart';
import '../widgets/header.dart';

class GrievanceListScreen extends StatelessWidget {
  final List<Grievance> grievances;
  final VoidCallback onBack;
  final Function(Grievance) onGrievanceClick;
  final Language lang;

  const GrievanceListScreen({
    super.key,
    required this.grievances,
    required this.onBack,
    required this.onGrievanceClick,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    final t = TRANSLATIONS[lang]!;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Header(title: t['allGrievances']!, onBack: onBack),
          Expanded(
            child: grievances.isEmpty
                ? Center(child: Text(t['noGrievances']!, style: const TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: grievances.length,
                    itemBuilder: (context, index) {
                      final g = grievances[index];
                      return GestureDetector(
                        onTap: () => onGrievanceClick(g),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey[100]!),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
                                child: Text(CATEGORY_ICONS[g.category] ?? '📝', style: const TextStyle(fontSize: 24)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text(g.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
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
                                    const SizedBox(height: 4),
                                    Text(g.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(LucideIcons.clock, size: 12, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(g.dateSubmitted, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: g.status == GrievanceStatus.RESOLVED ? Colors.green[50] : Colors.orange[50],
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            g.status.toString().split('.').last,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: g.status == GrievanceStatus.RESOLVED ? Colors.green : Colors.orange,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
