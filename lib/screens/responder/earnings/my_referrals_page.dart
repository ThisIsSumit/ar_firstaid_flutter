import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class MyReferralsPage extends StatefulWidget {
  const MyReferralsPage({Key? key}) : super(key: key);

  @override
  State<MyReferralsPage> createState() => _MyReferralsPageState();
}

class _MyReferralsPageState extends State<MyReferralsPage> {
  int _selectedFilter = 0;

  final List<ReferralItem> _allReferrals = [
    ReferralItem(
      id: 'ref_1',
      name: 'Alex Johnson',
      email: 'alex@example.com',
      avatar: 'https://i.pravatar.cc/150?u=alex@example.com',
      status: 'verified',
      joinedDate: DateTime.now().subtract(const Duration(days: 30)),
      rewardEarned: 500,
      isActive: true,
    ),
    ReferralItem(
      id: 'ref_2',
      name: 'Sarah Williams',
      email: 'sarah@example.com',
      avatar: 'https://i.pravatar.cc/150?u=sarah@example.com',
      status: 'verified',
      joinedDate: DateTime.now().subtract(const Duration(days: 15)),
      rewardEarned: 500,
      isActive: true,
    ),
    ReferralItem(
      id: 'ref_3',
      name: 'Marcus Brown',
      email: 'marcus@example.com',
      avatar: 'https://i.pravatar.cc/150?u=marcus@example.com',
      status: 'pending',
      joinedDate: DateTime.now().subtract(const Duration(days: 5)),
      rewardEarned: 0,
      isActive: false,
    ),
    ReferralItem(
      id: 'ref_4',
      name: 'Emily Davis',
      email: 'emily@example.com',
      avatar: 'https://i.pravatar.cc/150?u=emily@example.com',
      status: 'verified',
      joinedDate: DateTime.now().subtract(const Duration(days: 45)),
      rewardEarned: 500,
      isActive: true,
    ),
  ];

  List<ReferralItem> get _filteredReferrals {
    switch (_selectedFilter) {
      case 1:
        return _allReferrals.where((r) => r.status == 'verified').toList();
      case 2:
        return _allReferrals.where((r) => r.status == 'pending').toList();
      default:
        return _allReferrals;
    }
  }

  int get _totalRewards =>
      _allReferrals.fold(0, (sum, r) => sum + r.rewardEarned);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'MY REFERRALS',
          style: GoogleFonts.inter(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            // Summary Cards
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Total Referrals',
                      value: '${_allReferrals.length}',
                      icon: Icons.people_outline,
                      color: const Color(0xFF00FF85),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryCard(
                      title: 'Rewards Earned',
                      value: '$_totalRewards',
                      icon: Icons.star_outline,
                      color: const Color(0xFFC5A358),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Filter Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Referrals',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('All', 0),
                        const SizedBox(width: 8),
                        _buildFilterChip('Verified', 1),
                        const SizedBox(width: 8),
                        _buildFilterChip('Pending', 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Referrals List
            ..._filteredReferrals.asMap().entries.map((entry) {
              int index = entry.key;
              ReferralItem referral = entry.value;
              return _buildReferralTile(
                referral,
              ).animate().fadeIn(delay: (100 * index).ms, duration: 400.ms);
            }),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.white38,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              Icon(icon, color: color, size: 18),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    bool isSelected = _selectedFilter == index;
    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.black : Colors.white70,
        ),
      ),
      onSelected: (selected) {
        setState(() => _selectedFilter = index);
      },
      selectedColor: const Color(0xFF00FF85),
      backgroundColor: Colors.white.withOpacity(0.05),
      side: BorderSide(
        color: isSelected
            ? const Color(0xFF00FF85)
            : Colors.white.withOpacity(0.1),
      ),
    );
  }

  Widget _buildReferralTile(ReferralItem referral) {
    Color statusColor = referral.status == 'verified'
        ? const Color(0xFF00FF85)
        : Colors.white38;
    String statusLabel = referral.status == 'verified' ? 'VERIFIED' : 'PENDING';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: statusColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    referral.avatar,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.person, color: statusColor),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      referral.name,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      referral.email,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white38,
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
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  statusLabel,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          if (referral.status == 'verified')
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Joined ${_getDaysAgo(referral.joinedDate)}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.white24,
                    ),
                  ),
                  Text(
                    '+${referral.rewardEarned} credits',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF00FF85),
                    ),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Invitation sent ${_getDaysAgo(referral.joinedDate)}',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.white24,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getDaysAgo(DateTime date) {
    final difference = DateTime.now().difference(date).inDays;
    if (difference == 0) return 'today';
    if (difference == 1) return '1 day ago';
    if (difference < 30) return '$difference days ago';
    final months = (difference / 30).floor();
    if (months == 1) return '1 month ago';
    return '$months months ago';
  }
}

class ReferralItem {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String status; // 'verified', 'pending'
  final DateTime joinedDate;
  final int rewardEarned;
  final bool isActive;

  ReferralItem({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.status,
    required this.joinedDate,
    required this.rewardEarned,
    required this.isActive,
  });
}
