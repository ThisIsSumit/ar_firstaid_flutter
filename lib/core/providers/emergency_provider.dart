import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum EmergencyStatus { none, selecting, active, resolved }

enum EmergencyType { medical, fire, accident, crime, natural, other }

enum SeverityLevel { low, medium, high, critical }

class EmergencyState {
  final EmergencyStatus status;
  final EmergencyType? type;
  final SeverityLevel? severity;
  final String? description;
  final DateTime? startTime;
  final String? emergencyId;

  EmergencyState({
    this.status = EmergencyStatus.none,
    this.type,
    this.severity,
    this.description,
    this.startTime,
    this.emergencyId,
  });

  EmergencyState copyWith({
    EmergencyStatus? status,
    EmergencyType? type,
    SeverityLevel? severity,
    String? description,
    DateTime? startTime,
    String? emergencyId,
  }) {
    return EmergencyState(
      status: status ?? this.status,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      emergencyId: emergencyId ?? this.emergencyId,
    );
  }

  bool get isActive => status == EmergencyStatus.active;
}

class EmergencyNotifier extends StateNotifier<EmergencyState> {
  EmergencyNotifier() : super(EmergencyState());

  void startSelection() =>
      state = state.copyWith(status: EmergencyStatus.selecting);
  void selectType(EmergencyType type) => state = state.copyWith(type: type);
  void selectSeverity(SeverityLevel severity) =>
      state = state.copyWith(severity: severity);
  void setDescription(String desc) => state = state.copyWith(description: desc);

  void confirmEmergency() {
    state = state.copyWith(
      status: EmergencyStatus.active,
      startTime: DateTime.now(),
      emergencyId: 'EMG-${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  void cancelEmergency() => state = EmergencyState();
  void reset() => state = EmergencyState();
}

final emergencyProvider =
    StateNotifierProvider<EmergencyNotifier, EmergencyState>(
      (ref) => EmergencyNotifier(),
    );

final isEmergencyActiveProvider = Provider<bool>(
  (ref) => ref.watch(emergencyProvider).isActive,
);

extension EmergencyTypeExt on EmergencyType {
  String get displayName => name[0].toUpperCase() + name.substring(1);
  String get icon =>
      const {
        'medical': '🏥',
        'fire': '🔥',
        'accident': '🚗',
        'crime': '🚨',
        'natural': '🌊',
        'other': '⚠️',
      }[name] ??
      '⚠️';
}

extension SeverityLevelExt on SeverityLevel {
  String get displayName => name[0].toUpperCase() + name.substring(1);
}
