import 'package:ar_firstaid_flutter/screens/medical_profile/add_allergy_dialog.dart';
import 'package:ar_firstaid_flutter/screens/medical_profile/add_medication_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/providers/medical_profile_provider.dart';
import '../../core/router/app_router.dart';
import 'add_allergy_dialog.dart';
import 'add_medication_dialog.dart';
import 'add_condition_dialog.dart';
import 'add_emergency_contact_dialog.dart';

class MedicalProfilePage extends ConsumerWidget {
  const MedicalProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(medicalProfileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildAppBar(context)),
          SliverToBoxAdapter(child: const SizedBox(height: 16)),
          SliverToBoxAdapter(child: _buildProfileHeader(profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(child: _buildCompletionTracker(profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(child: _buildTopInfoCards(profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Allergies', true, () {
              showDialog(
                context: context,
                builder: (context) => const AddAllergyDialog(),
              );
            }),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildAllergiesCard(ref, profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Current Medications', true, () {
              showDialog(
                context: context,
                builder: (context) => const AddMedicationDialog(),
              );
            }),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildMedicationsCard(ref, profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Chronic Conditions', true, () {
              showDialog(
                context: context,
                builder: (context) => const AddConditionDialog(),
              );
            }),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildConditionsCard(ref, profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: _buildSectionHeader('Emergency Contacts', true, () {
              showDialog(
                context: context,
                builder: (context) => const AddEmergencyContactDialog(),
              );
            }),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 12)),
          SliverToBoxAdapter(child: _buildEmergencyContactsCard(ref, profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 20)),
          SliverToBoxAdapter(child: _buildMedicalIDCard(context, ref, profile)),
          SliverToBoxAdapter(child: const SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: _buildMainFAB(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.go(AppRoutes.home),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const Text(
            'Medical Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF3B5C).withOpacity(0.8),
                  const Color(0xFFFF3B5C),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF3B5C).withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 35),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name ?? 'Not set',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${profile.age ?? "?"} years • ${profile.gender ?? "Not set"}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B5C).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFF3B5C).withOpacity(0.3),
              ),
            ),
            child: Text(
              profile.bloodType ?? '?',
              style: const TextStyle(
                color: Color(0xFFFF3B5C),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ).animate().fadeIn().slideX(begin: -0.1),
    );
  }

  Widget _buildCompletionTracker(profile) {
    final completion = profile.completionPercentage;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF00FF85).withOpacity(0.1),
              const Color(0xFF00FF85).withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF00FF85).withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile Completion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${completion.toInt()}%',
                  style: const TextStyle(
                    color: Color(0xFF00FF85),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: completion / 100,
                minHeight: 8,
                backgroundColor: Colors.white.withOpacity(0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF00FF85),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              completion < 100
                  ? 'Complete your profile for better emergency response'
                  : '✓ Profile is complete!',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildTopInfoCards(profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildMiniCard(
            'Height',
            profile.height != null
                ? '${profile.height!.toInt()} cm'
                : 'Not set',
            Icons.height,
            const Color(0xFF3B82F6),
          ),
          const SizedBox(width: 12),
          _buildMiniCard(
            'Weight',
            profile.weight != null
                ? '${profile.weight!.toInt()} kg'
                : 'Not set',
            Icons.monitor_weight,
            const Color(0xFFFF9500),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF15151A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
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
      ).animate().fadeIn(delay: 150.ms).scale(),
    );
  }

  Widget _buildSectionHeader(String title, bool showAdd, VoidCallback? onAdd) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (showAdd)
            GestureDetector(
              onTap: onAdd,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B5C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Add',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAllergiesCard(WidgetRef ref, profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF15151A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: profile.allergies.isEmpty
            ? Center(
                child: Text(
                  'No allergies recorded',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: profile.allergies.map<Widget>((allergy) {
                  return _buildTag(
                    allergy,
                    const Color(0xFFFF3B5C),
                    () => ref
                        .read(medicalProfileProvider.notifier)
                        .removeAllergy(allergy),
                  );
                }).toList(),
              ),
      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05),
    );
  }

  Widget _buildMedicationsCard(WidgetRef ref, profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF15151A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: profile.medications.isEmpty
            ? Center(
                child: Text(
                  'No medications recorded',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              )
            : Column(
                children: profile.medications.map<Widget>((med) {
                  return _buildMedicationItem(
                    ref,
                    med.name,
                    med.dosage,
                    med.frequency,
                    med,
                  );
                }).toList(),
              ),
      ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.05),
    );
  }

  Widget _buildMedicationItem(
    WidgetRef ref,
    String name,
    String dosage,
    String frequency,
    medication,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF00FF85).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.medication,
              color: Color(0xFF00FF85),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$dosage • $frequency',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => ref
                .read(medicalProfileProvider.notifier)
                .removeMedication(medication),
            icon: Icon(
              Icons.close,
              color: Colors.white.withOpacity(0.5),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionsCard(WidgetRef ref, profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF15151A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: profile.chronicConditions.isEmpty
            ? Center(
                child: Text(
                  'No chronic conditions recorded',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: profile.chronicConditions.map<Widget>((condition) {
                  return _buildTag(
                    condition,
                    const Color(0xFFFF9500),
                    () => ref
                        .read(medicalProfileProvider.notifier)
                        .removeChronicCondition(condition),
                  );
                }).toList(),
              ),
      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.05),
    );
  }

  Widget _buildEmergencyContactsCard(WidgetRef ref, profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF15151A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: profile.emergencyContacts.isEmpty
            ? Center(
                child: Text(
                  'No emergency contacts added',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              )
            : Column(
                children: profile.emergencyContacts.map<Widget>((contact) {
                  return _buildEmergencyContactItem(
                    ref,
                    contact.name,
                    contact.relationship,
                    contact.phoneNumber,
                    contact,
                  );
                }).toList(),
              ),
      ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.05),
    );
  }

  Widget _buildEmergencyContactItem(
    WidgetRef ref,
    String name,
    String relationship,
    String phone,
    contact,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.contact_emergency,
              color: Color(0xFF3B82F6),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$relationship • $phone',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => ref
                .read(medicalProfileProvider.notifier)
                .removeEmergencyContact(contact),
            icon: Icon(
              Icons.close,
              color: Colors.white.withOpacity(0.5),
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, color: color, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalIDCard(BuildContext context, WidgetRef ref, profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFF3B5C).withOpacity(0.2),
              const Color(0xFFFF3B5C).withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFF3B5C).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B5C).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.credit_card,
                    color: Color(0xFFFF3B5C),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical ID Card',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Upload your medical ID',
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  ref
                      .read(medicalProfileProvider.notifier)
                      .updateMedicalIdImage(image.path);
                }
              },
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: profile.medicalIdImagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          profile.medicalIdImagePath!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate,
                              color: Color(0xFFFF3B5C),
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to upload',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: 400.ms).scale(),
    );
  }

  Widget _buildMainFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.push(AppRoutes.editBasicInfo),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      icon: const Icon(Icons.edit, color: Colors.black),
      label: const Text(
        'Edit Profile',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
