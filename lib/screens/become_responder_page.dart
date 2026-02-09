import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BecomeResponderPage extends StatelessWidget {
  const BecomeResponderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Become a Responder',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline_rounded, color: Colors.white.withOpacity(0.5)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroSection(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Join the LifeLens\nNetwork',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                  const SizedBox(height: 16),
                  Text(
                    'Be the first to arrive when it matters most. Your rapid response can save lives while you earn rewards for your community service.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
                  const SizedBox(height: 40),
                  _buildSectionLabel('BENEFITS'),
                  const SizedBox(height: 16),
                  _buildBenefitCard(
                    'Save lives nearby',
                    'Respond to emergencies within blocks of your location.',
                    Icons.favorite_rounded,
                    const Color(0xFF22C55E),
                  ),
                  _buildBenefitCard(
                    'Earn \$50/response',
                    'Receive immediate compensation for every confirmed response.',
                    Icons.payments_rounded,
                    const Color(0xFFFF3B5C),
                  ),
                  _buildBenefitCard(
                    'Build your resume',
                    'Get certified credentials and community recognition.',
                    Icons.badge_rounded,
                    Colors.blue,
                  ),
                  const SizedBox(height: 40),
                  _buildSectionLabel('REQUIREMENTS'),
                  const SizedBox(height: 20),
                  _buildRequirementItem('CPR & First Aid Certification', 'Valid Red Cross or AHA certification required.'),
                  _buildRequirementItem('18+ Years of Age', 'Must be a legal adult in your jurisdiction.'),
                  _buildRequirementItem('Background Check', 'Secure vetting process to ensure community safety.'),
                  const SizedBox(height: 40),
                  _buildGetStartedButton(),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'By continuing, you agree to our Responder Service\nAgreement and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12, height: 1.4),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 240,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1516549655169-df83a0774514?q=80&w=1000&auto=format&fit=crop'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B5C),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: const Color(0xFFFF3B5C).withOpacity(0.5), blurRadius: 20, spreadRadius: 2),
                ],
              ),
              child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 32),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: 2.seconds, begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),
        ],
      ),
    ).animate().fadeIn().scale();
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(color: Color(0xFFFF3B5C), fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1.5),
    );
  }

  Widget _buildBenefitCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2);
  }

  Widget _buildRequirementItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: Color(0xFFFF3B5C), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)]),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: const Color(0xFFFF3B5C).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
    ).animate().shimmer(delay: 2.seconds, duration: 2.seconds);
  }
}