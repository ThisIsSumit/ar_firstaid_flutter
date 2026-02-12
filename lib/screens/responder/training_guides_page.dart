import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TrainingGuidesPage extends ConsumerWidget {
  const TrainingGuidesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color scaffoldBg = Color(0xFF0F0E0E);
    const Color primaryRed = Color(0xFFFF3B5C);
    const Color cardBg = Color(0xFF1A1A24);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: _buildAppBar(context, primaryRed),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildSectionHeader('CURRENT CERTIFICATIONS', '2 active', primaryRed),
            const SizedBox(height: 16),
            _buildCertificationsList(primaryRed, cardBg),
            const SizedBox(height: 32),
            _buildProgressCard(primaryRed, cardBg),
            const SizedBox(height: 32),
            _buildSectionHeader('QUICK EMERGENCY GUIDES', 'View All', primaryRed),
            const SizedBox(height: 16),
            _buildQuickGuidesList(cardBg),
            const SizedBox(height: 32),
            _buildSectionHeader('BROWSE BY CATEGORY', null, primaryRed),
            const SizedBox(height: 16),
            _buildCategoriesList(cardBg, primaryRed),
            const SizedBox(height: 120), // Bottom nav padding
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, Color primaryRed) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: primaryRed),
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'Training & Guides',
        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.search, color: Colors.white70), onPressed: () {}),
        IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.white70), onPressed: () {}),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String? trailing, Color primaryRed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: primaryRed,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _buildCertificationsList(Color primaryRed, Color cardBg) {
    return SizedBox(
      height: 170,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          _buildCertCard('Standard First Aid', 'Red Cross International', 'Expires Nov 2025', true, Icons.verified_user, primaryRed, cardBg),
          const SizedBox(width: 16),
          _buildCertCard('BLS / CPR', 'American Heart Association', 'Expired', false, Icons.medical_services, Colors.blueAccent, cardBg),
        ],
      ),
    );
  }

  Widget _buildCertCard(String title, String provider, String expiry, bool active, IconData icon, Color color, Color bg) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 20),
              ),
              if (active)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF22C55E).withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: const Text('ACTIVE', style: TextStyle(color: Color(0xFF22C55E), fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(provider, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(active ? Icons.calendar_today : Icons.warning_amber, color: active ? Colors.white30 : Colors.amber, size: 14),
              const SizedBox(width: 6),
              Text(expiry, style: TextStyle(color: active ? Colors.white30 : Colors.amber, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(Color primaryRed, Color cardBg) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Advanced Responder Course', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Module 4 of 12: Trauma Assessment', style: TextStyle(color: Colors.white38, fontSize: 13)),
                  ],
                ),
                Text('35%', style: TextStyle(color: primaryRed, fontSize: 24, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(value: 0.35, minHeight: 8, backgroundColor: Colors.white10, color: primaryRed),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Resume Training', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.play_arrow_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickGuidesList(Color cardBg) {
    final guides = [
      {'title': 'Adult CPR', 'time': '2:45', 'icon': Icons.favorite},
      {'title': 'Choking', 'time': '1:30', 'icon': Icons.air},
      {'title': 'Severe Bleeding', 'time': '4:15', 'icon': Icons.bloodtype},
      {'title': 'Seizure Response', 'time': '3:05', 'icon': Icons.flash_on},
    ];

    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: guides.length,
        itemBuilder: (context, index) {
          final guide = guides[index];
          return Container(
            width: 170,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(24)),
                    child: Stack(
                      children: [
                        Center(child: Icon(guide['icon'] as IconData, color: Colors.white10, size: 60)),
                        Positioned(top: 12, left: 12, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)), child: Text(guide['time'] as String, style: const TextStyle(color: Colors.white, fontSize: 10)))),
                        const Center(child: CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.play_arrow, color: Colors.white))),
                      ],
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(16), child: Text(guide['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesList(Color cardBg, Color primaryRed) {
    final cats = [
      {'t': 'Pediatric First Aid', 'i': Icons.child_care},
      {'t': 'Wilderness & Outdoor', 'i': Icons.terrain},
      {'t': 'Environmental Hazards', 'i': Icons.visibility},
    ];
    return Column(
      children: cats.map((c) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        child: ListTile(
          tileColor: cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Icon(c['i'] as IconData, color: primaryRed),
          title: Text(c['t'] as String, style: const TextStyle(color: Colors.white)),
          trailing: const Icon(Icons.chevron_right, color: Colors.white24),
        ),
      )).toList(),
    );
  }
}