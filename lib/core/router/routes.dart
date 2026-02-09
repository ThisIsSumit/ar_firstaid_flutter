import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/main_shell.dart';
import '../providers/user_provider.dart';
import 'app_router.dart';

import '../../screens/active_emergency_status_page.dart';
import '../../screens/aed_locator_screen.dart';
import '../../screens/become_responder_page.dart';
import '../../screens/certification_upload_page.dart';
import '../../screens/chat_page.dart';
import '../../screens/emergency_card_page.dart';
import '../../screens/emergency_tracking_page.dart';
import '../../screens/emergency_type_page.dart';
import '../../screens/home_page.dart';
import '../../screens/login_page.dart';
import '../../screens/medical_profile_page.dart';
import '../../screens/messages_inbox.dart';
import '../../screens/messages_page.dart';
import '../../screens/onboarding_page.dart';
import '../../screens/onboarding_screen.dart' hide OnboardingPage;
import '../../screens/profile_screen.dart';
import '../../screens/rate_emergency_page.dart';
import '../../screens/responder_dashboard_page.dart';
import '../../screens/responder_en_route_page.dart';
import '../../screens/settings_screen.dart';
import '../../screens/signup_page.dart';
import '../../screens/splash_screen.dart';
import '../../screens/treatment_logging_page.dart';
import '../../screens/user_profile_page.dart';
import '../../screens/severity_selector_page.dart';
import '../../screens/emergency_confirmation_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final isResponder = ref.watch(isResponderProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isRegistering = state.matchedLocation == AppRoutes.signup;
      final isOnboarding = state.matchedLocation == AppRoutes.onboarding;
      final isOnboardingAlt = state.matchedLocation == AppRoutes.onboardingAlt;
      final isSplash = state.matchedLocation == AppRoutes.splash;
      final isAuthRoute =
          isLoggingIn ||
          isRegistering ||
          isOnboarding ||
          isOnboardingAlt ||
          isSplash;

      // if (!isLoggedIn) {
      //   return isAuthRoute ? null : AppRoutes.onboarding;
      // }

      if (isLoggedIn && isAuthRoute) {
        return isResponder ? AppRoutes.responderDashboard : AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingAlt,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
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
      GoRoute(
        path: AppRoutes.emergencyCard,
        builder: (context, state) => const EmergencyCardPage(),
      ),
      GoRoute(
        path: AppRoutes.medicalProfile,
        builder: (context, state) => const MedicalProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.aedLocator,
        builder: (context, state) => const AEDLocatorScreen(),
      ),
      GoRoute(
        path: AppRoutes.becomeResponder,
        builder: (context, state) => const BecomeResponderPage(),
      ),
      GoRoute(
        path: AppRoutes.certificationUpload,
        builder: (context, state) => const CertificationUploadPage(),
      ),
      GoRoute(
        path: AppRoutes.responderDashboard,
        builder: (context, state) => const ResponderDashboardPage(),
      ),
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
      GoRoute(
        path: AppRoutes.userProfile,
        builder: (context, state) => const UserProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.messagesLegacy,
        builder: (context, state) => const MessagesPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeDashboard(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.training,
                builder: (context, state) => const CertificationUploadPage(),
              ),
            ],
          ),
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
    ],
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
