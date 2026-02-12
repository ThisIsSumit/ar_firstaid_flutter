import 'package:ar_firstaid_flutter/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class EthicsAgreementPage extends StatefulWidget {
  const EthicsAgreementPage({super.key});

  @override
  State<EthicsAgreementPage> createState() => _EthicsAgreementPageState();
}

class _EthicsAgreementPageState extends State<EthicsAgreementPage> {
  bool _agreedToTerms = false;
  // Track answers for each question: true = YES, false = NO, null = not answered
  final Map<int, bool> _answers = {1: false, 2: false, 3: true};

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Color(0xFF0A0A0F);
    const Color primaryRed = Color(0xFFFF3B5C);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ethics & Safety',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'STEP 3 OF 3',
                  style: TextStyle(
                    color: primaryRed,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  '66% Complete',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Background Vetting',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 6,
              width: MediaQuery.of(context).size.width * 0.66,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [primaryRed, Color(0xFFC0243F)],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 32),
            _buildEthicsQuestion(
              'Have you ever been convicted of a felony or a medical misdemeanor?',
              1,
            ),
            _buildEthicsQuestion(
              'Is your medical certification currently under investigation or suspended?',
              2,
            ),
            _buildEthicsQuestion(
              'Do you agree to a background check conducted by a third-party security firm?',
              3,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (v) =>
                        setState(() => _agreedToTerms = v ?? false),
                    activeColor: primaryRed,
                    side: const BorderSide(color: Colors.white24),
                  ),
                  const Expanded(
                    child: Text(
                      'I confirm that all provided information is accurate and I agree to the Responder Service Agreement.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _agreedToTerms
                  ? () => context.push(AppRoutes.responderSuccess)
                  : null,
              child: Opacity(
                opacity: _agreedToTerms ? 1.0 : 0.5,
                child: _buildSubmitButton(),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  Widget _buildEthicsQuestion(String question, int index) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => _answers[index] = true),
              child: _buildOptionBadge(
                'YES',
                isSelected: _answers[index] == true,
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => setState(() => _answers[index] = false),
              child: _buildOptionBadge(
                'NO',
                isSelected: _answers[index] == false,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildOptionBadge(String text, {bool isSelected = false}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    decoration: BoxDecoration(
      color: isSelected
          ? const Color(0xFFFF3B5C).withOpacity(0.1)
          : Colors.white.withOpacity(0.05),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: isSelected
            ? const Color(0xFFFF3B5C)
            : Colors.white.withOpacity(0.1),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isSelected ? const Color(0xFFFF3B5C) : Colors.white60,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),
  );

  Widget _buildSubmitButton() => Container(
    width: double.infinity,
    height: 64,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFFF3B5C), Color(0xFFC0243F)],
      ),
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Center(
      child: Text(
        'Submit Application',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
