import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Preferences',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _SettingsToggle(
            icon: Icons.notifications,
            title: 'Push Notifications',
            subtitle: 'Receive emergency alerts',
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),
          _SettingsToggle(
            icon: Icons.location_on,
            title: 'Location Services',
            subtitle: 'Allow location access for emergencies',
            value: _locationEnabled,
            onChanged: (value) => setState(() => _locationEnabled = value),
          ),
          _SettingsToggle(
            icon: Icons.volume_up,
            title: 'Sound Effects',
            subtitle: 'Play sounds for alerts',
            value: _soundEnabled,
            onChanged: (value) => setState(() => _soundEnabled = value),
          ),
          const SizedBox(height: 24),
          const Text(
            'About',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _SettingsItem(
            icon: Icons.description,
            title: 'Terms of Service',
            onTap: () {},
          ),
          _SettingsItem(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          _SettingsItem(
            icon: Icons.info,
            title: 'App Version',
            trailing: const Text(
              '1.0.0',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggle({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryRed,
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      trailing:
          trailing ??
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
    );
  }
}
