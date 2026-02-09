import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class MedicalProfilePage extends StatelessWidget {
  const MedicalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildProfileHeader(),
                  const SizedBox(height: 30),
                  _buildCompletionTracker(),
                  const SizedBox(height: 25),
                  _buildTopInfoCards(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Medical Conditions', true),
                  const SizedBox(height: 16),
                  _buildConditionCard(
                    title: 'Allergies',
                    icon: Icons.warning_amber_rounded,
                    iconColor: const Color(0xFFFF3B5C),
                    content: Wrap(
                      spacing: 8,
                      children: [
                        _buildTag('Penicillin', const Color(0xFFFF3B5C)),
                        _buildTag('Peanuts', const Color(0xFFFF3B5C)),
                      ],
                    ),
                  ),
                  _buildConditionCard(
                    title: 'Current Medications',
                    icon: Icons.medication_rounded,
                    iconColor: Colors.blue,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMedicationItem(
                          'Lisinopril',
                          '10mg - Daily morning',
                        ),
                        const SizedBox(height: 12),
                        _buildMedicationItem('Aspirin', '81mg - Daily'),
                      ],
                    ),
                  ),
                  _buildConditionCard(
                    title: 'Chronic Conditions',
                    icon: Icons.dangerous, // Custom icon representation
                    iconColor: Colors.orange,
                    content: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Type 2 Diabetes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Medical ID Image', false),
                  const SizedBox(height: 16),
                  _buildMedicalIDCard(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 15,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
          ),
          const Text(
            'Medical Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.ac_unit, color: Colors.white, size: 14),
                SizedBox(width: 6),
                Text(
                  'SOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=john'),
            ),
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF0A0A0F), width: 3),
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'John Doe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  'Age: 32',
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
                const SizedBox(width: 8),
                Text(
                  '•',
                  style: TextStyle(color: Colors.white.withOpacity(0.3)),
                ),
                const SizedBox(width: 8),
                Text(
                  'Male',
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
                const SizedBox(width: 8),
                Text(
                  '•',
                  style: TextStyle(color: Colors.white.withOpacity(0.3)),
                ),
                const SizedBox(width: 8),
                const Text(
                  '#LL-9921',
                  style: TextStyle(
                    color: Color(0xFFFF3B5C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ).animate().fadeIn().slideX(begin: -0.1);
  }

  Widget _buildCompletionTracker() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151313),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PROFILE COMPLETION',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const Text(
                '85%',
                style: TextStyle(
                  color: Color(0xFFFF3B5C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.85,
              minHeight: 8,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF3B5C)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopInfoCards() {
    return Row(
      children: [
        _buildMiniCard(
          'BLOOD TYPE',
          'O+',
          Icons.water_drop,
          const Color(0xFFFF3B5C),
        ),
        const SizedBox(width: 15),
        _buildMiniCard(
          'ICE CONTACT',
          '2 Listed',
          Icons.contact_emergency,
          Colors.blue,
        ),
      ],
    );
  }

  Widget _buildMiniCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF151313),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool showAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showAdd)
          Row(
            children: [
              const Icon(Icons.add_circle, color: Color(0xFFFF3B5C), size: 18),
              const SizedBox(width: 4),
              const Text(
                'Add',
                style: TextStyle(
                  color: Color(0xFFFF3B5C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildConditionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF151313),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.edit_outlined,
                color: Colors.white.withOpacity(0.3),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 20),
          content,
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05);
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildMedicationItem(String name, String dosage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          dosage,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildMedicalIDCard() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1584208124888-3a20b9c799e2?q=80&w=1000',
          ),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(30),
            // backdropFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.visibility, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                'View Card',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainFAB() {
    return Container(
      height: 72,
      width: 72,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)],
        ),
        boxShadow: [
          BoxShadow(color: Color(0xFFFF3B5C), blurRadius: 20, spreadRadius: 2),
        ],
      ),
      child: const Icon(Icons.location_on, color: Colors.white, size: 32),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0F),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 'Home', false),
          _buildNavItem(Icons.person, 'Profile', true),
          const SizedBox(width: 60),
          _buildNavItem(Icons.location_searching, 'Network', false),
          _buildNavItem(Icons.settings, 'Settings', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? const Color(0xFFFF3B5C) : Colors.white38),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFFFF3B5C) : Colors.white38,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
