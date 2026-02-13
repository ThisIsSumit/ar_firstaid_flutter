import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/theme/app_theme.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'REFERRAL PROGRAM',
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white, size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            // Hero Section
            Text(
              'Help Save\nMore Lives.',
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                height: 1.1,
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
            
            const SizedBox(height: 16),
            Text(
              'Expand our community of responders. Your influence creates impact where it matters most.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

            const SizedBox(height: 40),
            // Referral Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: const Color(0xFF15151A),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                   Text(
                    'YOUR REFERRAL IDENTIFIER',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'RESCUE-24',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w200,
                      letterSpacing: 8,
                    ),
                  ),
                ],
              ),
            ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack),

            const SizedBox(height: 16),
            // Share Button
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share_outlined, size: 18),
              label: const Text(
                'Share Invitation',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white.withOpacity(0.1)),
                minimumSize: const Size(double.infinity, 64),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ).animate().fadeIn(delay: 600.ms),

            const SizedBox(height: 60),
            // Engagement Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Engagement',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'VIEW DETAILS',
                    style: TextStyle(
                      color: const Color(0xFFFF3B5C).withOpacity(0.7),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 800.ms),

            const SizedBox(height: 24),
            // Stats Grid
            Row(
              children: [
                _buildStatColumn('12', 'TOTAL INVITES'),
                const Spacer(),
                _buildUserStatus(
                  'Marcus Holloway',
                  'Awaiting response',
                  Icons.hourglass_empty,
                ),
              ],
            ).animate().fadeIn(delay: 1000.ms).slideX(begin: 0.1),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Divider(color: Colors.white10),
            ),

            Row(
              children: [
                _buildUserStatus(
                  'Sarah Jenkins',
                  'VERIFIED',
                  Icons.verified_user_outlined,
                  isVerified: true,
                ),
                const Spacer(),
                _buildStatColumn('08', 'ACTIVE HEROES', isRightAligned: true),
              ],
            ).animate().fadeIn(delay: 1200.ms).slideX(begin: -0.1),

            const SizedBox(height: 60),
            // Next Milestone Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF15151A),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Next Milestone',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Elite Recruiter',
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '2 MORE TO UNLOCK',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            '2.5k',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'CREDITS',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 1400.ms).slideY(begin: 0.2),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, {bool isRightAligned = false}) {
    return Column(
      crossAxisAlignment: isRightAligned ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildUserStatus(String name, String status, IconData icon, {bool isVerified = false}) {
    return Row(
      children: [
        if (!isVerified) Icon(icon, color: Colors.white.withOpacity(0.3), size: 18),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: isVerified ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text(
                  status,
                  style: TextStyle(
                    color: isVerified ? const Color(0xFFFFD60A) : Colors.white.withOpacity(0.3),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isVerified) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.shield, color: Color(0xFFFFD60A), size: 14),
                ],
              ],
            ),
          ],
        ),
        if (isVerified) ...[
          const SizedBox(width: 12),
        ],
      ],
    );
  }
}