import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/office/screens/office_detail_screen.dart';
import '../../features/registration/screens/pre_registration_screen.dart';
import '../../features/registration/screens/my_registrations_screen.dart';
import '../../features/voice/screens/voice_input_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
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
  ],
);

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
        ],
      ),
    );
  }
}
