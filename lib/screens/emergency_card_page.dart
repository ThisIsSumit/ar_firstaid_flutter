import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmergencyCardPage extends StatelessWidget {
  const EmergencyCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF000000);
    const Color primaryRed = Color(0xFFFF3B5C);
    const Color darkGrey = Color(0xFF13131A);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: primaryRed.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.medical_services, color: primaryRed, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'LIFELENS EMERGENCY CARD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Profile Section
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryRed, width: 3),
                    ),
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/300?u=john'),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'DONOR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 30),
              const Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                '34 years old • Male',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              // Info Cards Row
              Row(
                children: [
                  _buildStatCard('BLOOD TYPE', 'O+', primaryRed),
                  const SizedBox(width: 16),
                  _buildStatCard('MEDICAL ID', 'LL-99823', Colors.white),
                ],
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

              const SizedBox(height: 40),

              // Allergies Section
              _buildSectionTitle('LIFE-THREATENING ALLERGIES', primaryRed),
              const SizedBox(height: 12),
              _buildAlertItem('Penicillin', primaryRed),
              const SizedBox(height: 10),
              _buildAlertItem('Peanuts (Anaphylaxis)', primaryRed),

              const SizedBox(height: 40),

              // Chronic Conditions Section
              _buildSectionTitle('CHRONIC CONDITIONS', Colors.white54),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  children: [
                    _ConditionRow(title: 'Type 1 Diabetes'),
                    SizedBox(height: 16),
                    _ConditionRow(title: 'Asthma'),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Emergency Contacts Section
              _buildSectionTitle('EMERGENCY CONTACTS', Colors.white54),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=jane'),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jane Doe',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Spouse',
                            style: TextStyle(color: Colors.white38, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.call, color: Colors.white, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color valueColor) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF13131A),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(color: valueColor, fontSize: 32, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildAlertItem(String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.white),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _ConditionRow extends StatelessWidget {
  final String title;
  const _ConditionRow({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(color: Color(0xFF3B82F6), shape: BoxShape.circle),
          child: const Icon(Icons.check, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}