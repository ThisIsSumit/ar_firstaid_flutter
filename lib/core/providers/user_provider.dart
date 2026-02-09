import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class User {
  final String id;
  final String email;
  final String name;
  final bool isResponder;
  final bool isOnDuty;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.isResponder = false,
    this.isOnDuty = false,
  });

  User copyWith({String? name, bool? isOnDuty}) {
    return User(
      id: id,
      email: email,
      name: name ?? this.name,
      isResponder: isResponder,
      isOnDuty: isOnDuty ?? this.isOnDuty,
    );
  }
}

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void login(String email, String password) {
    state = User(id: '1', email: email, name: 'John Doe');
  }

  void loginAsResponder(String email, String password) {
    state = User(
      id: '2',
      email: email,
      name: 'Dr. Sarah',
      isResponder: true,
      isOnDuty: true,
    );
  }

  void register({
    required String email,
    required String password,
    required String name,
  }) {
    state = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
    );
  }

  void toggleOnDuty() {
    if (state != null && state!.isResponder) {
      state = state!.copyWith(isOnDuty: !state!.isOnDuty);
    }
  }

  void logout() => state = null;
}

final userProvider = StateNotifierProvider<UserNotifier, User?>(
  (ref) => UserNotifier(),
);
final isLoggedInProvider = Provider<bool>(
  (ref) => ref.watch(userProvider) != null,
);
final isResponderProvider = Provider<bool>(
  (ref) => ref.watch(userProvider)?.isResponder ?? false,
);
