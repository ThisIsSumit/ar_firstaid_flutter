import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/emergency_provider.dart';
import '../../../core/router/app_router.dart';

class EmergencyTypePage extends ConsumerWidget {
  const EmergencyTypePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0E), // Ultra dark background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    _buildMainTitle(),
                    const SizedBox(height: 12),
                    Text(
                      'Select a category for rapid medical coordination and first-responder dispatch.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                    const SizedBox(height: 32),
                    _buildEmergencyGrid(context, ref),
                    const SizedBox(height: 24),
                    _buildHelpBanner(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(Icons.arrow_back, onTap: () => context.pop()),
          Column(
            children: [
              const Text(
                'LIFELENS',
                style: TextStyle(
                  color: Color(0xFFFF3B5C),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const Text(
                'Emergency Type',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _buildSOSButton(),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildSOSButton() {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFF2A1014),
            shape: BoxShape.circle,
          ),
          child: const Text(
            'SOS',
            style: TextStyle(
              color: Color(0xFFFF3B5C),
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(duration: 2.seconds, color: Colors.white24)
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
          duration: 1.seconds,
          curve: Curves.easeInOutSine,
        )
        .then()
        .scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1));
  }

  Widget _buildMainTitle() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          height: 1.1,
        ),
        children: [
          const TextSpan(text: 'What is the\n'),
          WidgetSpan(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'emergency',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFFF3B5C),
                  ),
                ),
                Container(
                  height: 3,
                  width: 170,
                  color: const Color(0xFFFF3B5C),
                ),
              ],
            ),
          ),
          const TextSpan(text: '?'),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildEmergencyGrid(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> items = [
      {
        'title': 'Cardiac Arrest',
        'sub': 'PRIORITY 1',
        'icon': Icons.favorite,
        'color': Colors.red,
        'type': EmergencyType.medical,
      },
      {
        'title': 'Choking',
        'sub': 'AIRWAY OBSTRUCTION',
        'icon': Icons.air,
        'color': Colors.orange,
        'type': EmergencyType.medical,
      },
      {
        'title': 'Severe Bleeding',
        'sub': 'TRAUMA CARE',
        'icon': Icons.bloodtype,
        'color': Colors.redAccent,
        'type': EmergencyType.accident,
      },
      {
        'title': 'Burns',
        'sub': 'THERMAL INJURY',
        'icon': Icons.local_fire_department,
        'color': Colors.amber,
        'type': EmergencyType.fire,
      },
      {
        'title': 'Fracture',
        'sub': 'ORTHOPEDIC',
        'icon': Icons.settings_accessibility,
        'color': Colors.blue,
        'type': EmergencyType.accident,
      },
      {
        'title': 'Stroke',
        'sub': 'NEURO / FAST',
        'icon': Icons.psychology,
        'color': Colors.purple,
        'type': EmergencyType.medical,
      },
      {
        'title': 'Seizure',
        'sub': 'RESPONSIVE HELP',
        'icon': Icons.waves,
        'color': Colors.indigo,
        'type': EmergencyType.medical,
      },
      {
        'title': 'Other',
        'sub': 'GENERAL EMERGENCY',
        'icon': Icons.help_outline,
        'color': Colors.grey,
        'type': EmergencyType.other,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildEmergencyCard(
              items[index],
              onTap: () {
                ref.read(emergencyProvider.notifier).startSelection();
                ref
                    .read(emergencyProvider.notifier)
                    .selectType(items[index]['type'] as EmergencyType);
                context.push(AppRoutes.severitySelector);
              },
            )
            .animate()
            .fadeIn(delay: (100 * index).ms)
            .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeOutBack);
      },
    );
  }

  Widget _buildEmergencyCard(
    Map<String, dynamic> data, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1919),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (data['color'] as Color).withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(data['icon'], color: data['color'], size: 24),
            ),
            const Spacer(),
            Text(
              data['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data['sub'],
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF3B5C), Color(0xFFFF718B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.call, color: Colors.white),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Not sure what to do?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Instant dispatch is available via SOS button.',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().shimmer(delay: 1.seconds, duration: 3.seconds);
  }
}
