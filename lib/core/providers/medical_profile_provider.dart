import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../models/medical_profile_model.dart';

class MedicalProfileNotifier extends StateNotifier<MedicalProfile> {
  MedicalProfileNotifier() : super(MedicalProfile());

  // Check if onboarding is completed
  bool get isOnboardingComplete => state.isOnboardingComplete;

  // Mark onboarding as complete
  void markOnboardingComplete() {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: true,
    );
  }

  void updateBasicInfo({
    String? name,
    int? age,
    String? gender,
    String? bloodType,
    double? height,
    double? weight,
  }) {
    state = MedicalProfile(
      name: name ?? state.name,
      age: age ?? state.age,
      gender: gender ?? state.gender,
      bloodType: bloodType ?? state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: height ?? state.height,
      weight: weight ?? state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void addAllergy(String allergy) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: [...state.allergies, allergy],
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void removeAllergy(String allergy) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies.where((a) => a != allergy).toList(),
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void addMedication(Medication medication) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: [...state.medications, medication],
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void removeMedication(Medication medication) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications.where((m) => m != medication).toList(),
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void addChronicCondition(String condition) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: [...state.chronicConditions, condition],
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void removeChronicCondition(String condition) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: state.chronicConditions
          .where((c) => c != condition)
          .toList(),
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void addEmergencyContact(EmergencyContact contact) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: [...state.emergencyContacts, contact],
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void removeEmergencyContact(EmergencyContact contact) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts
          .where((c) => c != contact)
          .toList(),
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void updateMedicalIdImage(String path) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: path,
      height: state.height,
      weight: state.weight,
      insuranceProvider: state.insuranceProvider,
      policyNumber: state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }

  void updateInsurance({String? provider, String? policyNumber}) {
    state = MedicalProfile(
      name: state.name,
      age: state.age,
      gender: state.gender,
      bloodType: state.bloodType,
      allergies: state.allergies,
      medications: state.medications,
      chronicConditions: state.chronicConditions,
      emergencyContacts: state.emergencyContacts,
      medicalIdImagePath: state.medicalIdImagePath,
      height: state.height,
      weight: state.weight,
      insuranceProvider: provider ?? state.insuranceProvider,
      policyNumber: policyNumber ?? state.policyNumber,
      isOnboardingComplete: state.isOnboardingComplete,
    );
  }
}

final medicalProfileProvider =
    StateNotifierProvider<MedicalProfileNotifier, MedicalProfile>((ref) {
      return MedicalProfileNotifier();
    });
