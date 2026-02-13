
import 'package:flutter_riverpod/legacy.dart';

class PasswordResetState {
  final String? email;
  final bool isLoading;
  final String? error;
  final bool codeSent;
  final int? codeExpiresIn;

  PasswordResetState({
    this.email,
    this.isLoading = false,
    this.error,
    this.codeSent = false,
    this.codeExpiresIn,
  });

  PasswordResetState copyWith({
    String? email,
    bool? isLoading,
    String? error,
    bool? codeSent,
    int? codeExpiresIn,
  }) {
    return PasswordResetState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      codeSent: codeSent ?? this.codeSent,
      codeExpiresIn: codeExpiresIn ?? this.codeExpiresIn,
    );
  }
}

class PasswordResetNotifier extends StateNotifier<PasswordResetState> {
  PasswordResetNotifier() : super(PasswordResetState());

  /// Send reset code to email
  Future<bool> sendResetCode(String email) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      // Simulated success
      state = state.copyWith(
        email: email,
        isLoading: false,
        codeSent: true,
        codeExpiresIn: 600, // 10 minutes
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to send reset code. Please try again.',
      );
      return false;
    }
  }

  /// Verify reset code
  Future<bool> verifyResetCode(String code) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      // Simple validation - in production, verify with backend
      if (code.length == 6 && code.contains(RegExp(r'[0-9]'))) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid reset code. Please check and try again.',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to verify code. Please try again.',
      );
      return false;
    }
  }

  /// Reset password with new password
  Future<bool> resetPassword(String newPassword, String confirmPassword) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      if (newPassword != confirmPassword) {
        state = state.copyWith(
          isLoading: false,
          error: 'Passwords do not match.',
        );
        return false;
      }

      if (newPassword.length < 8) {
        state = state.copyWith(
          isLoading: false,
          error: 'Password must be at least 8 characters long.',
        );
        return false;
      }

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1500));

      // Reset state on success
      state = PasswordResetState();
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to reset password. Please try again.',
      );
      return false;
    }
  }

  /// Resend reset code
  Future<bool> resendResetCode() async {
    if (state.email == null) {
      state = state.copyWith(error: 'Email not found');
      return false;
    }

    return sendResetCode(state.email!);
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Reset state
  void reset() {
    state = PasswordResetState();
  }
}

final passwordResetProvider =
    StateNotifierProvider<PasswordResetNotifier, PasswordResetState>(
      (ref) => PasswordResetNotifier(),
    );
