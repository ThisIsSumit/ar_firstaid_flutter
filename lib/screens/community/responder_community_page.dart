import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/chat_provider.dart';
import '../../core/router/app_router.dart';

class ResponderCommunityPage extends ConsumerStatefulWidget {
  const ResponderCommunityPage({super.key});

  @override
  ConsumerState<ResponderCommunityPage> createState() =>
      _ResponderCommunityPageState();
}

class _ResponderCommunityPageState extends ConsumerState<ResponderCommunityPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  bool _isNearbySelected = true;
  final Set<String> _followingIds = {}; // Track who we're following

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

  // Start a chat with a person
  void _startChat(String personId, String personName, {String? avatar}) {
    // Get or create chat
    final chat = ref
        .read(chatProvider.notifier)
        .getOrCreateChat(personId, personName, avatar: avatar);

    // Navigate to chat
    context.push(
      '/chat/${chat.id}?name=${Uri.encodeComponent(chat.name)}&avatar=${Uri.encodeComponent(chat.avatar)}',
    );
  }

  // Toggle follow status
  void _toggleFollow(String personId) {
    setState(() {
      if (_followingIds.contains(personId)) {
        _followingIds.remove(personId);
      } else {
        _followingIds.add(personId);
      }
    });
  }

  // Show responder profile dialog
  void _showResponderProfile(
    BuildContext context,
    Map<String, dynamic> responder,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ResponderProfileSheet(responder: responder),
    );
  }

  // Show all top responders
  void _showAllTopResponders(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AllTopRespondersPage()),
    );
  }

  // Show safety alert details
  void _showSafetyAlertDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const SafetyAlertDetailsSheet(),
    );
  }

  // Show meetup details
  void _showMeetupDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MeetupDetailsPage()),
    );
  }

  // Show network coordination
  void _showNetworkCoordination(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NetworkCoordinationPage()),
    );
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
          // Global Impact Banner
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
                  const SizedBox(height: 10),

                  // Top Responders Section
                  _buildSectionHeader(
                        'TOP RESPONDERS',
                        'View All',
                        primaryRed,
                        onActionTap: () => _showAllTopResponders(context),
                      )
                      .animate()
                      .fadeIn(delay: 150.ms, duration: 500.ms)
                      .slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 20),
                  _buildTopRespondersList(context)
                      .animate()
                      .fadeIn(delay: 250.ms, duration: 600.ms)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        curve: Curves.easeOutBack,
                      ),

                  const SizedBox(height: 30),

                  // Toggle Tabs
                  _buildNetworkToggle(primaryRed)
                      .animate()
                      .fadeIn(delay: 350.ms, duration: 500.ms)
                      .scale(begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: 24),

                  // Network content based on selection
                  _buildNetworkContent(context, primaryRed, cardBg),

                  const SizedBox(height: 30),

                  // Local Safety Updates
                  _buildSectionHeader(
                    'LOCAL SAFETY UPDATES',
                    null,
                    primaryRed,
                    icon: Icons.warning_rounded,
                  ).animate().fadeIn(delay: 450.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 16),
                  _buildSafetyAlertCard(context, primaryRed, cardBg)
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 600.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic)
                      .then()
                      .shimmer(
                        duration: 2000.ms,
                        color: primaryRed.withOpacity(0.05),
                      ),

                  const SizedBox(height: 30),

                  // Responder Meetups
                  _buildSectionHeader(
                    'RESPONDER MEETUPS',
                    null,
                    primaryRed,
                    icon: Icons.calendar_month_rounded,
                  ).animate().fadeIn(delay: 550.ms).slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 16),
                  _buildMeetupCard(context, primaryRed, cardBg)
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms)
                      .scale(
                        begin: const Offset(0.95, 0.95),
                        curve: Curves.easeOutBack,
                      ),

                  const SizedBox(height: 20),

                  // Network Coordination Card
                  _buildCoordinationCard(
                        context,
                        const Color(0xFF3B82F6),
                        cardBg,
                      )
                      .animate()
                      .fadeIn(delay: 650.ms, duration: 600.ms)
                      .slideY(begin: 0.2, end: 0)
                      .then()
                      .shimmer(
                        duration: 2500.ms,
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                      ),

                  const SizedBox(height: 120),
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

  Widget _buildSectionHeader(
    String title,
    String? action,
    Color primary, {
    IconData? icon,
    VoidCallback? onActionTap,
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
            onTap: onActionTap,
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

  Widget _buildTopRespondersList(BuildContext context) {
    final responders = [
      {
        'id': 'top_sarah_1',
        'name': 'Sarah J.',
        'img': 'https://i.pravatar.cc/150?u=1',
        'color': Colors.amber,
        'rank': 1,
        'saves': 47,
        'responseTime': '2.3 min',
      },
      {
        'id': 'top_david_2',
        'name': 'David K.',
        'img': 'https://i.pravatar.cc/150?u=2',
        'color': Colors.white70,
        'rank': 2,
        'saves': 42,
        'responseTime': '2.8 min',
      },
      {
        'id': 'top_elena_3',
        'name': 'Elena W.',
        'img': 'https://i.pravatar.cc/150?u=3',
        'color': Colors.orangeAccent,
        'rank': 3,
        'saves': 38,
        'responseTime': '3.1 min',
      },
      {
        'id': 'top_marcus_4',
        'name': 'Marcus R.',
        'img': 'https://i.pravatar.cc/150?u=4',
        'color': Colors.redAccent,
        'rank': 4,
        'saves': 35,
        'responseTime': '3.4 min',
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
            onTap: () => _showResponderProfile(context, r),
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
                            backgroundImage: NetworkImage(r['img'] as String),
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
                            border: Border.all(color: Colors.black, width: 2),
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
                    .animate(delay: Duration(milliseconds: 100 * index + 150))
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.5, end: 0),
              ],
            ),
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
              onTap: () => setState(() => _isNearbySelected = true),
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
              onTap: () => setState(() => _isNearbySelected = false),
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

  Widget _buildNetworkContent(BuildContext context, Color primary, Color bg) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _isNearbySelected
          ? _buildNearbyUsersList(context, bg, primary)
          : _buildCertifiedNetworkList(context, bg, primary),
    );
  }

  Widget _buildNearbyUsersList(BuildContext context, Color bg, Color primary) {
    final users = [
      {
        'id': 'user_alex_5',
        'name': 'Alex Thompson',
        'distance': '0.3 km',
        'status': 'Available',
        'img': 'https://i.pravatar.cc/150?u=5',
      },
      {
        'id': 'user_jessica_6',
        'name': 'Jessica Lee',
        'distance': '0.5 km',
        'status': 'Available',
        'img': 'https://i.pravatar.cc/150?u=6',
      },
      {
        'id': 'user_mike_7',
        'name': 'Mike Rodriguez',
        'distance': '0.8 km',
        'status': 'On Call',
        'img': 'https://i.pravatar.cc/150?u=7',
      },
    ];

    return Column(
      key: const ValueKey('nearby'),
      children: users.map((user) {
        final isAvailable = user['status'] == 'Available';
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(user['img'] as String),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isAvailable ? Colors.green : Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: bg, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user['distance'] as String,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (isAvailable ? Colors.green : Colors.orange)
                                      .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              user['status'] as String,
                              style: TextStyle(
                                color: isAvailable
                                    ? Colors.green
                                    : Colors.orange,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _startChat(
                    user['id'] as String,
                    user['name'] as String,
                    avatar: user['img'] as String,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),
        );
      }).toList(),
    );
  }

  Widget _buildCertifiedNetworkList(
    BuildContext context,
    Color bg,
    Color primary,
  ) {
    final certified = [
      {
        'id': 'cert_sarah_8',
        'name': 'Dr. Sarah Mitchell',
        'role': 'Paramedic',
        'verified': true,
        'img': 'https://i.pravatar.cc/150?u=8',
      },
      {
        'id': 'cert_james_9',
        'name': 'James Chen',
        'role': 'EMT Certified',
        'verified': true,
        'img': 'https://i.pravatar.cc/150?u=9',
      },
      {
        'id': 'cert_rachel_10',
        'name': 'Rachel Adams',
        'role': 'First Aid Trainer',
        'verified': true,
        'img': 'https://i.pravatar.cc/150?u=10',
      },
    ];

    return Column(
      key: const ValueKey('certified'),
      children: certified.map((person) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(person['img'] as String),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6),
                          shape: BoxShape.circle,
                          border: Border.all(color: bg, width: 2),
                        ),
                        child: const Icon(
                          Icons.verified,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.medical_services,
                            size: 14,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            person['role'] as String,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _toggleFollow(person['id'] as String),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _followingIds.contains(person['id'])
                              ? Colors.white.withOpacity(0.1)
                              : const Color(0xFF3B82F6),
                          borderRadius: BorderRadius.circular(12),
                          border: _followingIds.contains(person['id'])
                              ? Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _followingIds.contains(person['id'])
                                  ? Icons.check
                                  : Icons.person_add_outlined,
                              color: _followingIds.contains(person['id'])
                                  ? Colors.white70
                                  : Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _followingIds.contains(person['id'])
                                  ? 'Following'
                                  : 'Follow',
                              style: TextStyle(
                                color: _followingIds.contains(person['id'])
                                    ? Colors.white70
                                    : Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _startChat(
                        person['id'] as String,
                        person['name'] as String,
                        avatar: person['img'] as String,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          color: Color(0xFF3B82F6),
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0),
        );
      }).toList(),
    );
  }

  Widget _buildSafetyAlertCard(BuildContext context, Color primary, Color bg) {
    return GestureDetector(
      onTap: () => _showSafetyAlertDetails(context),
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
                                    const Icon(
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

  Widget _buildMeetupCard(BuildContext context, Color primary, Color bg) {
    return GestureDetector(
      onTap: () => _showMeetupDetails(context),
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                        image: DecorationImage(
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

  Widget _buildCoordinationCard(BuildContext context, Color blue, Color bg) {
    return GestureDetector(
      onTap: () => _showNetworkCoordination(context),
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
                    const Icon(
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

// RESPONDER PROFILE BOTTOM SHEET
class ResponderProfileSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic> responder;

  const ResponderProfileSheet({super.key, required this.responder});

  @override
  ConsumerState<ResponderProfileSheet> createState() =>
      _ResponderProfileSheetState();
}

class _ResponderProfileSheetState extends ConsumerState<ResponderProfileSheet> {
  bool _isFollowing = false;

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  void _startChat(BuildContext context) {
    // Get or create chat
    final chat = ref
        .read(chatProvider.notifier)
        .getOrCreateChat(
          widget.responder['id'] as String,
          widget.responder['name'] as String,
          avatar: widget.responder['img'] as String,
        );

    // Close the bottom sheet
    Navigator.pop(context);

    // Navigate to chat
    context.push(
      '${AppRoutes.responderMessages}/${chat.id}?name=${Uri.encodeComponent(chat.name)}&avatar=${Uri.encodeComponent(chat.avatar)}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFF121217),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 8),

          // Profile header with animation
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Transform.scale(
                    scale: 0.7 + (scale * 0.3),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.responder['color'] as Color,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          widget.responder['img'] as String,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: widget.responder['color'] as Color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF121217),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.emoji_events,
                          size: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
                widget.responder['name'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 100.ms)
              .slideY(begin: 0.2, end: 0, duration: 400.ms, delay: 100.ms),
          const SizedBox(height: 4),
          Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF2D55).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Rank #${widget.responder['rank']}',
                  style: const TextStyle(
                    color: Color(0xFFFF2D55),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 200.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                duration: 400.ms,
                delay: 200.ms,
              ),
          const SizedBox(height: 12),

          // Stats - Compact
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Transform.scale(
              scale: 0.80,
              child: Row(
                children: [
                  Expanded(
                    child:
                        _buildStatCard(
                              'Lives Saved',
                              '${widget.responder['saves']}',
                              Icons.favorite,
                              const Color(0xFFFF2D55),
                            )
                            .animate()
                            .fadeIn(duration: 400.ms, delay: 300.ms)
                            .slideX(
                              begin: -0.2,
                              end: 0,
                              duration: 400.ms,
                              delay: 300.ms,
                            ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child:
                        _buildStatCard(
                              'Avg Response',
                              widget.responder['responseTime'] as String,
                              Icons.timer,
                              const Color(0xFF3B82F6),
                            )
                            .animate()
                            .fadeIn(duration: 400.ms, delay: 350.ms)
                            .slideX(
                              begin: 0.2,
                              end: 0,
                              duration: 400.ms,
                              delay: 350.ms,
                            ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Actions - Compact
          Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _toggleFollow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFollowing
                              ? Colors.white.withOpacity(0.1)
                              : const Color(0xFF00C853),
                          foregroundColor: _isFollowing
                              ? Colors.white70
                              : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: _isFollowing
                                ? BorderSide(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  )
                                : BorderSide.none,
                          ),
                        ),
                        icon: Icon(
                          _isFollowing
                              ? Icons.check
                              : Icons.person_add_outlined,
                          size: 16,
                        ),
                        label: Text(
                          _isFollowing ? 'Following' : 'Follow',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _startChat(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 400.ms)
              .slideY(begin: 0.2, end: 0, duration: 400.ms, delay: 400.ms),
          const SizedBox(height: 12),

          // Recent activity
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RECENT ACTIVITY',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildActivityItem(
                          'Responded to cardiac emergency',
                          '2 hours ago',
                          Icons.favorite,
                          const Color(0xFFFF2D55),
                        ),
                        _buildActivityItem(
                          'Completed CPR training',
                          '1 day ago',
                          Icons.school,
                          const Color(0xFF3B82F6),
                        ),
                        _buildActivityItem(
                          'Attended community meetup',
                          '3 days ago',
                          Icons.people,
                          Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
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

// ALL TOP RESPONDERS PAGE
class AllTopRespondersPage extends StatelessWidget {
  const AllTopRespondersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responders = List.generate(
      20,
      (index) => {
        'name': 'Responder ${index + 1}',
        'img': 'https://i.pravatar.cc/150?u=${index + 10}',
        'rank': index + 1,
        'saves': 47 - index,
        'responseTime': '${2.3 + (index * 0.1)} min',
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08080C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Top Responders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: responders.length,
        itemBuilder: (context, index) {
          final responder = responders[index];
          final medal = index < 3
              ? (index == 0
                    ? Colors.amber
                    : index == 1
                    ? Colors.white70
                    : Colors.orangeAccent)
              : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF121217),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: medal != null
                      ? medal.withOpacity(0.3)
                      : Colors.white.withOpacity(0.05),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '#${responder['rank']}',
                      style: TextStyle(
                        color: medal ?? Colors.white.withOpacity(0.5),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          responder['img'] as String,
                        ),
                      ),
                      if (medal != null)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: medal,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF121217),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              size: 10,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          responder['name'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${responder['saves']} saves • ${responder['responseTime']} avg',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white24,
                    size: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// SAFETY ALERT DETAILS SHEET
class SafetyAlertDetailsSheet extends StatelessWidget {
  const SafetyAlertDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Color(0xFF121217),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Alert header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF2D55).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.warning_rounded,
                        color: Color(0xFFFF2D55),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Heavy Flooding Alert',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF2D55).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'HIGH PRIORITY',
                              style: TextStyle(
                                color: Color(0xFFFF2D55),
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Time and location
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white54,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '14 minutes ago',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.location_on,
                      color: Colors.white54,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Downtown District',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Description
                const Text(
                  'Alert Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Flash flooding has been reported on 5th Avenue and Broadway. Water levels are rising rapidly due to heavy rainfall. Emergency responders are currently on route to the affected area. Please avoid this location and seek alternative routes.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Affected areas
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AFFECTED AREAS',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildLocationItem(
                          '5th Avenue & Broadway',
                          '0.2 km away',
                        ),
                        _buildLocationItem('Main Street Plaza', '0.5 km away'),
                        _buildLocationItem('Central Park South', '0.8 km away'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withOpacity(0.2)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Dismiss',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF2D55),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Navigate Away',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
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

  Widget _buildLocationItem(String name, String distance) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF2D55).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.location_on,
                color: Color(0xFFFF2D55),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    distance,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
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
}

// MEETUP DETAILS PAGE
class MeetupDetailsPage extends StatelessWidget {
  const MeetupDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: const Color(0xFF08080C),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1576091160550-2173dba999ef?auto=format&fit=crop&w=800',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF08080C).withOpacity(0.8),
                          const Color(0xFF08080C),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF2D55).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'COMMUNITY EVENT',
                      style: TextStyle(
                        color: Color(0xFFFF2D55),
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CPR Refresher & Network Mixer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Event details
                  _buildDetailRow(
                    Icons.calendar_month_rounded,
                    'Saturday, March 15, 2025',
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(Icons.access_time, '2:00 PM - 5:00 PM'),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    Icons.location_on,
                    'Central Hall, 123 Community Street',
                  ),
                  const SizedBox(height: 32),

                  // Description
                  const Text(
                    'About This Event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Join fellow responders for a comprehensive CPR skills refresher course followed by a relaxed networking session. This is a great opportunity to practice your life-saving techniques, meet other community responders, and share experiences.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Attendees
                  const Text(
                    'Confirmed Attendees (15)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/150?u=attendee$index',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF08080C),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF2D55),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Register for Event',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFFF2D55), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}

// NETWORK COORDINATION PAGE
class NetworkCoordinationPage extends StatelessWidget {
  const NetworkCoordinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      {
        'name': 'Downtown Response Team',
        'members': 12,
        'status': 'Active',
        'distance': '0.5 km',
      },
      {
        'name': 'North District EMTs',
        'members': 8,
        'status': 'Active',
        'distance': '1.2 km',
      },
      {
        'name': 'Central Medical Unit',
        'members': 15,
        'status': 'Standby',
        'distance': '2.1 km',
      },
      {
        'name': 'Westside First Responders',
        'members': 10,
        'status': 'Active',
        'distance': '2.8 km',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF08080C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08080C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Network Coordination',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        children: [
          // Summary card
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'Active Groups',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '45',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'Total Responders',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.radio_button_checked,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'All systems operational',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Groups list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];
                final isActive = group['status'] == 'Active';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121217),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isActive
                            ? const Color(0xFF3B82F6).withOpacity(0.3)
                            : Colors.white.withOpacity(0.05),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF3B82F6,
                                ).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.groups,
                                color: Color(0xFF3B82F6),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    group['name'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${group['members']} members • ${group['distance']}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    (isActive
                                            ? const Color(0xFF10B981)
                                            : Colors.orange)
                                        .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                group['status'] as String,
                                style: TextStyle(
                                  color: isActive
                                      ? const Color(0xFF10B981)
                                      : Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: BorderSide(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('View Details'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF3B82F6),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Connect'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
