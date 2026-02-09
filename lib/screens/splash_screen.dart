import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Pure black background
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Central Content (Logo & Text)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sexy Logo with Pulse & Glow
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B5C), // Vibrant Red
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF3B5C).withOpacity(0.3),
                      blurRadius: 40,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 80,
                ),
              )
                  .animate(onPlay: (c) => c.repeat())
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: 1.5.seconds,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1))
                  .animate() // Entrance animation
                  .fadeIn(duration: 800.ms)
                  .scale(begin: const Offset(0.8, 0.8)),

              const SizedBox(height: 30),

              // Brand Name
              const Text(
                'LifeLens',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

              // Sub-headline
              Text(
                'EMERGENCY RESPONSE',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 4,
                ),
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.5),
            ],
          ),

          // 2. Bottom Loading Section
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Circular Spinner
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF3B5C)),
                    backgroundColor: Colors.white.withOpacity(0.05),
                  ),
                ).animate().fadeIn(delay: 1.seconds),

                const SizedBox(height: 40),

                // Initializing Text
                Text(
                  'Initializing...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),

                const SizedBox(height: 20),

                // Linear Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      minHeight: 3,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF3B5C)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}