import 'package:flutter/material.dart';

class AEDFilterDialog extends StatefulWidget {
  const AEDFilterDialog({super.key});

  @override
  State<AEDFilterDialog> createState() => _AEDFilterDialogState();
}

class _AEDFilterDialogState extends State<AEDFilterDialog> {
  bool _show24x7Only = false;
  bool _showOperationalOnly = true;
  double _maxDistance = 2000; // in meters
  String _sortBy = 'distance'; // distance, name, availability

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF15151A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3053).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.tune,
                      color: Color(0xFFFF3053),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Filter AEDs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 24/7 Access Filter
              _buildSwitchTile(
                '24/7 Access Only',
                'Show only AEDs with round-the-clock access',
                Icons.access_time,
                _show24x7Only,
                (value) => setState(() => _show24x7Only = value),
              ),
              const SizedBox(height: 16),

              // Operational Status Filter
              _buildSwitchTile(
                'Operational Only',
                'Hide AEDs under maintenance',
                Icons.check_circle,
                _showOperationalOnly,
                (value) => setState(() => _showOperationalOnly = value),
              ),
              const SizedBox(height: 24),

              // Distance Slider
              Text(
                'Maximum Distance',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: const Color(0xFFFF3053),
                        inactiveTrackColor: Colors.white12,
                        thumbColor: const Color(0xFFFF3053),
                        overlayColor: const Color(0xFFFF3053).withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: _maxDistance,
                        min: 100,
                        max: 5000,
                        divisions: 49,
                        onChanged: (value) {
                          setState(() => _maxDistance = value);
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3053).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _maxDistance >= 1000
                          ? '${(_maxDistance / 1000).toStringAsFixed(1)} km'
                          : '${_maxDistance.toInt()} m',
                      style: const TextStyle(
                        color: Color(0xFFFF3053),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sort By Section
              Text(
                'Sort By',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildSortOption(
                'Distance',
                'Nearest first',
                Icons.place,
                'distance',
              ),
              const SizedBox(height: 8),
              _buildSortOption(
                'Name',
                'Alphabetical order',
                Icons.sort_by_alpha,
                'name',
              ),
              const SizedBox(height: 8),
              _buildSortOption(
                'Availability',
                '24/7 access first',
                Icons.schedule,
                'availability',
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _show24x7Only = false;
                          _showOperationalOnly = true;
                          _maxDistance = 2000;
                          _sortBy = 'distance';
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply filters
                        Navigator.pop(context, {
                          'show24x7Only': _show24x7Only,
                          'showOperationalOnly': _showOperationalOnly,
                          'maxDistance': _maxDistance,
                          'sortBy': _sortBy,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3053),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1C1C),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value
              ? const Color(0xFFFF3053).withOpacity(0.3)
              : Colors.white.withOpacity(0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: value
                  ? const Color(0xFFFF3053).withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: value ? const Color(0xFFFF3053) : Colors.white38,
              size: 20,
            ),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFF3053),
            activeTrackColor: const Color(0xFFFF3053).withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(
    String title,
    String subtitle,
    IconData icon,
    String value,
  ) {
    final isSelected = _sortBy == value;
    return GestureDetector(
      onTap: () => setState(() => _sortBy = value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF3053).withOpacity(0.1)
              : const Color(0xFF1E1C1C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFFF3053)
                : Colors.white.withOpacity(0.05),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFFF3053) : Colors.white38,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFFFF3053)
                          : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFFF3053),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
