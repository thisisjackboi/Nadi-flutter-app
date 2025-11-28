import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../types.dart';
import '../constants.dart';
import '../widgets/header.dart';
import '../widgets/button.dart';
import '../widgets/input.dart';

class SubmitGrievanceScreen extends StatefulWidget {
  final VoidCallback onClose;
  final Function(PartialGrievance) onSubmit;
  final Language lang;

  const SubmitGrievanceScreen({
    super.key,
    required this.onClose,
    required this.onSubmit,
    required this.lang,
  });

  @override
  State<SubmitGrievanceScreen> createState() => _SubmitGrievanceScreenState();
}

// Helper class for partial grievance data
class PartialGrievance {
  String? title;
  String? description;
  GrievanceCategory? category;
  String? location;
  String? imageUrl;
  bool? isAnonymous;

  PartialGrievance({
    this.title,
    this.description,
    this.category,
    this.location,
    this.imageUrl,
    this.isAnonymous,
  });
}

class _SubmitGrievanceScreenState extends State<SubmitGrievanceScreen> {
  int _step = 1;
  String? _image; // In real app, this would be a File path or XFile
  String _desc = '';
  GrievanceCategory? _category;
  bool _isAnon = false;
  bool _isLocating = false;
  String _location = '';

  void _handleImageUpload() {
    // Mock image upload
    setState(() {
      _image = "https://picsum.photos/400/300"; // Mock image
    });
  }

  void _handleLocation() {
    setState(() => _isLocating = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _location = "Dispur, Guwahati";
          _isLocating = false;
        });
      }
    });
  }

  void _handleSubmit() {
    if (_category == null) return;
    widget.onSubmit(PartialGrievance(
      title: "${_category.toString().split('.').last} Issue",
      description: _desc,
      category: _category,
      location: _location.isEmpty ? "Unknown" : _location,
      imageUrl: _image,
      isAnonymous: _isAnon,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final t = TRANSLATIONS[widget.lang]!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Header(
            title: _step == 1 ? t['evidence']! : (_step == 2 ? "Details" : "Review"),
            onBack: _step == 1 ? widget.onClose : () => setState(() => _step--),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Progress Bar
                  Row(
                    children: [1, 2, 3].map((i) => Expanded(
                      child: Container(
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: i <= _step ? AppColors.orange : Colors.grey[100],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 32),

                  if (_step == 1) ...[
                    GestureDetector(
                      onTap: _handleImageUpload,
                      child: Container(
                        width: double.infinity,
                        height: 4 / 5,
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.orange[200]!, style: BorderStyle.solid), // Dashed border needs custom painter
                        ),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(_image!, fit: BoxFit.cover),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
                                    child: const Icon(LucideIcons.camera, size: 32, color: AppColors.orange),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text("Take Photo", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.orangeDark)),
                                  const SizedBox(height: 4),
                                  const Text("Tap to capture or upload", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                      ),
                    ),
                  ],

                  if (_step == 2) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t['category']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        const SizedBox(height: 12),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          physics: const NeverScrollableScrollPhysics(),
                          children: GrievanceCategory.values.map((cat) {
                            final isSelected = _category == cat;
                            return GestureDetector(
                              onTap: () => setState(() => _category = cat),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.orange[50] : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isSelected ? AppColors.orange : Colors.grey[100]!),
                                  boxShadow: isSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(CATEGORY_ICONS[cat] ?? '', style: const TextStyle(fontSize: 24)),
                                    const SizedBox(height: 8),
                                    Text(
                                      cat.toString().split('.').last,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? AppColors.orangeDark : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        NadiInput(
                          label: t['description'],
                          placeholder: "Describe the issue...",
                          value: _desc,
                          onChange: (val) => setState(() => _desc = val),
                        ),
                        const SizedBox(height: 24),
                        Text(t['location']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _handleLocation,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isLocating)
                                  const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                                else
                                  const Icon(LucideIcons.mapPin, color: AppColors.orange, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  _location.isNotEmpty ? _location : "Detect My Location",
                                  style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  if (_step == 3) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[100]!),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                      ),
                      child: Row(
                        children: [
                          if (_image != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(_image!, width: 96, height: 96, fit: BoxFit.cover),
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _category.toString().split('.').last,
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.orange, letterSpacing: 1),
                                ),
                                const SizedBox(height: 4),
                                Text(_desc, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(LucideIcons.shieldCheck, color: _isAnon ? AppColors.green : Colors.grey),
                              const SizedBox(width: 12),
                              const Text("Submit Anonymously", style: TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Switch(
                            value: _isAnon,
                            onChanged: (val) => setState(() => _isAnon = val),
                            activeColor: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: NadiButton(
              text: _step == 3 ? t['submit']! : "Next",
              fullWidth: true,
              onPressed: () {
                if (_step < 3) {
                  setState(() => _step++);
                } else {
                  _handleSubmit();
                }
              },
              disabled: (_step == 1 && _image == null) || (_step == 2 && (_category == null || _desc.isEmpty || _location.isEmpty)),
            ),
          ),
        ],
      ),
    );
  }
}
