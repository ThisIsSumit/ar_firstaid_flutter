import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AEDLocatorScreen extends StatelessWidget {
  const AEDLocatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background Map Layer
          const MapPlaceholder(),

          // 2. Top Navigation Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircularButton(Icons.arrow_back),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Text(
                    'AED Locator',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildCircularButton(Icons.more_horiz),
              ],
            ),
          ),

          // 3. Draggable Bottom Dashboard
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF151313),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Header Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'CLOSEST AED',
                                      style: TextStyle(
                                        color: Color(0xFFFF3053),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 12,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    _buildStatusBadge(
                                      '24/7 ACCESS',
                                      const Color(0xFF2E7D32),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'City Hall AED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Main Lobby • 150m away',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD600),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.black,
                              size: 28,
                            ),
                          ),
                        ],
                      ).animate().fadeIn().slideY(begin: 0.1),

                      const SizedBox(height: 24),

                      // Info Cards Row
                      Row(
                            children: [
                              _buildInfoCard(
                                Icons.directions_walk,
                                'ETA WALK',
                                '2 min',
                              ),
                              const SizedBox(width: 12),
                              _buildInfoCard(
                                Icons.stairs,
                                'LOCATION',
                                'Level G',
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .scale(begin: const Offset(0.9, 0.9)),

                      const SizedBox(height: 24),

                      // Directions Button
                      _buildPrimaryButton().animate().shimmer(
                        delay: 1.seconds,
                        duration: 2.seconds,
                      ),

                      const SizedBox(height: 32),

                      // Nearby Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'OTHER NEARBY AEDS',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const Text(
                            'View All',
                            style: TextStyle(
                              color: Color(0xFFFF3053),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildNearbyItem(
                        'Public Library',
                        '450m • West Wing Entrance',
                        const Color(0xFF2196F3),
                        '6 AM - 10 PM',
                        Colors.white12,
                      ),
                      _buildNearbyItem(
                        'Metro Station North',
                        '800m • Security Booth',
                        const Color(0xFFFFD600),
                        '24/7',
                        const Color(0xFF2E7D32).withOpacity(0.2),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1C1C),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFFF3053), size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: const Color(0xFFFF3053),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF3053).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.navigation, color: Colors.white),
          SizedBox(width: 12),
          Text(
            'START DIRECTIONS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyItem(
    String title,
    String subtitle,
    Color iconColor,
    String time,
    Color timeColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.favorite, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: timeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: time == '24/7'
                    ? const Color(0xFF2E7D32)
                    : Colors.white.withOpacity(0.6),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://www.shutterstock.com/image-vector/city-map-navigation-gps-navigator-260nw-2449090905.jpg',
          ), // Sample map image
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Mock Location Pins
          Positioned(
            top: 250,
            left: 150,
            child: _buildMapPin(const Color(0xFF2196F3)),
          ),
          Positioned(
            top: 320,
            left: 200,
            child: _buildMapPin(const Color(0xFFFFD600))
                .animate(onPlay: (c) => c.repeat())
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 1.seconds,
                )
                .then()
                .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1)),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: const Icon(Icons.favorite, color: Colors.white, size: 14),
    );
  }
}
