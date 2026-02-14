class MedicalProfile {
  String? name;
  int? age;
  String? gender;
  String? bloodType;
  List<String> allergies;
  List<Medication> medications;
  List<String> chronicConditions;
  List<EmergencyContact> emergencyContacts;
  String? medicalIdImagePath;
  double? height;
  double? weight;
  String? insuranceProvider;
  String? policyNumber;
  bool isOnboardingComplete;

  MedicalProfile({
    this.name,
    this.age,
    this.gender,
    this.bloodType,
    this.allergies = const [],
    this.medications = const [],
    this.chronicConditions = const [],
    this.emergencyContacts = const [],
    this.medicalIdImagePath,
    this.height,
    this.weight,
    this.insuranceProvider,
    this.policyNumber,
    this.isOnboardingComplete = false,
  });

  double get completionPercentage {
    int totalFields = 12;
    int filledFields = 0;

    if (name != null && name!.isNotEmpty) filledFields++;
    if (age != null) filledFields++;
    if (gender != null && gender!.isNotEmpty) filledFields++;
    if (bloodType != null && bloodType!.isNotEmpty) filledFields++;
    if (allergies.isNotEmpty) filledFields++;
    if (medications.isNotEmpty) filledFields++;
    if (chronicConditions.isNotEmpty) filledFields++;
    if (emergencyContacts.isNotEmpty) filledFields++;
    if (medicalIdImagePath != null) filledFields++;
    if (height != null) filledFields++;
    if (weight != null) filledFields++;
    if (insuranceProvider != null && insuranceProvider!.isNotEmpty) {
      filledFields++;
    }

    return (filledFields / totalFields * 100);
  }
}

class Medication {
  String name;
  String dosage;
  String frequency;
  DateTime? startDate;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    this.startDate,
  });
}

class EmergencyContact {
  String name;
  String relationship;
  String phoneNumber;

  EmergencyContact({
    required this.name,
    required this.relationship,
    required this.phoneNumber,
  });
}
