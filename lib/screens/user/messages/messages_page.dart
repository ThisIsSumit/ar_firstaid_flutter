import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF0A0A0B);
    const Color primaryRed = Color(0xFFFF3B5C);
    const Color surfaceDark = Color(0xFF15151A);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A24),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_moderator_rounded,
              color: primaryRed,
              size: 18,
            ),
          ),
        ),
        title: const Text(
          'LifeLens',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push(AppRoutes.messages),
            icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
          ),
          IconButton(
            onPressed: () => context.push('${AppRoutes.profile}/settings'),
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Messages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: surfaceDark,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.white24),
                  hintText: 'Search chats, responders...',
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildPriorityChatTile(
                  context,
                  title: 'Emergency Dispatch',
                  message: 'Dispatcher: Help is on the way to...',
                  time: 'Now',
                  avatar: 'https://i.pravatar.cc/150?u=dispatch',
                  badgeCount: '1',
                ),
                const SizedBox(height: 15),
                _buildChatTile(
                  title: 'John Smith (Responder)',
                  message: 'ETA is 2 minutes. Stay on the line.',
                  time: '10:45 AM',
                  avatar: 'https://i.pravatar.cc/150?u=john',
                  isOnline: true,
                ),
                _buildChatTile(
                  title: 'Support Team',
                  message: 'We have received your incident report.',
                  time: '9:30 AM',
                  avatar: 'https://i.pravatar.cc/150?u=support',
                  isIcon: true,
                  icon: Icons.headset_mic_rounded,
                ),
                _buildChatTile(
                  title: 'Sarah Williams',
                  message: 'Thanks for confirming your safety status.',
                  time: 'Yesterday',
                  avatar: 'https://i.pravatar.cc/150?u=sarah',
                  isGreyscale: true,
                ),
                _buildChatTile(
                  title: 'Officer Michael Chen',
                  message: 'The area has been cleared. You are safe...',
                  time: 'Tue',
                  avatar: 'https://i.pravatar.cc/150?u=chen',
                  isGreyscale: true,
                ),
                _buildChatTile(
                  title: 'Fire Station 12',
                  message: 'Safety drill scheduled for tomorrow at...',
                  time: 'Mon',
                  avatar: 'https://i.pravatar.cc/150?u=fire',
                  isIcon: true,
                  icon: Icons.local_fire_department_rounded,
                ),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('${AppRoutes.messages}/1?name=New Chat'),
        backgroundColor: primaryRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.add_comment_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildPriorityChatTile(
    BuildContext context, {
    required String title,
    required String message,
    required String time,
    required String avatar,
    required String badgeCount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1315),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFF3B5C).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(radius: 28, backgroundImage: NetworkImage(avatar)),
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF1A1315), width: 2),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B5C),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'PRIORITY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFFFF3B5C),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFFF3B5C),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile({
    required String title,
    required String message,
    required String time,
    required String avatar,
    bool isOnline = false,
    bool isIcon = false,
    IconData? icon,
    bool isGreyscale = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              isIcon
                  ? Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1A1A24),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: const Color(0xFFFF3B5C).withOpacity(0.7),
                        size: 28,
                      ),
                    )
                  : CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(avatar),
                      backgroundColor: Colors.transparent,
                      foregroundColor: isGreyscale ? Colors.grey : null,
                    ),
              if (isOnline)
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF0A0A0B),
                      width: 2,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0B),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', false),
          _buildNavItem(Icons.map_outlined, 'Map', false),
          _buildNavItem(
            Icons.chat_bubble_rounded,
            'Messages',
            true,
            hasNotification: true,
          ),
          _buildNavItem(Icons.sos_rounded, 'Alerts', false),
          _buildNavItem(Icons.person_outline_rounded, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool active, {
    bool hasNotification = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              color: active ? const Color(0xFFFF3B5C) : Colors.white38,
              size: 26,
            ),
            if (hasNotification)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF3B5C),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFFFF3B5C) : Colors.white38,
            fontSize: 10,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
