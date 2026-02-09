import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers/emergency_provider.dart';
import '../core/router/app_router.dart';

class HomeDashboard extends ConsumerWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?u=lifelens',
            ),
          ),
        ),
        title: const Text(
          'LifeLens',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.messages),
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Emergency Button Section
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Glow Rings
                  ...List.generate(
                    3,
                    (index) =>
                        Container(
                              width: 250 + (index * 40),
                              height: 250 + (index * 40),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(
                                    0xFFFF3B5C,
                                  ).withOpacity(0.1 / (index + 1)),
                                  width: 20,
                                ),
                              ),
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .scale(
                              begin: const Offset(1, 1),
                              end: const Offset(1.1, 1.1),
                              duration: (1000 + (index * 200)).ms,
                              curve: Curves.easeInOut,
                            )
                            .then()
                            .scale(
                              begin: const Offset(1.1, 1.1),
                              end: const Offset(1, 1),
                            ),
                  ),

                  // Main Button
                  GestureDetector(
                        onTap: () {
                          ref.read(emergencyProvider.notifier).startSelection();
                          context.push(AppRoutes.emergencySelector);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF3B5C).withOpacity(0.5),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                size: 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'EMERGENCY',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                'TAP FOR HELP',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat())
                      .shimmer(duration: 3.seconds),
                ],
              ),
            ),

            const SizedBox(height: 30),
            // Responders Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF132A1F),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color(0xFF2E7D32).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 4,
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '5 responders within 500m',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 40),
            // Quick Access Section
            Row(
              children: [
                const Icon(
                  Icons.grid_view_rounded,
                  color: Color(0xFFFF3B5C),
                  size: 18,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Quick Access',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.3,
              children: [
                _buildQuickCard(
                  'Med Profile',
                  'Allergies, Meds...',
                  Icons.medical_services,
                  Colors.blue,
                  onTap: () => context.push(AppRoutes.medicalProfile),
                ),
                _buildQuickCard(
                  'Find AED',
                  'Nearest available...',
                  Icons.favorite,
                  Colors.orange,
                  onTap: () => context.push(AppRoutes.aedMap),
                ),
                _buildQuickCard(
                  'Emergency Map',
                  'Live incident...',
                  Icons.map,
                  Colors.purple,
                  onTap: () => context.push(AppRoutes.emergencyTracking),
                ),
                _buildQuickCard(
                  'Live Chat',
                  'Talk to dispatchers',
                  Icons.chat_bubble,
                  Colors.teal,
                  onTap: () => context.push(AppRoutes.messages),
                ),
              ],
            ),

            const SizedBox(height: 30),
            // Recent Activity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(AppRoutes.training),
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Color(0xFFFF3B5C)),
                  ),
                ),
              ],
            ),
            _buildActivityItem(
              'CPR Training Completed',
              'Certification updated',
              Icons.check_circle,
              Colors.green,
              '2H AGO',
            ),
            _buildActivityItem(
              'Medical Profile Updated',
              'New allergy info added',
              Icons.person,
              Colors.blue,
              'YESTERDAY',
            ),
            _buildActivityItem(
              'Network Status Checked',
              'Relay is active',
              Icons.location_on,
              Colors.red,
              '3 DAYS AGO',
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickCard(
    String title,
    String sub,
    IconData icon,
    Color color, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF15151A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              sub,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    ).animate().scale(delay: 200.ms, curve: Curves.fastOutSlowIn);
  }

  Widget _buildActivityItem(
    String title,
    String sub,
    IconData icon,
    Color color,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  sub,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate().slideX(begin: 0.2, curve: Curves.easeOut);
  }
}
