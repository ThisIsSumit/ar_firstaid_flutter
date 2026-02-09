import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers/emergency_provider.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';

class SeveritySelectorPage extends ConsumerWidget {
  const SeveritySelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emergencyState = ref.watch(emergencyProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Select Severity'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (emergencyState.type != null)
              Text(
                emergencyState.type!.displayName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 8),
            const Text(
              'How urgent is this situation?',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
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

  Color get _accent {
    switch (level) {
      case SeverityLevel.low:
        return const Color(0xFF22C55E);
      case SeverityLevel.medium:
        return const Color(0xFFF59E0B);
      case SeverityLevel.high:
        return const Color(0xFFEF4444);
      case SeverityLevel.critical:
        return const Color(0xFFB91C1C);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? _accent : Colors.white12,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  level.displayName,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
