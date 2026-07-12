import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/data/opportunity_repository.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/application_model.dart';

/// Stream of all applications for a founder's opportunities
final founderApplicationsProvider =
    StreamProvider.family<List<ApplicationModel>, String>((ref, startupId) {
  final repository = ref.watch(opportunityRepositoryProvider);
  return repository.streamStartupApplications(startupId: startupId);
});

/// Notifier for updating application status
class ApplicationStatusUpdateNotifier extends StateNotifier<AsyncValue<void>> {
  ApplicationStatusUpdateNotifier({required this.repository})
      : super(const AsyncValue.data(null));

  final OpportunityRepository repository;

  Future<void> updateStatus({
    required String applicationId,
    required ApplicationStatus newStatus,
    String? reviewNotes,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => repository.updateApplicationStatus(
        applicationId: applicationId,
        newStatus: newStatus,
        reviewNotes: reviewNotes,
      ),
    );
  }
}

final applicationStatusUpdateProvider =
    StateNotifierProvider<ApplicationStatusUpdateNotifier, AsyncValue<void>>(
  (ref) {
    final repository = ref.watch(opportunityRepositoryProvider);
    return ApplicationStatusUpdateNotifier(repository: repository);
  },
);

/// Get current user's startup ID (for filtering founder's applications)
final founderStartupIdProvider = Provider<String?>((ref) {
  final authStateAsync = ref.watch(authNotifierProvider);

  if (authStateAsync case AsyncValue<AuthState> (:final valueOrNull) when valueOrNull is AuthAuthenticated) {
    final authState = authStateAsync.valueOrNull as AuthAuthenticated;
    return authState.profile.startupId;
  }

  return null;
});
