import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/widgets/glassmorphic_card.dart';

class ModuleDetailPage extends StatefulWidget {
  final String moduleId;

  const ModuleDetailPage({Key? key, required this.moduleId}) : super(key: key);

  @override
  State<ModuleDetailPage> createState() => _ModuleDetailPageState();
}

class _ModuleDetailPageState extends State<ModuleDetailPage> {
  int _currentStep = 0;

  final List<Map<String, String>> _steps = [
    {
      'title': 'Step 1: Check Responsiveness',
      'description':
          'Tap the person on the shoulder and ask loudly "Are you okay?"',
    },
    {
      'title': 'Step 2: Call Emergency',
      'description':
          'If no response, immediately call emergency services (911 in US)',
    },
    {
      'title': 'Step 3: Open Airways',
      'description': 'Tilt the head back slightly and lift the chin',
    },
    {
      'title': 'Step 4: Start Compressions',
      'description':
          'Place hands on center of chest and push hard, at least 2 inches deep',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0F),
        elevation: 0,
        title: Text(
          widget.moduleId,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video placeholder
                GlassmorphicCard(
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF5856D6),
                          const Color(0xFF00FF64).withOpacity(0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle,
                        color: Colors.white.withOpacity(0.5),
                        size: 56,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Training Steps',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ..._steps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final step = entry.value;
                  return _StepCard(
                    step: step,
                    index: index,
                    isActive: _currentStep == index,
                    onTap: () => setState(() => _currentStep = index),
                  );
                }),
                const SizedBox(height: 100),
              ],
            ),
          ),
          // Bottom action buttons
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: GlassmorphicCard(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    onTap: () =>
                        context.push('/ar-training/${widget.moduleId}'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.view_in_ar, color: Color(0xFF00FF64)),
                        SizedBox(width: 8),
                        Text(
                          'View in AR',
                          style: TextStyle(
                            color: Color(0xFF00FF64),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final Map<String, String> step;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const _StepCard({
    required this.step,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: onTap,
      opacity: isActive ? 0.15 : 0.08,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  isActive ? const Color(0xFF00FF64) : const Color(0xFF5856D6),
                  isActive
                      ? const Color(0xFF00FF64).withOpacity(0.5)
                      : const Color(0xFF5856D6).withOpacity(0.5),
                ],
              ),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['title']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  step['description']!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
