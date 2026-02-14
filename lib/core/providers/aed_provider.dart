import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../models/aed_model.dart';

class AEDNotifier extends StateNotifier<List<AEDLocation>> {
  AEDNotifier() : super(_mockAEDData);

  static final List<AEDLocation> _mockAEDData = [
    AEDLocation(
      id: '1',
      name: 'City Hall AED',
      address: 'Main Lobby',
      location: 'Main Lobby, Ground Floor',
      latitude: 37.7749,
      longitude: -122.4194,
      distanceInMeters: 150,
      etaMinutes: 2,
      accessHours: '24/7',
      is24x7: true,
      status: AEDStatus.operational,
      lastChecked: DateTime.now().subtract(const Duration(hours: 2)),
      instructions:
          'Enter through main entrance, AED is mounted on the wall next to security desk.',
      floor: 'Level G',
    ),
    AEDLocation(
      id: '2',
      name: 'Public Library',
      address: 'West Wing Entrance',
      location: 'West Wing Entrance, Information Desk',
      latitude: 37.7759,
      longitude: -122.4204,
      distanceInMeters: 450,
      etaMinutes: 6,
      accessHours: '6 AM - 10 PM',
      is24x7: false,
      status: AEDStatus.operational,
      lastChecked: DateTime.now().subtract(const Duration(days: 1)),
      instructions: 'Available at information desk during opening hours.',
      floor: 'Level 1',
    ),
    AEDLocation(
      id: '3',
      name: 'Metro Station North',
      address: 'Security Booth',
      location: 'Platform Level, Security Booth',
      latitude: 37.7769,
      longitude: -122.4214,
      distanceInMeters: 800,
      etaMinutes: 10,
      accessHours: '24/7',
      is24x7: true,
      status: AEDStatus.operational,
      lastChecked: DateTime.now().subtract(const Duration(hours: 5)),
      instructions: 'Ask security personnel at entrance booth.',
      floor: 'Platform',
    ),
    AEDLocation(
      id: '4',
      name: 'Community Center',
      address: 'Main Reception',
      location: 'Reception Area, Near Elevators',
      latitude: 37.7739,
      longitude: -122.4184,
      distanceInMeters: 920,
      etaMinutes: 12,
      accessHours: '7 AM - 9 PM',
      is24x7: false,
      status: AEDStatus.operational,
      lastChecked: DateTime.now().subtract(const Duration(hours: 12)),
      instructions: 'Mounted on wall near elevator bank.',
      floor: 'Level 1',
    ),
  ];

  AEDLocation? get closestAED => state.isNotEmpty ? state.first : null;

  List<AEDLocation> get nearbyAEDs => state.skip(1).toList();

  void sortByDistance() {
    state = [...state]
      ..sort((a, b) => a.distanceInMeters.compareTo(b.distanceInMeters));
  }

  void reportIssue(String aedId, String issue) {
    state = state.map((aed) {
      if (aed.id == aedId) {
        return AEDLocation(
          id: aed.id,
          name: aed.name,
          address: aed.address,
          location: aed.location,
          latitude: aed.latitude,
          longitude: aed.longitude,
          distanceInMeters: aed.distanceInMeters,
          etaMinutes: aed.etaMinutes,
          accessHours: aed.accessHours,
          is24x7: aed.is24x7,
          status: AEDStatus.reported,
          lastChecked: aed.lastChecked,
          instructions: aed.instructions,
          floor: aed.floor,
        );
      }
      return aed;
    }).toList();
  }
}

final aedProvider = StateNotifierProvider<AEDNotifier, List<AEDLocation>>((
  ref,
) {
  return AEDNotifier();
});

final closestAEDProvider = Provider<AEDLocation?>((ref) {
  return ref.watch(aedProvider.notifier).closestAED;
});
