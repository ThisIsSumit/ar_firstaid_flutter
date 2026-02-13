import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class ReferralProgramPage extends StatelessWidget {
  const ReferralProgramPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color surfaceColor = Color(0xFF15151A);
    const Color accentRed = Color(0xFFFF3B5C);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'REFERRAL PROGRAM',
          style: GoogleFonts.inter(
            color: Colors.white60,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Hero Header
            Text(
              'REFERRALS',
              style: GoogleFonts.inter(
                color: Colors.white60,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 12),
            Text(
                  'Grow Your\nCommunity',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 42,
                    height: 1.1,

                    fontWeight: FontWeight.bold,
                  ),
                )
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms)
                .slideY(begin: 0.1),
            const SizedBox(height: 12),
            Text(
              'Invite responders and earn rewards for your referrals.',
              style: GoogleFonts.inter(
                color: Colors.white60,
                fontSize: 13,
                height: 1.5,
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 48),

            // Referral Code Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'YOUR CODE',
                    style: GoogleFonts.inter(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                        'RESCUE-24',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 3.seconds, color: Colors.white24),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                          color: Colors.white.withOpacity(0.03),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.share_outlined,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Share Code',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => context.push('/my-referrals'),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(),
                          color: accentRed.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.people_outline, size: 18),
                            const SizedBox(width: 10),
                            Text(
                              'My Referrals',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 64),

            // Engagement Section
            Text(
              'Your Network',
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 500.ms),

            const SizedBox(height: 32),

            // Engagement Grid with Custom Dividers
            _buildEngagementGrid(accentRed),

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
    const Color surfaceColor = Color(0xFF15151A);
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL INVITES',
                      style: GoogleFonts.inter(
                        color: Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '12',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VERIFIED',
                      style: GoogleFonts.inter(
                        color: Colors.white60,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '8',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1);
  }

  Widget _buildMilestoneCard(Color surface) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.military_tech,
                color: Color(0xFFFF3B5C),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'NEXT MILESTONE',
                style: GoogleFonts.inter(
                  color: Colors.white60,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Elite Recruiter',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '2 more referrals to unlock exclusive rewards',
            style: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.6,
            minHeight: 4,
            backgroundColor: Colors.white.withOpacity(0.05),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF3B5C)),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.1);
  }
}
