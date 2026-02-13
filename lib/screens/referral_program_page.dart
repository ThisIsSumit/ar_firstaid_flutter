import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class ReferralProgramPage extends StatelessWidget {
  const ReferralProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color surfaceColor = Color(0xFF131313);
    const Color accentGold = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'REFERRAL PROGRAM',
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white38),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            // Hero Header
            Text(
              'Help Save\nMore Lives.',
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 48,
                height: 1.1,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
            
            const SizedBox(height: 16),
            Text(
              'Expand our community of responders. Your influence creates impact where it matters most.',
              style: GoogleFonts.inter(
                color: Colors.white38,
                fontSize: 15,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 48),

            // Referral Code Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                   Text(
                    'YOUR REFERRAL IDENTIFIER',
                    style: GoogleFonts.inter(
                      color: Colors.white24,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'RESCUE-24',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 8,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 3.seconds, color: Colors.white24),
                ],
              ),
            ).animate().scale(delay: 400.ms, curve: Curves.easeOutBack),

            const SizedBox(height: 16),

            // Share Button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.share_outlined, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'Share Invitation',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 600.ms),

            const SizedBox(height: 64),

            // Engagement Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Engagement',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'VIEW DETAILS',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFC5A358),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 800.ms),

            const SizedBox(height: 32),

            // Engagement Grid with Custom Dividers
            _buildEngagementGrid(accentGold),

            const SizedBox(height: 64),

            // Next Milestone Card
            _buildMilestoneCard(surfaceColor),
            
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementGrid(Color accent) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildStatItem('12', 'TOTAL INVITES', isLeft: true)),
            Container(height: 60, width: 0.5, color: Colors.white10),
            Expanded(child: _buildUserStat('Marcus Holloway', 'Awaiting response', Icons.hourglass_empty, Colors.white24)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Divider(color: Colors.white.withOpacity(0.05), thickness: 0.5),
        ),
        Row(
          children: [
            Expanded(child: _buildUserStat('Sarah Jenkins', 'VERIFIED', Icons.verified_user, accent, isVerified: true)),
            Container(height: 60, width: 0.5, color: Colors.white10),
            Expanded(child: _buildStatItem('08', 'ACTIVE HEROES', isLeft: false)),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 1.seconds).slideY(begin: 0.05);
  }

  Widget _buildStatItem(String val, String label, {required bool isLeft}) {
    return Column(
      crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(val, style: GoogleFonts.inter(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w300)),
        Text(label, style: GoogleFonts.inter(color: Colors.white24, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1)),
      ],
    );
  }

  Widget _buildUserStat(String name, String sub, IconData icon, Color iconCol, {bool isVerified = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconCol, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
              Text(
                sub, 
                style: GoogleFonts.inter(
                  color: isVerified ? iconCol : Colors.white24, 
                  fontSize: 10, 
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneCard(Color surface) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.military_tech, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                'Next Milestone',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    style: GoogleFonts.inter(
                      color: Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '2.5k',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'CREDITS',
                    style: GoogleFonts.inter(
                      color: Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1.2.seconds).slideY(begin: 0.1);
  }
}