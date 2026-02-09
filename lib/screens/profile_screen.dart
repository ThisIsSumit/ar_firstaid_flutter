import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../core/router/app_router.dart';
import '../core/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('${AppRoutes.profile}/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.surface,
                  child: Text(
                    user?.name.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.name ?? 'User',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Stats
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.emergency,
                  value: '3',
                  label: 'Emergencies',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.school,
                  value: '5',
                  label: 'Trainings',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.verified,
                  value: '2',
                  label: 'Certificates',
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Menu Items
          _MenuItem(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () => context.push(AppRoutes.userProfile),
          ),
          _MenuItem(
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () => context.push('${AppRoutes.profile}/settings'),
          ),
          _MenuItem(
            icon: Icons.security,
            title: 'Privacy & Security',
            onTap: () => context.push('${AppRoutes.profile}/settings'),
          ),
          _MenuItem(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () => context.push('${AppRoutes.profile}/settings'),
          ),
          _MenuItem(
            icon: Icons.info,
            title: 'About',
            onTap: () => context.push('${AppRoutes.profile}/settings'),
          ),
          const SizedBox(height: 20),
          // Logout Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ref.read(userProvider.notifier).logout();
                context.go(AppRoutes.login);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryRed),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
    );
  }
}
