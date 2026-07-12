import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/data/opportunity_repository.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/application_model.dart';

final studentApplicationsProvider = StreamProvider.family<List<ApplicationModel>, String>((ref, studentId) {
  final repository = ref.watch(opportunityRepositoryProvider);
  return repository.streamStudentApplications(studentId: studentId);
});

final opportunityApplicationsProvider = StreamProvider.family<List<ApplicationModel>, String>((ref, opportunityId) {
  final repository = ref.watch(opportunityRepositoryProvider);
  return repository.streamOpportunityApplications(opportunityId: opportunityId);
});

final checkApplicationStatusProvider = FutureProvider.family<ApplicationModel?, String>((ref, opportunityId) async {
  final authState = ref.watch(authNotifierProvider).valueOrNull;
  
  if (authState is! AuthAuthenticated) {
    return null;
  }
  
  final repository = ref.watch(opportunityRepositoryProvider);
  return repository.getStudentApplicationForOpportunity(
    studentId: authState.profile.id,
    opportunityId: opportunityId,
  );
});

final applicationSubmissionProvider = StateNotifierProvider<ApplicationSubmissionNotifier, ApplicationSubmissionState>((ref) {
  final repository = ref.watch(opportunityRepositoryProvider);
  return ApplicationSubmissionNotifier(repository);
});

class ApplicationSubmissionState {
  final bool isLoading;
  final String? errorMessage;
  final bool success;

  ApplicationSubmissionState({
    this.isLoading = false,
    this.errorMessage,
    this.success = false,
  });

  ApplicationSubmissionState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? success,
  }) {
    return ApplicationSubmissionState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
    );
  }

  void reset() {
    // Only used for signaling, doesn't modify this instance
  }
}

class ApplicationSubmissionNotifier extends StateNotifier<ApplicationSubmissionState> {
  ApplicationSubmissionNotifier(OpportunityRepository repository)
      : _repository = repository,
        super(ApplicationSubmissionState());

  final OpportunityRepository _repository;

  Future<bool> submitApplication({
    required String opportunityId,
    required String studentId,
    required String startupId,
    required Map<String, String> answers,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _repository.submitApplication(
        opportunityId: opportunityId,
        studentId: studentId,
        startupId: startupId,
        answers: answers,
      );

      state = state.copyWith(isLoading: false, success: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        success: false,
      );
      return false;
    }
  }

  void clearState() {
    state = ApplicationSubmissionState();
  }
}
