import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF08080C);
    const Color cardBg = Color(0xFF18181F);
    const Color primaryRed = Color(0xFFFF3B5C);
    const Color successGreen = Color(0xFF22C55E);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Earnings & Impact',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Total Earnings Card
            _buildTotalEarningsCard(cardBg, primaryRed, successGreen),
            const SizedBox(height: 20),
            // Responses per Month Card
            _buildChartCard(cardBg, successGreen),
            const SizedBox(height: 30),
            // Impact Milestones Section
            _buildSectionHeader(
              'Impact Milestones',
              '5 Achievements',
              successGreen,
            ),
            const SizedBox(height: 15),
            _buildMilestoneItem(
              icon: Icons.medical_services_rounded,
              title: '10 Lives Saved',
              subtitle: 'Confirmed emergency stabilization',
              isCompleted: true,
              color: Colors.redAccent,
              cardBg: cardBg,
              successGreen: successGreen,
            ),
            _buildMilestoneItem(
              icon: Icons.timer_outlined,
              title: '100% On-Time Arrival',
              subtitle: 'Last 50 responses under 4 mins',
              isCompleted: true,
              color: successGreen,
              cardBg: cardBg,
              successGreen: successGreen,
            ),
            _buildMilestoneItem(
              icon: Icons.emoji_events_outlined,
              title: 'Community Guardian',
              subtitle: 'Reach 50 responses (42/50)',
              isCompleted: false,
              color: Colors.white24,
              cardBg: cardBg,
              successGreen: successGreen,
            ),
            const SizedBox(height: 25),
            // Bottom Links
            _buildLinkItem(
              Icons.description_outlined,
              'Tax Documents & 1099-K',
              cardBg,
            ),
            _buildLinkItem(
              Icons.account_balance_wallet_outlined,
              'Payout Methods',
              cardBg,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalEarningsCard(Color bg, Color primaryRed, Color green) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL EARNINGS',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, color: green, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '+12%',
                      style: TextStyle(
                        color: green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '\$4,280.50',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatDetail('This Week', '\$450.00'),
              _buildStatDetail(
                'Response Count',
                '9',
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance_wallet, size: 20),
                SizedBox(width: 10),
                Text(
                  'Withdraw Funds',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDetail(
    String label,
    String value, {
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard(Color bg, Color green) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Responses per\nMonth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Last 6 Months',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white54,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(painter: _ChartPainter()),
          ).animate().fadeIn(duration: 800.ms).shimmer(delay: 1.seconds),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN']
                .map(
                  (m) => Text(
                    m,
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String badgeText, Color green) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            badgeText,
            style: TextStyle(
              color: green,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCompleted,
    required Color color,
    required Color cardBg,
    required Color successGreen,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color.withOpacity(isCompleted ? 1 : 0.3),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted ? null : TextDecoration.none,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          if (isCompleted)
            Icon(Icons.check_circle_rounded, color: successGreen, size: 24)
          else
            const Icon(
              Icons.lock_outline_rounded,
              color: Colors.white12,
              size: 24,
            ),
        ],
      ),
    );
  }

  Widget _buildLinkItem(IconData icon, String title, Color cardBg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF22C55E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.7,
      size.width * 0.35,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.5,
      size.width * 0.6,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 1.1,
      size.width * 0.85,
      size.height * 0.2,
    );
    path.lineTo(size.width, size.height * 0.5);

    // Dynamic gradient based on height of path
    final gradient = LinearGradient(
      colors: [Colors.redAccent, Colors.orangeAccent, const Color(0xFF22C55E)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    paint.shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
