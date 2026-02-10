import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/router/app_router.dart';

class ResponderNotificationsPage extends StatelessWidget {
  const ResponderNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF0A0A0F);
    const Color cardBg = Color(0xFF1A1A24);
    const Color primaryRed = Color(0xFFFF3B5C);

    final notifications = [
      {
        'title': 'Cardiac Arrest',
        'address': '124 Maple St, Unit 4B',
        'distance': '0.4 mi',
        'time': 'Just now',
        'severity': 'CRITICAL',
      },
      {
        'title': 'Traffic Accident',
        'address': 'Junction 12, Expressway',
        'distance': '1.2 mi',
        'time': '2 min ago',
        'severity': 'HIGH',
      },
      {
        'title': 'Fall Incident',
        'address': 'Park Heights Community',
        'distance': '2.3 mi',
        'time': '6 min ago',
        'severity': 'MEDIUM',
      },
    ];

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Emergency Alerts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return _NotificationCard(
            title: item['title'] as String,
            address: item['address'] as String,
            distance: item['distance'] as String,
            time: item['time'] as String,
            severity: item['severity'] as String,
            primaryRed: primaryRed,
            cardBg: cardBg,
            onTap: () async {
              final accepted = await context.push<bool>(
                AppRoutes.incomingEmergency,
              );
              if (accepted == true && context.mounted) {
                context.go(AppRoutes.treatmentLogging);
              }
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: notifications.length,
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String address;
  final String distance;
  final String time;
  final String severity;
  final Color primaryRed;
  final Color cardBg;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.title,
    required this.address,
    required this.distance,
    required this.time,
    required this.severity,
    required this.primaryRed,
    required this.cardBg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryRed.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_active,
                color: Color(0xFFFF3B5C),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryRed.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          severity,
                          style: TextStyle(
                            color: primaryRed,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white.withOpacity(0.4),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        distance,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.access_time,
                        color: Colors.white.withOpacity(0.4),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.3)),
          ],
        ),
      ),
    );
  }
}
