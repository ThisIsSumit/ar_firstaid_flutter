class AEDLocation {
  final String id;
  final String name;
  final String address;
  final String location;
  final double latitude;
  final double longitude;
  final double distanceInMeters;
  final int etaMinutes;
  final String accessHours;
  final bool is24x7;
  final AEDStatus status;
  final DateTime lastChecked;
  final String instructions;
  final String floor;

  AEDLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.distanceInMeters,
    required this.etaMinutes,
    required this.accessHours,
    required this.is24x7,
    required this.status,
    required this.lastChecked,
    required this.instructions,
    required this.floor,
  });

  String get distanceFormatted {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toInt()}m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)}km';
    }
  }
}

enum AEDStatus { operational, underMaintenance, reported }
