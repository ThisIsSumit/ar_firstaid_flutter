import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/medical_profile_provider.dart';

class AddConditionDialog extends ConsumerStatefulWidget {
  const AddConditionDialog({super.key});

  @override
  ConsumerState<AddConditionDialog> createState() => _AddConditionDialogState();
}

class _AddConditionDialogState extends ConsumerState<AddConditionDialog> {
  final _controller = TextEditingController();
  String? _selectedCondition;

  final List<String> _commonConditions = [
    'Type 1 Diabetes',
    'Type 2 Diabetes',
    'Hypertension',
    'Asthma',
    'Heart Disease',
    'Epilepsy',
    'COPD',
    'Arthritis',
    'Other',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF15151A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9500).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.health_and_safety,
                      color: Color(0xFFFF9500),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Add Chronic Condition',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Select from common conditions:',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _commonConditions.map((condition) {
                  final isSelected = _selectedCondition == condition;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedCondition = condition);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFF9500).withOpacity(0.2)
                            : const Color(0xFF0A0A0B),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFFF9500)
                              : Colors.white.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        condition,
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFFFF9500)
                              : Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (_selectedCondition == 'Other') ...[
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter condition name',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                    filled: true,
                    fillColor: const Color(0xFF0A0A0B),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white.withOpacity(0.6)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      String conditionToAdd = _selectedCondition ?? '';
                      if (_selectedCondition == 'Other' &&
                          _controller.text.isNotEmpty) {
                        conditionToAdd = _controller.text;
                      }
                      if (conditionToAdd.isNotEmpty &&
                          conditionToAdd != 'Other') {
                        ref
                            .read(medicalProfileProvider.notifier)
                            .addChronicCondition(conditionToAdd);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
}
