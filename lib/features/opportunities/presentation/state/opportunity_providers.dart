import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/data/opportunity_repository.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/founder_metrics_model.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_model.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_view_model.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/opportunity_filters.dart';

final opportunityFilterProvider =
    StateProvider<OpportunityFilterState>((ref) => const OpportunityFilterState());

final opportunityFeedProvider =
    StreamProvider.autoDispose<List<OpportunityViewModel>>((ref) {
      final filters = ref.watch(opportunityFilterProvider);
      final repository = ref.watch(opportunityRepositoryProvider);
      return repository.streamOpportunities(filters: filters);
    });

final founderOpportunitiesProvider =
    StreamProvider.autoDispose<List<OpportunityModel>>((ref) {
      final authState = ref.watch(authNotifierProvider).valueOrNull;
      if (authState is! AuthAuthenticated) {
        return const Stream<List<OpportunityModel>>.empty();
      }

      final startupId = authState.profile.startupId;
      if (startupId == null || startupId.isEmpty) {
        return const Stream<List<OpportunityModel>>.empty();
      }

      final repository = ref.watch(opportunityRepositoryProvider);
      return repository.streamStartupOpportunities(startupId: startupId);
    });

final founderMetricsProvider =
    StreamProvider.family<FounderMetricsModel, String>((ref, startupId) {
      final repository = ref.watch(opportunityRepositoryProvider);
      return repository.streamStartupMetrics(startupId: startupId);
    });

final opportunityViewTrackerProvider =
    StateNotifierProvider<OpportunityViewTrackerNotifier, Set<String>>((ref) {
      final repository = ref.watch(opportunityRepositoryProvider);
      return OpportunityViewTrackerNotifier(repository: repository);
    });

class OpportunityViewTrackerNotifier extends StateNotifier<Set<String>> {
  OpportunityViewTrackerNotifier({required OpportunityRepository repository})
      : _repository = repository,
        super(<String>{});

  final OpportunityRepository _repository;

  Future<void> trackVisible(
    List<OpportunityViewModel> opportunities, {
    required String viewerId,
  }) async {
    final viewDateKey = _buildUtcDateKey(DateTime.now().toUtc());

    for (final item in opportunities) {
      final opportunityId = item.opportunity.id;
      final memoryTrackingKey = '${opportunityId}_$viewDateKey';
      if (state.contains(memoryTrackingKey)) {
        continue;
      }
      state = {...state, memoryTrackingKey};
      await _repository.incrementOpportunityViewCount(
        startupId: item.opportunity.startupId,
        opportunityId: opportunityId,
        viewerId: viewerId,
        viewDateKey: viewDateKey,
      );
    }
  }

  String _buildUtcDateKey(DateTime utcTime) {
    final year = utcTime.year.toString().padLeft(4, '0');
    final month = utcTime.month.toString().padLeft(2, '0');
    final day = utcTime.day.toString().padLeft(2, '0');
    return '$year$month$day';
  }
}
