import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RateEmergencyPage extends StatelessWidget {
  const RateEmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF0A0A0F);
    const Color darkGreen = Color(0xFF10B981);
    const Color cardBg = Color(0xFF13131A);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                  const Text(
                    'Incident Resolved',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // Spacer for centering
                ],
              ),

              const SizedBox(height: 40),

              // Success Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: darkGreen.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 32),
                ),
              ).animate().scale(curve: Curves.easeOutBack, duration: 600.ms),

              const SizedBox(height: 24),
              const Text(
                'You are safe now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 8),
              Text(
                'Your emergency request has been successfully closed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  height: 1.4,
                ),
              ).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 40),

              // Responder Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: darkGreen, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/300?u=marcus'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: darkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified,
                              color: Colors.white, size: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Officer Marcus Chen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Unit ID: LL-492 • LifeLens Certified',
                      style: TextStyle(
                        color: darkGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.medical_services,
                              color: Colors.white.withOpacity(0.5), size: 14),
                          const SizedBox(width: 8),
                          Text(
                            'Medical Response',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(begin: 0.1, delay: 400.ms).fadeIn(),

              const SizedBox(height: 16),

              // Stats Row
              Row(
                children: [
                  _buildStatCard('RESPONSE TIME', '1m 45s', cardBg),
                  const SizedBox(width: 16),
                  _buildStatCard('DISTANCE', '1.2 miles', cardBg),
                ],
              ).animate().fadeIn(delay: 500.ms),

              const SizedBox(height: 40),

              // Rating Section
              const Text(
                'Rate your responder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      index < 4 ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: index < 4 ? darkGreen : Colors.white24,
                      size: 42,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 40),

              // Feedback Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Any additional feedback? (Optional)',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: TextField(
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Tell us about Officer Marcus's assistance...",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}