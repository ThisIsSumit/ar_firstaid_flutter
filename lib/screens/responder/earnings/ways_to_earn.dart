import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WaysToEarnScreen extends StatefulWidget {
  const WaysToEarnScreen({Key? key}) : super(key: key);

  @override
  State<WaysToEarnScreen> createState() => _WaysToEarnScreenState();
}

class _WaysToEarnScreenState extends State<WaysToEarnScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LIFELENS REWARDS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFFF3B5C),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Ways to\nEarn',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              height: 1.0,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'BALANCE',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white.withOpacity(0.6),
                                letterSpacing: 1,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '2,450',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.star,
                                  color: Colors.white.withOpacity(0.3),
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        // Video card
                        _buildVideoCard(),
                        const SizedBox(height: 24),

                        // Referral Program Section
                        _buildReferralCard(context),
                        const SizedBox(height: 24),
                        // Action cards
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionCard(
                                icon: Icons.flash_on,
                                title: 'Respond to\nAlert',
                                subtitle: 'Active emergency\nassistance.',
                                points: '+500',
                                buttonText: 'START',
                                color: const Color.fromARGB(255, 223, 223, 223),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildActionCard(
                                icon: Icons.location_on_outlined,
                                title: 'Report AED',
                                subtitle: 'Verify equipment\nstatus.',
                                points: '+200',
                                buttonText: 'START',
                                color: const Color.fromARGB(255, 223, 223, 223),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildActionCard(
                                icon: Icons.quiz_outlined,
                                title: 'Quiz',
                                subtitle: 'New health\nprotocols.',
                                points: '+150',
                                buttonText: 'START',
                                color: const Color.fromARGB(255, 223, 223, 223),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildActionCard(
                                icon: Icons.inventory_2_outlined,
                                title: 'Verify Kit',
                                subtitle: 'Equipment\ninventory check-\nup.',
                                points: '+100',
                                buttonText: 'START',
                                color: const Color.fromARGB(255, 223, 223, 223),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReferralCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.push('/referral-program');
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF15151A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF00FF85).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    223,
                    223,
                    223,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.share_sharp, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Referral Program',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Grow your earnings',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1584515933487-779824d29309?w=800',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Play button
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            // Bottom info
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EDUCATION',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,

                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Refresher: Critical Aid',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '+300',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'WATCH',
                          style: TextStyle(
                            fontSize: 10,

                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String points,
    required String buttonText,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            points,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
