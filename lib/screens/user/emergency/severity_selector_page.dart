import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/emergency_provider.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';

class SeveritySelectorPage extends ConsumerWidget {
  const SeveritySelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emergencyState = ref.watch(emergencyProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A0D0D), // Very dark reddish background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Select Severity',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: TextButton.icon(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left, color: Color(0xFFEF4444)),
          label: const Text(
            'Back',
            style: TextStyle(color: Color(0xFFEF4444), fontSize: 16),
          ),
        ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'How urgent is it?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Identify the patient's current state to expedite response.",
              style: TextStyle(color: Color(0xFF991B1B), fontSize: 16),
            ),
            const SizedBox(height: 32),
            ...SeverityLevel.values.map(
              (level) => _SeverityCard(
                level: level,
                isSelected: emergencyState.severity == level,
                onTap: () {
                  ref.read(emergencyProvider.notifier).selectSeverity(level);
                  context.push(AppRoutes.emergencyConfirmation);
                },
              ),
            ),
            const SizedBox(height: 24),
            _InfoWarningBox(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _SeverityCard extends StatelessWidget {
  final SeverityLevel level;
  final bool isSelected;
  final VoidCallback onTap;

  const _SeverityCard({
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  Color get _color {
    switch (level) {
      case SeverityLevel.critical: return const Color(0xFFEF4444);
      case SeverityLevel.high: return const Color(0xFFF59E0B);
      case SeverityLevel.medium: return const Color(0xFFFACC15);
      case SeverityLevel.low: return const Color(0xFF22C55E);
    }
  }

  String get _description {
    switch (level) {
      case SeverityLevel.critical: return "Life-threatening. Unconscious, no breathing, or severe bleeding.";
      case SeverityLevel.high: return "Serious urgency. Chest pain, broken limbs, or high fever.";
      case SeverityLevel.medium: return "Moderate urgency. Stable condition, significant pain or discomfort.";
      case SeverityLevel.low: return "Minor issues. Non-emergency assistance or basic first aid needed.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2D1A1A),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _color.withOpacity(isSelected ? 1.0 : 0.3),
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.name.toUpperCase(),
                      style: TextStyle(
                        color: _color,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: _color.withOpacity(0.5), size: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoWarningBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2D1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: Color(0xFFEF4444), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 13, height: 1.5),
                children: [
                  TextSpan(text: 'If you are unsure, choose '),
                  TextSpan(
                    text: 'CRITICAL',
                    style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '. Response teams prioritize safety over speed when information is limited.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}