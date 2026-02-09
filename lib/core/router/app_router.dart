import 'package:ar_firstaid_flutter/screens/active_emergency_status_page.dart';
import 'package:ar_firstaid_flutter/screens/aed_locator_screen.dart';
import 'package:ar_firstaid_flutter/screens/become_responder_page.dart';
import 'package:ar_firstaid_flutter/screens/certification_upload_page.dart';
import 'package:ar_firstaid_flutter/screens/chat_page.dart';
import 'package:ar_firstaid_flutter/screens/emergency_card_page.dart';
import 'package:ar_firstaid_flutter/screens/emergency_confirmation_page.dart';
import 'package:ar_firstaid_flutter/screens/emergency_tracking_page.dart';
import 'package:ar_firstaid_flutter/screens/emergency_type_page.dart';
import 'package:ar_firstaid_flutter/screens/home_page.dart';
import 'package:ar_firstaid_flutter/screens/login_page.dart';
import 'package:ar_firstaid_flutter/screens/medical_profile_page.dart';
import 'package:ar_firstaid_flutter/screens/messages_inbox.dart';
import 'package:ar_firstaid_flutter/screens/onboarding_screen.dart';
import 'package:ar_firstaid_flutter/screens/profile_screen.dart';
import 'package:ar_firstaid_flutter/screens/rate_emergency_page.dart';
import 'package:ar_firstaid_flutter/screens/responder_dashboard_page.dart';
import 'package:ar_firstaid_flutter/screens/responder_en_route_page.dart';
import 'package:ar_firstaid_flutter/screens/settings_screen.dart';
import 'package:ar_firstaid_flutter/screens/severity_selector_page.dart';
import 'package:ar_firstaid_flutter/screens/signup_page.dart';
import 'package:ar_firstaid_flutter/screens/splash_screen.dart';
import 'package:ar_firstaid_flutter/screens/treatment_logging_page.dart';
import 'package:ar_firstaid_flutter/screens/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/user_provider.dart';
import '../providers/emergency_provider.dart';
import '../providers/role_provider.dart';
import '../../widgets/main_shell.dart';
import '../../widgets/responder_shell.dart';

// Route Constants
class AppRoutes {
  // Auth & Onboarding
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String onboardingAlt = '/onboarding-alt';
  static const String login = '/login';
  static const String signup = '/signup';

  // Emergency Flow
  static const String emergencySelector = '/emergency-selector';
  static const String severitySelector = '/severity-selector';
  static const String emergencyConfirmation = '/emergency-confirmation';
  static const String activeEmergency = '/active-emergency';
  static const String emergencyTracking = '/emergency-tracking';
  static const String emergencyCard = '/emergency-card';

  // Responder Emergency Flow
  static const String responderFlow = '/responder-flow';
  static const String responderEnRoute = '/responder-en-route';
  static const String treatmentLogging = '/treatment-logging';
  static const String rateEmergency = '/rate-emergency';

  // Standalone Routes
  static const String becomeResponder = '/become-responder';
  static const String certificationUploadStandalone = '/certification';
  static const String medicalProfile = '/medical-profile';
  static const String userProfile = '/user-profile';
  static const String aedLocatorStandalone = '/aed-standalone';

  // Main Navigation - User Role
  static const String home = '/home';
  static const String aedMap = '/aed-map';
  static const String messages = '/chat';
  static const String profile = '/profile';

  // Main Navigation - Responder Role
  static const String responderHome = '/responder-home';

  // Legacy (kept for compatibility)
  static const String training = '/training';
  static const String messagesLegacy = '/messages-legacy';
}

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final userRole = ref.watch(userRoleProvider);
  final emergencyState = ref.watch(emergencyProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Emergency override: force navigate to active emergency
      if (emergencyState.isActive &&
          state.matchedLocation != AppRoutes.activeEmergency &&
          state.matchedLocation != AppRoutes.emergencyTracking &&
          !state.matchedLocation.startsWith(AppRoutes.responderFlow)) {
        return AppRoutes.activeEmergency;
      }

      // Auth wall
      if (!isLoggedIn) {
        final isAuthRoute =
            state.matchedLocation == AppRoutes.login ||
            state.matchedLocation == AppRoutes.signup ||
            state.matchedLocation == AppRoutes.onboarding ||
            state.matchedLocation == AppRoutes.onboardingAlt ||
            state.matchedLocation == AppRoutes.splash;

        return isAuthRoute ? null : AppRoutes.splash;
      }

      // Redirect authenticated users away from auth routes
      if (isLoggedIn && state.matchedLocation == AppRoutes.splash) {
        return userRole == UserRole.responder
            ? AppRoutes.responderHome
            : AppRoutes.home;
      }

      return null;
    },
    routes: _buildRoutes(userRole),
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Color(0xFFFF2D55)),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.matchedLocation}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

List<RouteBase> _buildRoutes(UserRole userRole) {
  return [
    // Auth & Onboarding Routes (Full Screen)
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),

    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignupPage(),
    ),

    // Emergency Flow Routes (Full Screen)
    GoRoute(
      path: AppRoutes.responderHome,
      builder: (context, state) => const ResponderDashboardPage(),
    ),
    GoRoute(
      path: AppRoutes.emergencySelector,
      builder: (context, state) => const EmergencyTypePage(),
    ),
    GoRoute(
      path: AppRoutes.severitySelector,
      builder: (context, state) => const SeveritySelectorPage(),
    ),
    GoRoute(
      path: AppRoutes.emergencyConfirmation,
      builder: (context, state) => const EmergencyConfirmationPage(),
    ),
    GoRoute(
      path: AppRoutes.activeEmergency,
      builder: (context, state) => const ActiveEmergencyStatusPage(),
    ),
    GoRoute(
      path: AppRoutes.emergencyTracking,
      builder: (context, state) => const EmergencyTrackingPage(),
    ),

    // Responder Emergency Flow (Full Screen)
    GoRoute(
      path: AppRoutes.responderEnRoute,
      builder: (context, state) => const ResponderEnRoutePage(),
    ),
    GoRoute(
      path: AppRoutes.treatmentLogging,
      builder: (context, state) => const TreatmentLoggingPage(),
    ),
    GoRoute(
      path: AppRoutes.rateEmergency,
      builder: (context, state) => const RateEmergencyPage(),
    ),

    // Other Full Screen Routes
    GoRoute(
      path: AppRoutes.emergencyCard,
      builder: (context, state) => const EmergencyCardPage(),
    ),
    GoRoute(
      path: AppRoutes.aedLocatorStandalone,
      builder: (context, state) => const AEDLocatorScreen(),
    ),
    GoRoute(
      path: AppRoutes.becomeResponder,
      builder: (context, state) => const BecomeResponderPage(),
    ),
    GoRoute(
      path: AppRoutes.certificationUploadStandalone,
      builder: (context, state) => const CertificationUploadPage(),
    ),
    GoRoute(
      path: AppRoutes.medicalProfile,
      builder: (context, state) => const MedicalProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.userProfile,
      builder: (context, state) => const UserProfilePage(),
    ),

    // Main Shell Routes (User Role)
    if (userRole == UserRole.user)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeDashboard(),
              ),
            ],
          ),
          // AED Locator Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.aedMap,
                builder: (context, state) => const AEDLocatorScreen(),
              ),
            ],
          ),
          // Messages Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.messages,
                builder: (context, state) => const MessagesInbox(),
                routes: [
                  GoRoute(
                    path: ':chatId',
                    builder: (context, state) {
                      final name = state.uri.queryParameters['name'] ?? 'Chat';
                      return ChatPage(peerName: name);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const SettingsScreen(),
                  ),
                  GoRoute(
                    path: 'medical',
                    builder: (context, state) => const MedicalProfilePage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    else
      // Responder Shell Routes (Responder Role)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ResponderShell(navigationShell: navigationShell);
        },
        branches: [
          // Responder Home Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.responderHome,
                builder: (context, state) => const ResponderDashboardPage(),
                routes: [
                  GoRoute(
                    path: 'history',
                    builder: (context, state) => const TreatmentLoggingPage(),
                  ),
                ],
              ),
            ],
          ),
          // AED Locator Branch (Shared)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.aedMap,
                builder: (context, state) => const AEDLocatorScreen(),
              ),
            ],
          ),
          // Messages Branch (Shared)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.messages,
                builder: (context, state) => const MessagesInbox(),
                routes: [
                  GoRoute(
                    path: ':chatId',
                    builder: (context, state) {
                      final name = state.uri.queryParameters['name'] ?? 'Chat';
                      return ChatPage(peerName: name);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Profile Branch (Shared)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const SettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
  ];
}
