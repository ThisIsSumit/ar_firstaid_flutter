import 'package:ar_firstaid_flutter/screens/medical_profile/edit_basic_info_page.dart';
import 'package:ar_firstaid_flutter/screens/medical_profile/medical_profile_form_page.dart';
import 'package:ar_firstaid_flutter/screens/medical_profile/medical_profile_onboarding.dart';
import 'package:ar_firstaid_flutter/screens/responder/earnings/ways_to_earn.dart';
import 'package:ar_firstaid_flutter/screens/responder/earnings/referral_program_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/earnings/my_referrals_page.dart';
import 'package:ar_firstaid_flutter/screens/user/emergency/active_emergency_status_page.dart';
import 'package:ar_firstaid_flutter/screens/user/map_location/aed_locator_screen.dart';
import 'package:ar_firstaid_flutter/screens/responder/responder%20form/application_success_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/responder%20form/become_responder_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/responder%20form/certification_upload_page.dart';
import 'package:ar_firstaid_flutter/screens/messages/chat_page.dart';
import 'package:ar_firstaid_flutter/screens/emergency_card_page.dart';
import 'package:ar_firstaid_flutter/screens/user/emergency/emergency_confirmation_page.dart';
import 'package:ar_firstaid_flutter/screens/user/emergency/emergency_tracking_page.dart';
import 'package:ar_firstaid_flutter/screens/user/emergency/emergency_type_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/responder%20form/ethics_agreement_page.dart';
import 'package:ar_firstaid_flutter/screens/user/home_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/responder%20form/identity_verification_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/notification/incoming_emergency_page.dart';
import 'package:ar_firstaid_flutter/screens/auth/login_page.dart';
import 'package:ar_firstaid_flutter/screens/auth/forgot_password.dart';
import 'package:ar_firstaid_flutter/screens/auth/reset_code_verification_page.dart';
import 'package:ar_firstaid_flutter/screens/auth/reset_password_page.dart';
import 'package:ar_firstaid_flutter/screens/medical_profile/medical_profile_page.dart';
import 'package:ar_firstaid_flutter/screens/messages/messages_inbox.dart';
import 'package:ar_firstaid_flutter/screens/auth/onboarding_page.dart';
import 'package:ar_firstaid_flutter/screens/auth/onboarding_screen.dart'
    hide OnboardingPage;
import 'package:ar_firstaid_flutter/screens/responder/profile_screen.dart';
import 'package:ar_firstaid_flutter/screens/user/emergency/rate_emergency_page.dart';
import 'package:ar_firstaid_flutter/screens/community/responder_community_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/responder_dashboard_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/reward/perks_dashboard_page.dart';
import 'package:ar_firstaid_flutter/screens/user/responder_en_route_page.dart';
import 'package:ar_firstaid_flutter/screens/responder/notification/responder_notifications_page.dart';
import 'package:ar_firstaid_flutter/screens/settings_screen.dart';
import 'package:ar_firstaid_flutter/screens/user/emergency/severity_selector_page.dart';
import 'package:ar_firstaid_flutter/screens/auth/signup_page.dart';
import 'package:ar_firstaid_flutter/screens/auth/splash_screen.dart';
import 'package:ar_firstaid_flutter/screens/responder/treatment_logging_page.dart';
import 'package:ar_firstaid_flutter/screens/user/user_profile_page.dart';
import 'package:ar_firstaid_flutter/widgets/main_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/user_provider.dart';
import '../providers/emergency_provider.dart';
import '../providers/role_provider.dart';
import '../../widgets/responder_shell.dart';

// Route Constants
class AppRoutes {
  // Auth & Onboarding
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String onboardingAlt = '/onboarding-alt';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String resetCodeVerification = '/reset-code-verification';
  static const String resetPassword = '/reset-password';

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
  static const String incomingEmergency = '/incoming-emergency';
  static const String responderNotifications = '/responder-notifications';

  // Standalone Routes
  static const String becomeResponder = '/become-responder';
  static const String certificationUploadStandalone = '/certification';
  static const String medicalProfile = '/medical-profile';
  static const String userProfile = '/user-profile';
  static const String aedLocatorStandalone = '/aed-standalone';
  static const String earnings = '/earnings';
  static const String referralProgram = '/referral-program';
  static const String myReferrals = '/my-referrals';
  static const String rewards = '/rewards';
  static const String responderCommunity = '/community';

  static const String responderIdentity = '/responder-identity';
  static const String responderEthics = '/responder-ethics';
  static const String responderSuccess = '/responder-success';
  static const String medicalOnboarding = '/medical-onboarding';
  static const String medicalProfileForm = '/medical-profile-form';

  // Main Navigation - User Role
  static const String home = '/home';
  static const String aedMap = '/aed-map';
  static const String messages = '/chat';
  static const String profile = '/profile';
  static const editBasicInfo = '/edit-basic-info';

  // Main Navigation - Responder Role
  static const String responderHome = '/responder-home';
  static const String responderMessages = '/chat';

  // Legacy (kept for compatibility)
  static const String training = '/training';
  static const String messagesLegacy = '/messages-legacy';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final userRole = ref.watch(userRoleProvider);
  final isEmergencyActive = ref.watch(
    emergencyProvider.select((state) => state.isActive),
  );

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Emergency override: force navigate to active emergency
      if (isEmergencyActive &&
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
            state.matchedLocation == AppRoutes.splash ||
            state.matchedLocation == AppRoutes.forgotPassword ||
            state.matchedLocation == AppRoutes.resetCodeVerification ||
            state.matchedLocation == AppRoutes.resetPassword;

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
              onPressed: () => (userRole == UserRole.responder)
                  ? context.go(AppRoutes.responderHome)
                  : context.go(AppRoutes.home),
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
      builder: (context, state) => OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.onboardingAlt,
      builder: (context, state) => OnboardingScreen(),
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
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.resetCodeVerification,
      builder: (context, state) {
        final email = state.extra as String? ?? '';
        return ResetCodeVerificationPage(email: email);
      },
    ),
    GoRoute(
      path: AppRoutes.resetPassword,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>? ?? {};
        return ResetPasswordPage(
          email: extras['email'] ?? '',
          code: extras['code'] ?? '',
        );
      },
    ),

    // Emergency Flow Routes (Full Screen)
    GoRoute(
      path: AppRoutes.emergencySelector,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const EmergencyTypePage(),
    ),
    GoRoute(
      path: AppRoutes.severitySelector,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SeveritySelectorPage(),
    ),
    GoRoute(
      path: AppRoutes.emergencyConfirmation,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const EmergencyConfirmationPage(),
    ),
    GoRoute(
      path: AppRoutes.activeEmergency,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ActiveEmergencyStatusPage(),
    ),
    GoRoute(
      path: AppRoutes.emergencyTracking,
      parentNavigatorKey: _rootNavigatorKey,
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
    GoRoute(
      path: AppRoutes.incomingEmergency,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const IncomingEmergencyPage(),
    ),
    GoRoute(
      path: AppRoutes.responderNotifications,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ResponderNotificationsPage(),
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
      path: AppRoutes.responderIdentity,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const IdentityVerificationPage(),
    ),
    GoRoute(
      path: AppRoutes.responderEthics,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const EthicsAgreementPage(),
    ),
    GoRoute(
      path: AppRoutes.responderSuccess,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ApplicationSuccessPage(),
    ),
    GoRoute(
      path: AppRoutes.medicalProfile,
      builder: (context, state) => const MedicalProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.referralProgram,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ReferralProgramPage(),
    ),
    GoRoute(
      path: AppRoutes.myReferrals,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MyReferralsPage(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.editBasicInfo,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const EditBasicInfoPage(),
    ),
    GoRoute(
      path: AppRoutes.medicalOnboarding,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MedicalInfoOnboarding(),
    ),
    GoRoute(
      path: AppRoutes.medicalProfileForm,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const MedicalProfileFormPage(),
    ),
    GoRoute(
      path: AppRoutes.userProfile,
      builder: (context, state) => const UserProfilePage(),
      routes: [
        GoRoute(
          path: 'settings',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: 'medical',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const MedicalProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/chat/:chatId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final chatId = state.pathParameters['chatId'] ?? '';
        final name = state.uri.queryParameters['name'] ?? 'Chat';
        final avatar = state.uri.queryParameters['avatar'] ?? '';

        return ChatPage(
          chatId: chatId,
          peerName: name,
          peerAvatar: avatar.isNotEmpty
              ? avatar
              : 'https://i.pravatar.cc/150?u=$name',
        );
      },
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
                routes: [],
              ),
            ],
          ),
          // Profile Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.responderCommunity,

                builder: (context, state) => const ResponderCommunityPage(),
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
                  GoRoute(
                    path: AppRoutes.responderNotifications,
                    builder: (context, state) =>
                        const ResponderNotificationsPage(),
                  ),
                ],
              ),
            ],
          ),
          // Community Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.responderCommunity,

                builder: (context, state) => const ResponderCommunityPage(),
              ),
            ],
          ),
          // Messages Branch (Responder)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.responderMessages,
                builder: (context, state) => const MessagesInbox(),
              ),
            ],
          ),
          // Rewards Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.rewards,
                builder: (context, state) => const PerksDashboardPage(),
              ),
            ],
          ),
          // Earnings Branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.earnings,
                builder: (context, state) => const WaysToEarnScreen(),
              ),
            ],
          ),
        ],
      ),
  ];
}
