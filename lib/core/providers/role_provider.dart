// TODO Implement this library.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum UserRole { user, responder }

final userRoleProvider = StateProvider<UserRole>((ref) => UserRole.user);

final isResponderProvider = Provider<bool>((ref) {
  return ref.watch(userRoleProvider) == UserRole.responder;
});