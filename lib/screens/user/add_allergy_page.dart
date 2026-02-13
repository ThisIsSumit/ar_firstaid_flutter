import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';

class AddAllergyPage extends StatefulWidget {
  const AddAllergyPage({super.key});

  @override
  State<AddAllergyPage> createState() => _AddAllergyPageState();
}

class _AddAllergyPageState extends State<AddAllergyPage> {
  bool _carriesEpiPen = false;

  @override
  Widget build(BuildContext context) {
    const Color surfaceColor = Color(0xFF15151A);
    const Color bgColor = Color(0xFF0A0A0B);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 100,
        leading: TextButton.icon(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryRed,
            size: 18,
          ),
          label: const Text(
            'Medical',
            style: TextStyle(color: AppColors.primaryRed, fontSize: 17),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Add New Allergy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Header Icon Section
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryRed.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.medical_services,
                  color: AppColors.primaryRed,
                  size: 32,
                ),
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.easeOut),

            const SizedBox(height: 24),
            Text(
              'Provide accurate information to help emergency\nresponders treat you effectively.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 15,
                height: 1.4,
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 48),

            // Form Fields
            _buildInputField(
              label: 'Allergen Name',
              placeholder: 'e.g., Peanuts, Penicillin',
              surfaceColor: surfaceColor,
            ).animate().slideY(begin: 0.1, delay: 300.ms).fadeIn(),

            const SizedBox(height: 24),

            _buildDropdownField(
              label: 'Severity Level',
              placeholder: 'Select severity',
              surfaceColor: surfaceColor,
            ).animate().slideY(begin: 0.1, delay: 400.ms).fadeIn(),

            const SizedBox(height: 12),
            Row(
              children: [
                _buildDot(const Color(0xFFFFD60A)),
                _buildDot(const Color(0xFFFF9F0A)),
                _buildDot(const Color(0xFFFF3B5C)),
                const SizedBox(width: 8),
                Text(
                  'Select the highest risk potential',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 500.ms),

            const SizedBox(height: 32),

            _buildInputField(
              label: 'Reaction Description',
              placeholder:
                  'Describe what happens when exposed (e.g., throat swelling, immediate hives, rapid heartbeat)...',
              surfaceColor: surfaceColor,
              maxLines: 4,
            ).animate().slideY(begin: 0.1, delay: 600.ms).fadeIn(),

            const SizedBox(height: 32),

            // EpiPen Toggle Card
            GestureDetector(
              onTap: () => setState(() => _carriesEpiPen = !_carriesEpiPen),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _carriesEpiPen
                      ? AppColors.primaryRed.withValues(alpha: 0.05)
                      : surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _carriesEpiPen
                        ? AppColors.primaryRed.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _carriesEpiPen
                              ? AppColors.primaryRed
                              : Colors.white24,
                          width: 2,
                        ),
                      ),
                      child: _carriesEpiPen
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 16,
                                color: AppColors.primaryRed,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Carries Epinephrine Pen',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Tick if an auto-injector is usually carried.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().slideY(begin: 0.1, delay: 700.ms).fadeIn(),

            const SizedBox(height: 40),

            // Save Button
            Container(
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryRed.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save_outlined, size: 20),
                    label: const Text(
                      'Save Allergy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: 800.ms)
                .scale(begin: const Offset(0.9, 0.9)),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required Color surfaceColor,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
            fillColor: surfaceColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(20),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String placeholder,
    required Color surfaceColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                placeholder,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryRed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
