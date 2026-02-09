import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/providers/emergency_provider.dart';

class EmergencyDialogs {
  static Future<bool?> showConfirmEmergencyDialog(
    BuildContext context,
    WidgetRef ref,
  ) {
    final emergencyState = ref.read(emergencyProvider);

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.primaryRed),
            SizedBox(width: 12),
            Text(
              'Confirm Emergency',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This will:',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            _buildItem(Icons.location_on, 'Share your location'),
            _buildItem(Icons.notifications_active, 'Alert nearby responders'),
            _buildItem(Icons.phone, 'Enable emergency communication'),
            if (emergencyState.type != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      emergencyState.type!.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      emergencyState.type!.displayName,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(emergencyProvider.notifier).confirmEmergency();
              Navigator.pop(context, true);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showCancelEmergencyDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Cancel Emergency?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'Responders will be notified that the situation is resolved.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Keep Active',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Cancel Emergency'),
          ),
        ],
      ),
    );
  }

  static Widget _buildItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryRed),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
