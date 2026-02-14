import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/medical_profile_provider.dart';
import '../../core/router/app_router.dart';

class MedicalProfileFormPage extends ConsumerStatefulWidget {
  const MedicalProfileFormPage({super.key});

  @override
  ConsumerState<MedicalProfileFormPage> createState() =>
      _MedicalProfileFormPageState();
}

class _MedicalProfileFormPageState
    extends ConsumerState<MedicalProfileFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _selectedGender;
  String? _selectedBloodType;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      // Save basic info
      ref
          .read(medicalProfileProvider.notifier)
          .updateBasicInfo(
            name: _nameController.text,
            age: int.tryParse(_ageController.text),
            gender: _selectedGender,
            bloodType: _selectedBloodType,
            height: double.tryParse(_heightController.text),
            weight: double.tryParse(_weightController.text),
          );

      // Mark as completed
      ref.read(medicalProfileProvider.notifier).markOnboardingComplete();

      // Navigate to medical profile page
      context.go(AppRoutes.medicalProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Medical profile created successfully!'),
          backgroundColor: Color(0xFF00FF85),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0B),
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text(
          'Create Medical Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Header
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3B5C).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medical_services,
                  color: Color(0xFFFF3B5C),
                  size: 48,
                ),
              ),
            ).animate().scale(duration: 400.ms),
            const SizedBox(height: 16),
            Text(
              'Let\'s set up your profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
              ),
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 32),

            // Form Fields
            _buildTextField(
              controller: _nameController,
              label: 'Full Name',
              icon: Icons.person,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter your name';
                return null;
              },
            ).animate().slideX(begin: -0.1, delay: 300.ms).fadeIn(),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _ageController,
              label: 'Age',
              icon: Icons.cake,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Please enter your age';
                if (int.tryParse(value!) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ).animate().slideX(begin: -0.1, delay: 350.ms).fadeIn(),
            const SizedBox(height: 16),

            _buildDropdown(
              label: 'Gender',
              icon: Icons.wc,
              value: _selectedGender,
              items: _genders,
              onChanged: (value) => setState(() => _selectedGender = value),
            ).animate().slideX(begin: -0.1, delay: 400.ms).fadeIn(),
            const SizedBox(height: 16),

            _buildDropdown(
              label: 'Blood Type',
              icon: Icons.water_drop,
              value: _selectedBloodType,
              items: _bloodTypes,
              onChanged: (value) => setState(() => _selectedBloodType = value),
            ).animate().slideX(begin: -0.1, delay: 450.ms).fadeIn(),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _heightController,
              label: 'Height (cm)',
              icon: Icons.height,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ).animate().slideX(begin: -0.1, delay: 500.ms).fadeIn(),
            const SizedBox(height: 16),

            _buildTextField(
              controller: _weightController,
              label: 'Weight (kg)',
              icon: Icons.monitor_weight,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ).animate().slideX(begin: -0.1, delay: 550.ms).fadeIn(),
            const SizedBox(height: 32),

            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B5C).withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFF3B5C).withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFFF3B5C),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You can add allergies, medications, and emergency contacts later',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms),
            const SizedBox(height: 32),

            // Save Button
            Container(
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF3B5C).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _saveAndContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3B5C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Create Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: 700.ms)
                .scale(begin: const Offset(0.95, 0.95)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          prefixIcon: Icon(icon, color: const Color(0xFFFF3B5C)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF15151A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF3B5C)),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(
                  label,
                  style: TextStyle(color: Colors.white.withOpacity(0.6)),
                ),
                dropdownColor: const Color(0xFF15151A),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                items: items.map((item) {
                  return DropdownMenuItem(value: item, child: Text(item));
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
