import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class ResponderCommunityPage extends StatefulWidget {
  const ResponderCommunityPage({super.key});

  @override
  State<ResponderCommunityPage> createState() => _ResponderCommunityPageState();
}

class _ResponderCommunityPageState extends State<ResponderCommunityPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  bool _isNearbySelected = true;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF08080C);
    const Color primaryRed = Color(0xFFFF2D55);
    const Color cardBg = Color(0xFF121217);
    const Color surfaceGrey = Color(0xFF1C1C23);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: Column(
        children: [
          // 1. Global Impact Banner with shimmer effect
          _buildImpactBanner()
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 3000.ms, color: primaryRed.withOpacity(0.1)),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  // 2. Custom App Bar with staggered fade-in
                  _buildHeader()
                      .animate()
                      .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                      .slideY(
                        begin: -0.3,
                        end: 0,
                        duration: 600.ms,
                        curve: Curves.easeOutCubic,
                      ),

                  const SizedBox(height: 30),
                  // 3. Top Responders Section
                  _buildSectionHeader('TOP RESPONDERS', 'View All', primaryRed)
                      .animate()
                      .fadeIn(delay: 150.ms, duration: 500.ms)
                      .slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 20),
                  _buildTopRespondersList()
                      .animate()
                      .fadeIn(delay: 250.ms, duration: 600.ms)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        curve: Curves.easeOutBack,
                      ),

                  const SizedBox(height: 30),
                  // 4. Toggle Tabs with smooth transition
                  _buildNetworkToggle(primaryRed)
                      .animate()
                      .fadeIn(delay: 350.ms, duration: 500.ms)
                      .scale(begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: 40),
                  // 5. Local Safety Updates with pulse animation
                  _buildSectionHeader(
                    'LOCAL SAFETY UPDATES',
                    null,
                    primaryRed,
                    icon: Icons.warning_rounded,
                  ).animate().fadeIn(delay: 450.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 16),
                  _buildSafetyAlertCard(primaryRed, cardBg)
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 600.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic)
                      .then()
                      .shimmer(
                        duration: 2000.ms,
                        color: primaryRed.withOpacity(0.05),
                      ),

                  const SizedBox(height: 30),
                  // 6. Responder Meetups
                  _buildSectionHeader(
                    'RESPONDER MEETUPS',
                    null,
                    primaryRed,
                    icon: Icons.calendar_month_rounded,
                  ).animate().fadeIn(delay: 550.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 16),
                  _buildMeetupCard(primaryRed, cardBg)
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        curve: Curves.easeOutBack,
                      ),

                  const SizedBox(height: 20),
                  // 7. Network Coordination Card with glow effect
                  _buildCoordinationCard(const Color(0xFF3B82F6), cardBg)
                      .animate()
                      .fadeIn(delay: 650.ms, duration: 600.ms)
                      .slideY(begin: 0.2, end: 0)
                      .then()
                      .shimmer(
                        duration: 2500.ms,
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                      ),

                  const SizedBox(
                    height: 120,
                  ), // Padding for bottom nav & floating button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1012),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GLOBAL IMPACT: ',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const Text(
                  '1,248 LIVES SAVED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeIn(duration: 1000.ms)
                .then()
                .fadeOut(duration: 1000.ms),
            const SizedBox(width: 20),
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_pulseController.value * 0.2),
                  child: child,
                );
              },
              child: const Icon(Icons.bolt, color: Colors.redAccent, size: 14),
            ),
            const Text(
              ' AVG RES',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFF2D55),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.lens, color: Colors.white, size: 20),
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(
              duration: 2000.ms,
              begin: const Offset(1.0, 1.0),
              end: const Offset(1.1, 1.1),
            )
            .then()
            .scale(
              duration: 2000.ms,
              begin: const Offset(1.1, 1.1),
              end: const Offset(1.0, 1.0),
            ),
        const SizedBox(width: 12),
        const Text(
          'LifeLens Hub',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const Spacer(),
        _buildIconBadge(Icons.notifications_rounded, true)
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .shake(duration: 3000.ms, delay: 2000.ms, hz: 2, rotation: 0.05),
        const SizedBox(width: 16),
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFD9D9D9),
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=me'),
        ).animate().scale(
          delay: 200.ms,
          duration: 500.ms,
          curve: Curves.elasticOut,
        ),
      ],
    );
  }

  Widget _buildIconBadge(IconData icon, bool hasNotification) {
    return Stack(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 28),
        if (hasNotification)
          Positioned(
            right: 2,
            top: 2,
            child:
                Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B82F6),
                        shape: BoxShape.circle,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(duration: 1000.ms, curve: Curves.easeInOut)
                    .then()
                    .scale(
                      duration: 1000.ms,
                      curve: Curves.easeInOut,
                      begin: const Offset(1.3, 1.3),
                      end: const Offset(1.0, 1.0),
                    ),
          ),
      ],
    );
  }

  Widget _buildSectionHeader(
    String title,
    String? action,
    Color primary, {
    IconData? icon,
  }) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: primary, size: 20)
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .rotate(duration: 2000.ms, begin: -0.05, end: 0.05),
          const SizedBox(width: 8),
        ],
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: () {},
            child:
                Text(
                      action,
                      style: TextStyle(
                        color: primary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .fadeIn(duration: 1500.ms)
                    .then()
                    .fadeOut(duration: 1500.ms, begin: 1.0, delay: 1500.ms),
          ),
      ],
    );
  }

  Widget _buildTopRespondersList() {
    final responders = [
      {
        'name': 'Sarah J.',
        'img': 'https://i.pravatar.cc/150?u=1',
        'color': Colors.amber,
      },
      {
        'name': 'David K.',
        'img': 'https://i.pravatar.cc/150?u=2',
        'color': Colors.white70,
      },
      {
        'name': 'Elena W.',
        'img': 'https://i.pravatar.cc/150?u=3',
        'color': Colors.orangeAccent,
      },
      {
        'name': 'Marcus R.',
        'img': 'https://i.pravatar.cc/150?u=4',
        'color': Colors.redAccent,
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: responders.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          final r = responders[index];
          return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: r['color'] as Color,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                  r['img'] as String,
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(
                              delay: Duration(milliseconds: 100 * index),
                              duration: 400.ms,
                            )
                            .scale(
                              delay: Duration(milliseconds: 100 * index),
                              curve: Curves.elasticOut,
                            ),
                        Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: r['color'] as Color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                index == 3 ? Icons.shield : Icons.emoji_events,
                                size: 10,
                                color: Colors.black,
                              ),
                            )
                            .animate(
                              delay: Duration(milliseconds: 100 * index + 200),
                            )
                            .scale(
                              begin: const Offset(0, 0),
                              curve: Curves.elasticOut,
                            )
                            .then(delay: 1000.ms)
                            .shimmer(
                              duration: 1500.ms,
                              color: Colors.white.withOpacity(0.3),
                            ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                          r['name'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                        .animate(
                          delay: Duration(milliseconds: 100 * index + 150),
                        )
                        .fadeIn(duration: 300.ms)
                        .slideY(begin: 0.5, end: 0),
                  ],
                ),
              )
              .animate(target: 1)
              .scale(
                duration: 200.ms,
                curve: Curves.easeInOut,
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.05, 1.05),
              );
        },
      ),
    );
  }

  Widget _buildNetworkToggle(Color primary) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF14141A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _isNearbySelected = true);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isNearbySelected ? primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: _isNearbySelected
                      ? [
                          BoxShadow(
                            color: primary.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'Nearby Users',
                    style: TextStyle(
                      color: _isNearbySelected ? Colors.white : Colors.white38,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _isNearbySelected = false);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isNearbySelected ? primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: !_isNearbySelected
                      ? [
                          BoxShadow(
                            color: primary.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    'Certified Network',
                    style: TextStyle(
                      color: !_isNearbySelected ? Colors.white : Colors.white38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyAlertCard(Color primary, Color bg) {
    return GestureDetector(
      onTap: () {},
      child:
          Container(
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(width: 4, color: primary)
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .fadeIn(duration: 800.ms)
                            .then()
                            .fadeOut(
                              duration: 800.ms,
                              begin: 1.0,
                              delay: 800.ms,
                            ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Heavy Flooding Alert',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                    Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primary.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            'HIGH PRIORITY',
                                            style: TextStyle(
                                              color: primary,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        )
                                        .animate(
                                          onPlay: (controller) =>
                                              controller.repeat(),
                                        )
                                        .fadeIn(duration: 600.ms)
                                        .then()
                                        .fadeOut(
                                          duration: 600.ms,
                                          begin: 1.0,
                                          delay: 600.ms,
                                        ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Flash flooding reported on 5th Avenue and Broadway. Emergency responders are currently on route. Please avoid the area.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.white30,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      '14m ago',
                                      style: TextStyle(
                                        color: Colors.white30,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white30,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'Downtown District',
                                      style: TextStyle(
                                        color: Colors.white30,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate(target: 1)
              .scale(
                duration: 200.ms,
                curve: Curves.easeInOut,
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.02, 1.02),
              ),
    );
  }

  Widget _buildMeetupCard(Color primary, Color bg) {
    return GestureDetector(
      onTap: () {},
      child:
          Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=400',
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.3,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child:
                            Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'COMMUNITY EVENT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 300.ms)
                                .slideX(begin: -0.3, end: 0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'CPR Refresher & Network Mixer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Join fellow responders for a quick skills review followed by a social hour at Central Hall.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Stack(
                                  children: [
                                    const CircleAvatar(
                                          radius: 14,
                                          backgroundImage: NetworkImage(
                                            'https://i.pravatar.cc/150?u=a',
                                          ),
                                        )
                                        .animate()
                                        .fadeIn(delay: 100.ms)
                                        .scale(
                                          delay: 100.ms,
                                          curve: Curves.elasticOut,
                                        ),
                                    Positioned(
                                      left: 18,
                                      child:
                                          const CircleAvatar(
                                                radius: 14,
                                                backgroundImage: NetworkImage(
                                                  'https://i.pravatar.cc/150?u=b',
                                                ),
                                              )
                                              .animate()
                                              .fadeIn(delay: 200.ms)
                                              .scale(
                                                delay: 200.ms,
                                                curve: Curves.elasticOut,
                                              ),
                                    ),
                                    Positioned(
                                      left: 36,
                                      child:
                                          const CircleAvatar(
                                                radius: 14,
                                                backgroundImage: NetworkImage(
                                                  'https://i.pravatar.cc/150?u=c',
                                                ),
                                              )
                                              .animate()
                                              .fadeIn(delay: 300.ms)
                                              .scale(
                                                delay: 300.ms,
                                                curve: Curves.elasticOut,
                                              ),
                                    ),
                                    Positioned(
                                      left: 54,
                                      child:
                                          Container(
                                                height: 28,
                                                width: 28,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF1E1E26),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    '+12',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .animate()
                                              .fadeIn(delay: 400.ms)
                                              .scale(
                                                delay: 400.ms,
                                                curve: Curves.elasticOut,
                                              ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Text(
                                      'Attend',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  )
                                  .animate(
                                    onPlay: (controller) =>
                                        controller.repeat(reverse: true),
                                  )
                                  .scale(
                                    duration: 2000.ms,
                                    begin: const Offset(1.0, 1.0),
                                    end: const Offset(1.05, 1.05),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .animate(target: 1)
              .scale(
                duration: 200.ms,
                curve: Curves.easeInOut,
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.01, 1.01),
              ),
    );
  }

  Widget _buildCoordinationCard(Color blue, Color bg) {
    return GestureDetector(
      onTap: () {},
      child:
          Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F111A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: blue.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: blue.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: blue.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.hub_rounded, color: blue, size: 24),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .rotate(duration: 4000.ms, end: 1.0),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Network Coordination',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                                '4 active response groups nearby',
                                style: TextStyle(
                                  color: blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                              .animate(
                                onPlay: (controller) =>
                                    controller.repeat(reverse: true),
                              )
                              .fadeIn(duration: 1500.ms)
                              .then()
                              .fadeOut(
                                duration: 1500.ms,
                                begin: 1.0,
                                delay: 1500.ms,
                              ),
                        ],
                      ),
                    ),
                    Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white24,
                          size: 16,
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .slideX(duration: 1000.ms, begin: 0, end: 0.3),
                  ],
                ),
              )
              .animate(target: 1)
              .scale(
                duration: 200.ms,
                curve: Curves.easeInOut,
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.02, 1.02),
              ),
    );
  }
}
