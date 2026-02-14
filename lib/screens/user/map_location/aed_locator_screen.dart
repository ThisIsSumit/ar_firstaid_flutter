import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/aed_provider.dart';
import '../../../models/aed_model.dart';
import 'aed_details_page.dart';
import 'aed_directions_page.dart';
import 'aed_filter_dialog.dart';
import 'report_aed_issue_dialog.dart';

class AEDLocatorScreen extends ConsumerStatefulWidget {
  const AEDLocatorScreen({super.key});

  @override
  ConsumerState<AEDLocatorScreen> createState() => _AEDLocatorScreenState();
}

class _AEDLocatorScreenState extends ConsumerState<AEDLocatorScreen> {
  bool _showAllAEDs = false;

  @override
  Widget build(BuildContext context) {
    final closestAED = ref.watch(closestAEDProvider);
    final nearbyAEDs = ref.watch(aedProvider.notifier).nearbyAEDs;

    if (closestAED == null) {
      return _buildNoAEDFound();
    }

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
                _buildCircularButton(
                  Icons.arrow_back,
                  onTap: () => context.pop(),
                ),
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
                _buildCircularButton(
                  Icons.filter_list,
                  onTap: () => _showFilterDialog(),
                ),
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
                      _buildHeaderSection(closestAED),

                      const SizedBox(height: 24),

                      // Info Cards Row
                      _buildInfoCardsRow(closestAED),

                      const SizedBox(height: 24),

                      // Action Buttons
                      _buildActionButtons(closestAED),

                      const SizedBox(height: 32),

                      // Nearby Section
                      _buildNearbySectionHeader(),
                      const SizedBox(height: 16),

                      // Nearby AED List
                      ...nearbyAEDs
                          .take(_showAllAEDs ? nearbyAEDs.length : 2)
                          .map((aed) => _buildNearbyItem(aed))
                          .toList(),

                      if (nearbyAEDs.length > 2 && !_showAllAEDs)
                        _buildViewAllButton(nearbyAEDs.length),

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

  Widget _buildHeaderSection(AEDLocation aed) {
    return Row(
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
                    aed.is24x7 ? '24/7 ACCESS' : aed.accessHours,
                    aed.is24x7 ? const Color(0xFF2E7D32) : Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _navigateToDetails(aed),
                child: Text(
                  aed.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${aed.address} • ${aed.distanceFormatted} away',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _navigateToDetails(aed),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD600),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.favorite, color: Colors.black, size: 28),
          ),
        ),
      ],
    ).animate().fadeIn().slideY(begin: 0.1);
  }

  Widget _buildInfoCardsRow(AEDLocation aed) {
    return Row(
      children: [
        _buildInfoCard(
          Icons.directions_walk,
          'ETA WALK',
          '${aed.etaMinutes} min',
        ),
        const SizedBox(width: 12),
        _buildInfoCard(Icons.stairs, 'LOCATION', aed.floor),
      ],
    ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildActionButtons(AEDLocation aed) {
    return Column(
      children: [
        // Primary Direction Button
        GestureDetector(
          onTap: () => _startDirections(aed),
          child: Container(
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
          ),
        ).animate().shimmer(delay: 1.seconds, duration: 2.seconds),
        const SizedBox(height: 12),
        // Secondary Buttons Row
        Row(
          children: [
            Expanded(
              child: _buildSecondaryButton(
                'Call 911',
                Icons.phone,
                () => _showCallDialog(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSecondaryButton(
                'Report Issue',
                Icons.report_problem,
                () => _showReportDialog(aed),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryButton(
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1C1C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbySectionHeader() {
    return Row(
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
        GestureDetector(
          onTap: () {
            setState(() => _showAllAEDs = !_showAllAEDs);
          },
          child: Text(
            _showAllAEDs ? 'Show Less' : 'View All',
            style: const TextStyle(
              color: Color(0xFFFF3053),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewAllButton(int count) {
    return GestureDetector(
      onTap: () {
        setState(() => _showAllAEDs = true);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1C1C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFF3053).withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View ${count - 2} more AEDs',
              style: const TextStyle(
                color: Color(0xFFFF3053),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Color(0xFFFF3053), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyItem(AEDLocation aed) {
    Color iconColor = aed.is24x7
        ? const Color(0xFFFFD600)
        : const Color(0xFF2196F3);
    Color timeColor = aed.is24x7
        ? const Color(0xFF2E7D32).withOpacity(0.2)
        : Colors.white12;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () => _navigateToDetails(aed),
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
                    aed.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${aed.distanceFormatted} • ${aed.address}',
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
                aed.is24x7 ? '24/7' : aed.accessHours.split(' - ').first,
                style: TextStyle(
                  color: aed.is24x7
                      ? const Color(0xFF2E7D32)
                      : Colors.white.withOpacity(0.6),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
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

  Widget _buildNoAEDFound() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, color: Color(0xFFFF3053), size: 80),
            const SizedBox(height: 24),
            const Text(
              'No AEDs Found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Unable to find AEDs near your location',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(AEDLocation aed) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AEDDetailsPage(aed: aed)),
    );
  }

  void _startDirections(AEDLocation aed) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AEDDirectionsPage(aed: aed)),
    );
  }

  void _showFilterDialog() {
    showDialog(context: context, builder: (context) => const AEDFilterDialog());
  }

  void _showReportDialog(AEDLocation aed) {
    showDialog(
      context: context,
      builder: (context) => ReportAEDIssueDialog(aed: aed),
    );
  }

  void _showCallDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF15151A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Row(
          children: [
            Icon(Icons.phone, color: Color(0xFFFF3053)),
            SizedBox(width: 12),
            Text('Call Emergency', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: const Text(
          'Do you want to call 911?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement actual phone call
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Calling 911...')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF3053),
            ),
            child: const Text('Call'),
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
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: const Icon(Icons.favorite, color: Colors.white, size: 14),
    );
  }
}
