import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers/emergency_provider.dart';
import '../core/router/app_router.dart';
import '../core/theme/app_theme.dart';
import '../widgets/dialogs/emergency_dialogs.dart';

class EmergencyConfirmationPage extends ConsumerWidget {
  const EmergencyConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emergencyState = ref.watch(emergencyProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Confirm Emergency'),
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
            const Text(
              'Review your request',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _SummaryRow(
              label: 'Type',
              value: emergencyState.type?.displayName ?? 'Not set',
            ),
            _SummaryRow(
              label: 'Severity',
              value: emergencyState.severity?.displayName ?? 'Not set',
            ),
            const SizedBox(height: 24),
            const Text(
              'When you confirm, nearby responders will be alerted and live tracking will begin.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.4),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final confirmed =
                      await EmergencyDialogs.showConfirmEmergencyDialog(
                    context,
                    ref,
                  );
                  if (confirmed == true && context.mounted) {
                    context.push(AppRoutes.activeEmergency);
                  }
                },
                child: const Text('Confirm Emergency'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
