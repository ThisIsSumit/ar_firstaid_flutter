import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalInfoOnboarding extends StatelessWidget {
  const MedicalInfoOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryRed = Color(0xFFFF2D55);
    const Color bgColor = Color(0xFF0A0A0B);
    const Color surfaceColor = Color(0xFF15151A);

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Subtle Red Glow in top right
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryRed.withOpacity(0.08),
                boxShadow: [
                  BoxShadow(
                    color: primaryRed.withOpacity(0.1),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  
                  // Illustration Section
                  _buildIllustration(surfaceColor, primaryRed)
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),
                  
                  const Spacer(flex: 2),
                  
                  // Text Content
                  Text(
                    'Your Medical Info\nSaves Lives',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'Store allergies, medications, and emergency contacts so first responders can act fast.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                  
                  const Spacer(),
                  
                  // Page Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(false),
                      const SizedBox(width: 8),
                      _buildDot(true, primaryRed),
                      const SizedBox(width: 8),
                      _buildDot(false),
                    ],
                  ).animate().fadeIn(delay: 600.ms),
                  
                  const SizedBox(height: 48),
                  
                  // Next Button
                  Container(
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: primaryRed.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRed,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.5),
                  
                  const SizedBox(height: 24),
                  
                  // Skip Link
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate().fadeIn(delay: 1000.ms),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration(Color surface, Color red) {
    return SizedBox(
      height: 280,
      width: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main Container Background
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
          ),
          
          // Document Shadow/Outline
          _buildDocShape(Colors.black.withOpacity(0.2), offset: const Offset(4, 4)),
          
          // Main Document
          _buildDocShape(const Color(0xFF1D1D24)),
          
          // Floating Health Card (Left)
          Positioned(
            left: 40,
            top: 60,
            child: _buildFloatingIcon(Icons.medical_services_rounded, red)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(begin: 0, end: -10, duration: 2.seconds, curve: Curves.easeInOut),
          ),
          
          // Floating ID Card (Right)
          Positioned(
            right: 40,
            top: 90,
            child: _buildFloatingIcon(Icons.contact_phone_rounded, red)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(begin: 0, end: 10, duration: 2.5.seconds, curve: Curves.easeInOut),
          ),
          
          // Plus Button Indicator
          Positioned(
            bottom: 70,
            left: 85,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: red, shape: BoxShape.circle),
              child: const Icon(Icons.add, color: Colors.white, size: 14),
            ),
          ),
          
          // Bottom Line Indicator
          Positioned(
            bottom: 75,
            right: 85,
            child: Container(
              width: 30,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocShape(Color color, {Offset offset = Offset.zero}) {
    return Transform.translate(
      offset: offset,
      child: Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: color == const Color(0xFF1D1D24) 
              ? Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 2))
              : null,
        ),
        child: Column(
          children: List.generate(3, (i) => Container(
            margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(2),
            ),
          )),
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color red) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF25252D),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15)],
      ),
      child: Icon(icon, color: red, size: 28),
    );
  }

  Widget _buildDot(bool active, [Color? color]) {
    return Container(
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? color : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}