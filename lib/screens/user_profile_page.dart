import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: Colors.white, size: 24),
                ],
              ),
              const SizedBox(height: 30),

              // Avatar Section
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF2D161B),
                          width: 3,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300?u=johndoe',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF3B5C),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 18),
              const Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'john.doe@lifelens.app',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 32),
              // Impact Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF15151A),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1D21),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        color: Color(0xFFFF3B5C),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'YOUR IMPACT',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'Emergencies Assisted',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Text(
                      '12',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(begin: 0.2, duration: 400.ms),

              const SizedBox(height: 24),
              // Become a Responder CTA
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF3B5C).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.volunteer_activism,
                          color: Colors.white,
                          size: 38,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Help Your Community',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                'Get certified and save lives as a responder.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFF3B5C),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Become a Responder',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 32),
              _buildSectionHeader('ACCOUNT SETTINGS'),
              const SizedBox(height: 12),
              _buildSettingsList([
                _SettingsItem(
                  Icons.emergency_outlined,
                  'Medical Profile',
                  const Color(0xFF4285F4),
                ),
                _SettingsItem(
                  Icons.credit_card,
                  'Payment Methods',
                  const Color(0xFF34A853),
                ),
                _SettingsItem(
                  Icons.notifications_none_rounded,
                  'Notification Settings',
                  const Color(0xFFFBBC05),
                ),
                _SettingsItem(
                  Icons.shield_outlined,
                  'Privacy & Security',
                  const Color(0xFF9061F9),
                ),
              ]),

              const SizedBox(height: 24),
              _buildSectionHeader('SUPPORT'),
              const SizedBox(height: 12),
              _buildSettingsList([
                _SettingsItem(
                  Icons.help_outline_rounded,
                  'Help Center',
                  Colors.white38,
                ),
              ]),

              const SizedBox(height: 32),
              // Logout Button
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, size: 18),
                label: const Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFF3B5C),
                  side: BorderSide(
                    color: const Color(0xFFFF3B5C).withOpacity(0.2),
                    width: 1.5,
                  ),
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: const Color(0xFFFF3B5C).withOpacity(0.02),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'LifeLens v2.4.1 (Build 452)',
                style: TextStyle(
                  color: Colors.white12,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white24,
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsList(List<_SettingsItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Container(
            decoration: BoxDecoration(
              border: index == items.length - 1
                  ? null
                  : Border(
                      bottom: BorderSide(color: Colors.white.withOpacity(0.03)),
                    ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 4,
              ),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(item.icon, color: item.color, size: 20),
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white12),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0F),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', false),
          _buildNavItem(Icons.map_outlined, 'Network', false),
          _buildSOSButton(),
          _buildNavItem(Icons.chat_bubble_outline_rounded, 'Messages', false),
          _buildNavItem(Icons.person, 'Profile', true),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? const Color(0xFFFF3B5C) : Colors.white24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFFFF3B5C) : Colors.white24,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSOSButton() {
    return Container(
      height: 54,
      width: 54,
      decoration: const BoxDecoration(
        color: Color(0xFFFF3B5C),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Color(0xFFFF3B5C), blurRadius: 15, spreadRadius: 1),
        ],
      ),
      child: const Center(
        child: Text(
          'SOS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final Color color;

  _SettingsItem(this.icon, this.title, this.color);
}
