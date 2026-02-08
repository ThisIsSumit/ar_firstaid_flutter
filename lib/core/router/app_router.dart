import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/splash_page.dart';
import '../../features/home/home_page.dart';
import '../../features/training/presentation/pages/training_page.dart';
import '../../features/training/presentation/pages/module_detail_page.dart';
import '../../features/ar/presentation/pages/ar_training_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/stats_page.dart';
import '../../features/emergency/presentation/pages/emergency_alert_page.dart';
import '../../features/mian_navigation.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // Auth
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),

      // Main Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigation(child: child);
        },
        routes: [
          // Home
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: const HomePage()),
          ),

          // Training
          GoRoute(
            path: '/training',
            name: 'training',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const TrainingPage(),
            ),
          ),

          // Chat
          GoRoute(
            path: '/chat',
            name: 'chat',
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: const ChatPage()),
          ),

          // Profile
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfilePage(),
            ),
          ),
        ],
      ),

      // Module Detail
      GoRoute(
        path: '/module/:id',
        name: 'module-detail',
        pageBuilder: (context, state) {
          final moduleId = state.pathParameters['id']!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: ModuleDetailPage(moduleId: moduleId),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOutCubic;
                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          );
        },
      ),

      // // AR Training
      // GoRoute(
      //   path: '/ar-training/:moduleId',
      //   name: 'ar-training',
      //   pageBuilder: (context, state) {
      //     final moduleId = state.pathParameters['moduleId'] ?? 'cpr';
      //     return CustomTransitionPage(
      //       key: state.pageKey,
      //       child: ARTrainingPage(moduleId: moduleId),
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //             return FadeTransition(
      //               opacity: animation,
      //               child: ScaleTransition(
      //                 scale: Tween<double>(begin: 0.95, end: 1.0).animate(
      //                   CurvedAnimation(
      //                     parent: animation,
      //                     curve: Curves.easeInOutCubic,
      //                   ),
      //                 ),
      //                 child: child,
      //               ),
      //             );
      //           },
      //     );
      //   },
      // ),

      // Stats
      GoRoute(
        path: '/stats',
        name: 'stats',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StatsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),

      // Emergency Alert
      GoRoute(
        path: '/emergency',
        name: 'emergency',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const EmergencyAlertPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      ),
    ],
  );
});
