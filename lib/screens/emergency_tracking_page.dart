import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmergencyTrackingPage extends StatelessWidget {
  const EmergencyTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Column(
        children: [
          // 1. Header Section
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              bottom: 15,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(color: Color(0xFFFF3B5C)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  '🚨 EMERGENCY ACTIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),

          // 2. Map Section
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                // Mock Map Image (Replace with GoogleMap widget in production)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://www.shutterstock.com/image-vector/city-map-navigation-gps-navigator-260nw-2449090905.jpg',
                      ), // Mock map tile
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
                  ),
                ),
                // Current Location Marker
                Center(
                  child:
                      Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.4),
                                  blurRadius: 20,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          )
                          .animate(onPlay: (controller) => controller.repeat())
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.2, 1.2),
                            duration: 800.ms,
                            curve: Curves.easeInOut,
                          )
                          .then()
                          .scale(
                            begin: const Offset(1.2, 1.2),
                            end: const Offset(1, 1),
                          ),
                ),
                // Responder Marker 1
                Positioned(
                  top: 100,
                  left: 80,
                  child: _buildETAChip('🚑 4 MIN'),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),

                // Status Overlay Card
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child:
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A24),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Responders en route',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _buildLiveTrackingBadge(),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'ETA: First responder arriving in 4 mins',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ).animate().slideY(
                        begin: 1,
                        curve: Curves.easeOutQuart,
                        duration: 600.ms,
                      ),
                ),
              ],
            ),
          ),

          // 3. Timeline Section
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  _buildTimelineItem(
                    title: 'Emergency Triggered',
                    subtitle: '12:01 PM • Location verified',
                    icon: Icons.check_circle,
                    iconColor: const Color(0xFF22C55E),
                    isActive: true,
                    showLine: true,
                  ),
                  _buildTimelineItem(
                    title: '911 Dispatched',
                    subtitle: '12:02 PM • Reference ID #8291',
                    icon: Icons.check_circle,
                    iconColor: const Color(0xFF22C55E),
                    isActive: true,
                    showLine: true,
                  ),
                  _buildTimelineItem(
                    title: '5 Responders Notified',
                    subtitle: 'Tracking closest unit...',
                    icon: Icons.group,
                    iconColor: const Color(0xFFFF3B5C),
                    isActive: false,
                    isPulse: true,
                    showLine: false,
                  ),
                  const Spacer(),

                  // Cancel Button
                  _HoldToCancelButton(),

                  const SizedBox(height: 30),

                  // Bottom Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBottomAction(Icons.call, 'CALL 911'),
                      _buildBottomAction(
                        Icons.contact_emergency_rounded,
                        'CONTACTS',
                      ),
                      _buildBottomAction(
                        Icons.medical_services_rounded,
                        'MED INFO',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildETAChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B5C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildLiveTrackingBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B5C).withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF3B5C).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF3B5C),
                  shape: BoxShape.circle,
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .fadeIn(duration: 500.ms)
              .then()
              .fadeOut(),
          const SizedBox(width: 6),
          const Text(
            'LIVE TRACKING',
            style: TextStyle(
              color: Color(0xFFFF3B5C),
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required bool isActive,
    required bool showLine,
    bool isPulse = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive ? iconColor : iconColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ).animate(target: isPulse ? 1 : 0).shimmer(duration: 1.5.seconds),
              if (showLine)
                Expanded(
                  child: Container(width: 2, color: iconColor.withOpacity(0.3)),
                ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isPulse
                        ? const Color(0xFFFF3B5C)
                        : Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E26),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: Colors.white.withOpacity(0.8), size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _HoldToCancelButton extends StatefulWidget {
  @override
  State<_HoldToCancelButton> createState() => _HoldToCancelButtonState();
}

class _HoldToCancelButtonState extends State<_HoldToCancelButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.heavyImpact();
        // Handle Cancel logic here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        _controller.forward();
        HapticFeedback.mediumImpact();
      },
      onLongPressEnd: (_) {
        if (_controller.status != AnimationStatus.completed) {
          _controller.reverse();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'CANCEL EMERGENCY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'PRESS AND HOLD FOR 3 SECONDS',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: _controller.value,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withOpacity(0.1),
                    ),
                    minHeight: 90,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
