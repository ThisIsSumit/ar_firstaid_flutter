import 'package:ar_firstaid_flutter/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PerksDashboardPage extends StatelessWidget {
  const PerksDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      body: Stack(
        children: [
          // Subtle background noise/stars effect could be added here
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildStandingCard(),
                const SizedBox(height: 40),
                _buildSectionLabel("Daily Rituals", trailing: "HISTORY"),
                const SizedBox(height: 16),
                _buildDailyRituals(),
                const SizedBox(height: 40),
                _buildSectionLabel("Handpicked Perks"),
                const SizedBox(height: 20),
                _buildMainPerkCard(),
                const SizedBox(height: 16),
                _buildSmallPerksRow(),
                const SizedBox(height: 120), // Space for bottom nav
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "THE FRONTLINE",
              style: GoogleFonts.inter(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),
            Text(
                  "Welcome, Miller",
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                )
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms)
                .slideY(begin: 0.2),
          ],
        ),
        InkWell(
          onTap: () => context.push(AppRoutes.profile),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white12),
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?u=miller',
              ),
            ),
          ),
        ).animate().scale(delay: 200.ms),
      ],
    );
  }

  Widget _buildStandingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bolt, color: Color(0xFFFF3B5C), size: 18),
              const SizedBox(width: 8),
              Text(
                "CURRENT STANDING",
                style: GoogleFonts.inter(
                  color: Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "2,450",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "lp",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white38,
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "LEVEL PROGRESSION",
                    style: GoogleFonts.inter(
                      color: Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Silver Tier ",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: "Rank 4",
                          style: GoogleFonts.inter(
                            color: Colors.white38,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "+150 LP to next",
                style: GoogleFonts.inter(
                  color: const Color(0xFFFF3B5C),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.7,
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFFF3B5C),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
  }

  Widget _buildSectionLabel(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: GoogleFonts.inter(
              color: Colors.white24,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
      ],
    );
  }

  Widget _buildDailyRituals() {
    return SizedBox(
      height: 210,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRitualCard(
            "CPR Refresher Course",
            "Recertify your basic life support skills this morning.",
            "250 LP",
            Icons.favorite,
            const Color(0xFFFF3B5C),
          ),
          const SizedBox(width: 16),
          _buildRitualCard(
            "Verify Gear",
            "Check status of your medical kit components.",
            "100 LP",
            Icons.gps_fixed,
            Colors.blueAccent,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildRitualCard(
    String title,
    String desc,
    String lp,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            maxLines: 2,
            style: GoogleFonts.inter(
              color: Colors.white38,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "+$lp",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white54,
                  size: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainPerkCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1576091160550-2173dad99901?q=80&w=600&auto=format&fit=crop',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.4),
                  colorBlendMode: BlendMode.darken,
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B5C).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "ELITE PRIVILEGE",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Premium Coverage",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Free",
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white38,
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Specialized health insurance tiers for active first responders.",
                  style: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Claim Benefit",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1);
  }

  Widget _buildSmallPerksRow() {
    return Row(
      children: [
        Expanded(
          child: _buildSmallPerkCard(
            "Retail Discount",
            "15% Off Gear",
            "500 LP",
            Icons.shopping_bag_outlined,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSmallPerkCard(
            "\$25 Gift Card",
            "Available at all outlets",
            "1,200 LP",
            null,
            isAdd: true,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildSmallPerkCard(
    String title,
    String sub,
    String lp,
    IconData? icon, {
    bool isAdd = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white38, size: 18),
            ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lp,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
              if (isAdd)
                const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white38,
                  size: 20,
                )
              else
                const Icon(
                  Icons.card_giftcard,
                  color: Color(0xFFFF3B5C),
                  size: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
