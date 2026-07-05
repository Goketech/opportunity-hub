import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const _LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const _OnboardingPage(),
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
                builder: (context, state) => const _StudentOpportunitiesPage(),
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
                builder: (context, state) => const _StartupListingsPage(),
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
  static const String login = '/login';
  static const String onboarding = '/onboarding';

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

class _LoginPage extends StatelessWidget {
  const _LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Sign in to continue to Opportunity Hub.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go(AppRoutes.onboarding),
            child: const Text('Continue to Onboarding'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => context.go(AppRoutes.studentHome),
            child: const Text('Open Student Dashboard'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => context.go(AppRoutes.startupHome),
            child: const Text('Open Startup Dashboard'),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Choose the role profile to personalize your experience.',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.go(AppRoutes.studentHome),
            child: const Text('I am a Student'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.go(AppRoutes.startupHome),
            child: const Text('I represent a Startup'),
          ),
        ],
      ),
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

class _StudentOpportunitiesPage extends StatelessWidget {
  const _StudentOpportunitiesPage();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      title: 'Opportunities',
      description:
          'Explore internships from verified student-led startups across the ALU ecosystem.',
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

class _StartupListingsPage extends StatelessWidget {
  const _StartupListingsPage();

  @override
  Widget build(BuildContext context) {
    return const _SectionPage(
      title: 'Listings',
      description: 'Publish and manage internship opportunities visible to ALU students.',
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
