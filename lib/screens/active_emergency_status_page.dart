import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers/emergency_provider.dart';
import '../core/router/app_router.dart';
import '../widgets/dialogs/emergency_dialogs.dart';

class ActiveEmergencyStatusPage extends ConsumerWidget {
  const ActiveEmergencyStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Stack(
              children: [_buildMapSection(), _buildRespondersOverlay()],
            ),
          ),
          _buildStatusTimeline(),
          _buildCancelButton(context, ref),
          _buildBottomActions(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 15,
      ),
      color: const Color(0xFFFF3B5C),
      child: Row(
        children: [
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => context.pop(),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emergency, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  'EMERGENCY ACTIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Image.network(
      'https://i.stack.imgur.com/HILXv.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ).animate().fadeIn();
  }

  Widget _buildRespondersOverlay() {
    return Positioned(
      bottom: 20,
      left: 15,
      right: 15,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1919),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Responders en route',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B5C).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFFF3B5C).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                            radius: 3,
                            backgroundColor: Color(0xFFFF3B5C),
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .shimmer(duration: 1.seconds),
                      const SizedBox(width: 6),
                      const Text(
                        'LIVE TRACKING',
                        style: TextStyle(
                          color: Color(0xFFFF3B5C),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'ETA: First responder arriving in 4 mins',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ).animate().slideY(begin: 0.2, curve: Curves.easeOutQuad),
    );
  }

  Widget _buildStatusTimeline() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildTimelineStep(
            'Emergency Triggered',
            '12:01 PM • Location verified',
            Icons.check,
            const Color(0xFF22C55E),
            true,
          ),
          _buildTimelineStep(
            '911 Dispatched',
            '12:02 PM • Reference ID #8291',
            Icons.check,
            const Color(0xFF22C55E),
            true,
          ),
          _buildTimelineStep(
            '5 Responders Notified',
            'Tracking closest unit...',
            Icons.people_alt_rounded,
            const Color(0xFFFF3B5C),
            false,
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    bool isComplete, {
    bool isActive = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive ? color.withOpacity(0.2) : color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isActive ? color : Colors.white,
                  size: 20,
                ),
              ),
              if (isActive || isComplete)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isComplete
                        ? const Color(0xFF22C55E)
                        : Colors.white12,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isActive ? color : Colors.white.withOpacity(0.4),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () async {
          final shouldCancel = await EmergencyDialogs.showCancelEmergencyDialog(
            context,
          );
          if (shouldCancel == true && context.mounted) {
            ref.read(emergencyProvider.notifier).cancelEmergency();
            context.go(AppRoutes.home);
          }
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            children: [
              const Text(
                'CANCEL EMERGENCY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PRESS AND HOLD FOR 3 SECONDS',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionItem(Icons.call, 'CALL 911'),
          _buildActionItem(Icons.contact_phone_outlined, 'CONTACTS'),
          _buildActionItem(Icons.medical_services_outlined, 'MED INFO'),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
