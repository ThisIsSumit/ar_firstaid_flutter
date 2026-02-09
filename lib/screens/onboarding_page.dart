import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Instant Emergency\nResponse',
      'subtitle': 'Get help from nearby certified\nresponders in under 2 minutes',
      'image': 'https://illustrations.popsy.co/amber/emergency-call.svg', // Placeholder illustration
    },
    {
      'title': 'AR-Guided\nFirst Aid',
      'subtitle': 'Visual, real-time instructions to\nperform life-saving actions.',
      'image': 'https://illustrations.popsy.co/amber/medical-care.svg',
    },
    {
      'title': 'Hospital\nCoordination',
      'subtitle': 'Seamless data transfer to ER\nbefore you even arrive.',
      'image': 'https://illustrations.popsy.co/amber/ambulance.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => _buildPageContent(index),
              ),
            ),

            // Bottom Navigation Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicator
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => _buildIndicator(index),
                    ),
                  ),

                  // Next Button
                  _buildNextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Illustration Container
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A24),
              borderRadius: BorderRadius.circular(40),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://img.freepik.com/free-vector/emergency-responders-concept-illustration_114360-15555.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ).animate(key: ValueKey(index))
          //  .scaleV(begin: 0.9, end: 1.0, curve: Curves.easeOutBack, duration: 600.ms)
           .fadeIn(),

          const SizedBox(height: 50),

          // Title
          Text(
            _onboardingData[index]['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: -1,
            ),
          ).animate(key: ValueKey('t$index'))
           .slideX(begin: 0.2, duration: 400.ms)
           .fadeIn(),

          const SizedBox(height: 20),

          // Subtitle
          Text(
            _onboardingData[index]['subtitle']!,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ).animate(key: ValueKey('s$index'))
           .slideX(begin: 0.2, delay: 100.ms, duration: 400.ms)
           .fadeIn(),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF3B5C) : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF3B5C).withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_currentPage < _onboardingData.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutQuart,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF3B5C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Next',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_rounded, size: 20),
          ],
        ),
      ),
    ).animate()
     .scale(delay: 500.ms, duration: 400.ms, curve: Curves.easeOutBack);
  }
}