import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TreatmentLoggingPage extends StatelessWidget {
  const TreatmentLoggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF130D0D); // Very dark brown/black
    const Color cardBg = Color(0xFF1E1616);
    const Color primaryRed = Color(0xFFFF3B5C);
    const Color statusGreen = Color(0xFF10B981);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'At Scene Treatment',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Incident Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(radius: 4, backgroundColor: primaryRed),
                            const SizedBox(width: 8),
                            Text(
                              'ACTIVE INCIDENT',
                              style: TextStyle(
                                  color: primaryRed.withOpacity(0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'John Doe',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cardiac Arrest Case • Room 402',
                          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://i.pravatar.cc/100?u=nurse',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // EMS Arrival Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryRed, Color(0xFFE91E63)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: primaryRed.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EMS ARRIVAL',
                          style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                        ),
                        Text(
                          '4 mins away',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'En Route',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ).animate().shimmer(duration: 2.seconds),

            const SizedBox(height: 32),
            _buildSectionLabel('LOG QUICK ACTION'),
            const SizedBox(height: 16),
            
            // Quick Action Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.4,
              children: [
                _buildActionCard(Icons.timer_outlined, 'CPR Started', primaryRed),
                _buildActionCard(Icons.medical_services_outlined, 'AED Applied', primaryRed),
                _buildActionCard(Icons.flash_on_rounded, 'Shock Given', primaryRed),
                _buildActionCard(Icons.air_rounded, 'O2 Admin', primaryRed),
              ],
            ),

            const SizedBox(height: 32),
            _buildSectionLabel('TREATMENT CHECKLIST'),
            const SizedBox(height: 16),

            // Checklist Items
            _buildChecklistItem('Assess scene safety', '12:41', statusGreen, true, false),
            const SizedBox(height: 12),
            _buildChecklistItem('Check pulse & breathing', 'Recommended next step', primaryRed, false, true),
            const SizedBox(height: 12),
            _buildChecklistItem('Clear airway (Head tilt-chin lift)', null, Colors.white12, false, false),
            const SizedBox(height: 12),
            _buildChecklistItem('Begin 30:2 compressions', null, Colors.white12, false, false),
            const SizedBox(height: 12),
            _buildChecklistItem('Verify AED status', null, Colors.white12, false, false),

            const SizedBox(height: 40),
            
            // Complete Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  shape: RoundedRectangleAtMost(24),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_turned_in_rounded, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Complete Response',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ).animate().slideY(begin: 0.2, duration: 400.ms),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white.withOpacity(0.4),
        fontSize: 13,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String title, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1616),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accentColor, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String title, String? subtitle, Color color, bool isDone, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1616),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? color.withOpacity(0.5) : Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isActive ? color : Colors.white24, width: 2),
              color: isDone ? color : Colors.transparent,
            ),
            child: Icon(
              isDone ? Icons.check : null,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDone || isActive ? Colors.white : Colors.white.withOpacity(0.3),
                    fontSize: 15,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: isActive ? color : Colors.white.withOpacity(0.2),
                      fontSize: 11,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (isActive)
            Icon(Icons.priority_high_rounded, color: color, size: 16),
          if (isDone && subtitle != null)
            Text(
              subtitle,
              style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 11),
            ),
        ],
      ),
    );
  }
}

// Custom shape for the button
RoundedRectangleBorder RoundedRectangleAtMost(double radius) {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}