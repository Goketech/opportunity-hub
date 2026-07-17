import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:opportunity_hub/features/auth/data/auth_repository.dart';
import 'package:opportunity_hub/features/auth/domain/models/user_profile.dart';
import 'package:opportunity_hub/features/auth/presentation/pages/login_page.dart';
import 'package:opportunity_hub/features/auth/presentation/pages/onboarding_page.dart';
import 'package:opportunity_hub/features/auth/presentation/pages/signup_page.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/presentation/pages/startup_listings_page.dart';
import 'package:opportunity_hub/features/opportunities/presentation/pages/student_opportunities_page.dart';
import 'package:opportunity_hub/features/startups/presentation/pages/startup_setup_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _RouterRefreshListenable(ref);
  ref.onDispose(refreshListenable.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final authAsync = ref.read(authNotifierProvider);

      if (authAsync.hasError) {
        final activeUser = ref.read(authRepositoryProvider).currentUser;
        if (activeUser != null && activeUser.email != null) {
          return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
        }

        if (location == AppRoutes.login || location == AppRoutes.signup) {
          return null;
        }
        return AppRoutes.login;
      }

      if (authAsync.isLoading) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      final authState = authAsync.valueOrNull;
      if (authState == null || authState is AuthLoading) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }

      if (authState is AuthUnauthenticated) {
        if (location == AppRoutes.login || location == AppRoutes.signup) {
          return null;
        }
        return AppRoutes.login;
      }

      if (authState is AuthOnboardingRequired) {
        return location == AppRoutes.onboarding ? null : AppRoutes.onboarding;
      }

      if (authState is AuthAuthenticated) {
        final needsStartupSetup = authState.profile.role == UserRole.startupFounder &&
            (authState.profile.startupId == null || authState.profile.startupId!.isEmpty);
        if (needsStartupSetup) {
          return location == AppRoutes.startupSetup
              ? null
              : AppRoutes.startupSetup;
        }

        final target = authState.profile.role == UserRole.startupFounder
            ? AppRoutes.startupHome
            : AppRoutes.studentHome;
        if (location == AppRoutes.login ||
            location == AppRoutes.signup ||
            location == AppRoutes.splash ||
            location == AppRoutes.onboarding ||
            location == AppRoutes.startupSetup) {
          return target;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const _SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: 'signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.startupSetup,
        name: 'startup-setup',
        builder: (context, state) => const StartupSetupPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _DashboardShell(
            title: 'Student Dashboard',
            navigationShell: navigationShell,
            items: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.work_outline),
                selectedIcon: Icon(Icons.work),
                label: 'Opportunities',
              ),
              NavigationDestination(
                icon: Icon(Icons.assignment_outlined),
                selectedIcon: Icon(Icons.assignment),
                label: 'Applications',
              ),
            ],
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.studentHome,
                name: 'student-home',
                builder: (context, state) => const _StudentHomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.studentOpportunities,
                name: 'student-opportunities',
                builder: (context, state) => const StudentOpportunitiesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.studentApplications,
                name: 'student-applications',
                builder: (context, state) => const _StudentApplicationsPage(),
              ),
            ],
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _DashboardShell(
            title: 'Startup Dashboard',
            navigationShell: navigationShell,
            items: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Overview',
              ),
              NavigationDestination(
                icon: Icon(Icons.campaign_outlined),
                selectedIcon: Icon(Icons.campaign),
                label: 'Listings',
              ),
              NavigationDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: 'Talent',
              ),
            ],
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.startupHome,
                name: 'startup-home',
                builder: (context, state) => const _StartupHomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.startupListings,
                name: 'startup-listings',
                builder: (context, state) => const StartupListingsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.startupTalent,
                name: 'startup-talent',
                builder: (context, state) => const _StartupTalentPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

final class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String startupSetup = '/onboarding/startup-setup';

  static const String studentHome = '/student/home';
  static const String studentOpportunities = '/student/opportunities';
  static const String studentApplications = '/student/applications';

  static const String startupHome = '/startup/home';
  static const String startupListings = '/startup/listings';
  static const String startupTalent = '/startup/talent';
}

class _DashboardShell extends StatelessWidget {
  const _DashboardShell({
    required this.title,
    required this.navigationShell,
    required this.items,
  });

  final String title;
  final StatefulNavigationShell navigationShell;
  final List<NavigationDestination> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: items,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class _StudentHomePage extends StatelessWidget {
  const _StudentHomePage();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      title: 'Student Home',
      description:
          'Track recommended startups, profile progress, and internship readiness.',
    );
  }
}

class _StudentApplicationsPage extends StatelessWidget {
  const _StudentApplicationsPage();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      title: 'Applications',
      description: 'Monitor active applications, interview stages, and decisions.',
    );
  }
}

class _StartupHomePage extends StatelessWidget {
  const _StartupHomePage();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      title: 'Startup Overview',
      description: 'Monitor talent pipeline performance and internship engagement.',
    );
  }
}

class _StartupTalentPage extends StatelessWidget {
  const _StartupTalentPage();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      title: 'Talent',
      description:
          'Review applicants, shortlist candidates, and coordinate interview workflows.',
    );
  }
}

class _SectionPage extends StatelessWidget {
  const _SectionPage({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(description, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _RouterRefreshListenable extends ChangeNotifier {
  _RouterRefreshListenable(this.ref) {
    _subscription = ref.listen<AsyncValue<AuthState>>(
      authNotifierProvider,
      (previous, next) => notifyListeners(),
      fireImmediately: true,
    );
  }

  final Ref ref;
  ProviderSubscription<AsyncValue<AuthState>>? _subscription;

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }
}
