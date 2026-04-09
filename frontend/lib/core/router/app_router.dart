import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/profile_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/office/screens/office_detail_screen.dart';
import '../../features/registration/screens/pre_registration_screen.dart';
import '../../features/registration/screens/my_registrations_screen.dart';
import '../../features/voice/screens/voice_input_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = ref.read(isLoggedInProvider);
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      // Protected routes require authentication
      final protectedRoutes = ['/my-registrations', '/pre-register'];
      if (!isLoggedIn &&
          protectedRoutes
              .any((r) => state.matchedLocation.startsWith(r))) {
        return '/login';
      }

      // Already logged in users skip auth screens
      if (isLoggedIn && isAuthRoute) return '/';

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/my-registrations',
                builder: (context, state) => const MyRegistrationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/offices/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id'] ?? '0');
          return OfficeDetailScreen(officeId: id);
        },
      ),
      GoRoute(
        path: '/pre-register',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final officeId =
              int.tryParse(state.uri.queryParameters['officeId'] ?? '');
          return PreRegistrationScreen(officeId: officeId);
        },
      ),
      GoRoute(
        path: '/voice-input',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const VoiceInputScreen(),
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SignupScreen(),
      ),
    ],
  );
});

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
            label: '내 신청',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
