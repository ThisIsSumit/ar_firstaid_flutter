// TODO Implement this library.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'user_provider.dart';

enum UserRole { user, responder }

// Derive user role from user data
final userRoleProvider = Provider<UserRole>((ref) {
  final user = ref.watch(userProvider);
  return (user?.isResponder ?? false) ? UserRole.responder : UserRole.user;
});

final isResponderProvider = Provider<bool>((ref) {
  return ref.watch(userRoleProvider) == UserRole.responder;
});
