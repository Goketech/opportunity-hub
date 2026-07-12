import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/data/opportunity_repository.dart';
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
