import 'package:flutter/material.dart';
import '../../../../shared/presentation/widgets/glassmorphic_card.dart';

class EmergencyAlertPage extends StatefulWidget {
  const EmergencyAlertPage({Key? key}) : super(key: key);

  @override
  State<EmergencyAlertPage> createState() => _EmergencyAlertPageState();
}

class _EmergencyAlertPageState extends State<EmergencyAlertPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              const Text(
                'EMERGENCY ALERT',
                style: TextStyle(
                  color: Color(0xFFFF2D55),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 32),
              // Pulsing circle
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF2D55).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF2D55),
                          const Color(0xFFFF2D55).withOpacity(0.7),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF2D55).withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.emergency,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              // Quick actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _QuickActionButton(
                      icon: Icons.phone,
                      label: 'Call 911',
                      color: const Color(0xFFFF2D55),
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    _QuickActionButton(
                      icon: Icons.location_on,
                      label: 'Share Location',
                      color: const Color(0xFF00FF64),
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    _QuickActionButton(
                      icon: Icons.notifications_active,
                      label: 'Alert Contacts',
                      color: const Color(0xFF5856D6),
                      onTap: () {},
                    ),
                    const SizedBox(height: 32),
                    GlassmorphicCard(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      onTap: () => Navigator.of(context).pop(),
                      child: const Center(
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.5), width: 2),
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
