import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/providers/user_provider.dart';
import '../core/router/app_router.dart';
import '../core/utils/validators.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms to continue.')),
      );
      return;
    }

    ref
        .read(userProvider.notifier)
        .register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim(),
        );
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0E0E),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Join LifeLens',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),
                const SizedBox(height: 8),
                Text(
                  'Your emergency response network starts\nhere.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                    height: 1.4,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
                const SizedBox(height: 40),

                _buildInputLabel('Full Name'),
                _buildTextField(
                  hint: 'Enter your full name',
                  icon: Icons.person_outline_rounded,
                  controller: _nameController,
                  validator: Validators.validateName,
                ),

                const SizedBox(height: 24),
                _buildInputLabel('Email Address'),
                _buildTextField(
                  hint: 'name@example.com',
                  icon: Icons.mail_outline_rounded,
                  controller: _emailController,
                  validator: Validators.validateEmail,
                ),

                const SizedBox(height: 24),
                _buildInputLabel('Phone Number'),
                _buildPhoneField(),

                const SizedBox(height: 24),
                _buildInputLabel('Password'),
                _buildTextField(
                  hint: '••••••••',
                  icon: Icons.lock_outline_rounded,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onToggleVisibility: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  controller: _passwordController,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 12),
                _buildPasswordStrengthIndicator(),

                const SizedBox(height: 24),
                _buildInputLabel('Confirm Password'),
                _buildTextField(
                  hint: '••••••••',
                  icon: Icons.history_rounded,
                  isPassword: true,
                  obscureText: true,
                  controller: _confirmController,
                  validator: (value) => Validators.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),

                const SizedBox(height: 30),
                _buildTermsCheckbox(),

                const SizedBox(height: 40),
                _buildSignUpButton(),

                const SizedBox(height: 24),
                _buildLoginFooter(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => context.pop(),
      ),
      centerTitle: true,
      title: const Text(
        'Create Account',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1919),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.4),
            size: 22,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.white.withOpacity(0.4),
                    size: 22,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
  }

  Widget _buildPhoneField() {
    return Row(
      children: [
        Container(
          width: 70,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1919),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: const Center(
            child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1919),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                hintText: '(555) 000-0000',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildPasswordStrengthIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(right: index == 3 ? 0 : 8),
                decoration: BoxDecoration(
                  color: index < 2 ? const Color(0xFFFF3B5C) : Colors.white10,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        const Text(
          'Moderate Strength',
          style: TextStyle(
            color: Color(0xFFFF3B5C),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _agreedToTerms
                  ? const Color(0xFFFF3B5C)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: _agreedToTerms
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 13,
                height: 1.4,
              ),
              children: const [
                TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: Color(0xFFFF3B5C),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xFFFF3B5C),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
          onTap: _handleSignUp,
          child: Container(
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B5C),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF3B5C).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        )
        .animate()
        .shimmer(delay: 1.seconds, duration: 2.seconds)
        .scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildLoginFooter() {
    return Center(
      child: TextButton(
        onPressed: () => context.go(AppRoutes.login),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
            children: const [
              TextSpan(text: 'Already have an account? '),
              TextSpan(
                text: 'Log In',
                style: TextStyle(
                  color: Color(0xFFFF3B5C),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 800.ms);
  }
}
