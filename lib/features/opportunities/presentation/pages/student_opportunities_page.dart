import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/opportunity_filters.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/opportunity_providers.dart';
import 'package:opportunity_hub/features/opportunities/presentation/widgets/opportunity_card.dart';

class StudentOpportunitiesPage extends ConsumerStatefulWidget {
  const StudentOpportunitiesPage({super.key});

  @override
  ConsumerState<StudentOpportunitiesPage> createState() =>
      _StudentOpportunitiesPageState();
}

class _StudentOpportunitiesPageState
    extends ConsumerState<StudentOpportunitiesPage> {
  late final TextEditingController _searchController;

  static const _categories = <String>[
    'Software Engineering',
    'Data Science',
    'Product Management',
    'Design',
    'Marketing',
    'Operations',
    'Finance',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final filter = ref.read(opportunityFilterProvider);
    _searchController = TextEditingController(text: filter.searchTerm);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(opportunityFeedProvider);
    final filters = ref.watch(opportunityFilterProvider);
    final authState = ref.watch(authNotifierProvider).valueOrNull;
    final viewerId = authState is AuthAuthenticated ? authState.profile.id : null;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search roles, startups, and keywords',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {
                    _searchController.clear();
                    ref.read(opportunityFilterProvider.notifier).state =
                        filters.copyWith(searchTerm: '');
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              onChanged: (value) {
                ref.read(opportunityFilterProvider.notifier).state =
                    filters.copyWith(searchTerm: value);
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                DropdownButton<String?>(
                  value: filters.category,
                  hint: const Text('Category'),
                  onChanged: (value) {
                    if (value == null) {
                      ref.read(opportunityFilterProvider.notifier).state =
                          filters.copyWith(clearCategory: true);
                      return;
                    }
                    ref.read(opportunityFilterProvider.notifier).state =
                        filters.copyWith(category: value);
                  },
                  items: <DropdownMenuItem<String?>>[
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('All Categories'),
                    ),
                    ..._categories.map(
                      (category) => DropdownMenuItem<String?>(
                        value: category,
                        child: Text(category),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                SegmentedButton<StartupVerificationFilter>(
                  segments: const [
                    ButtonSegment(
                      value: StartupVerificationFilter.all,
                      label: Text('All'),
                    ),
                    ButtonSegment(
                      value: StartupVerificationFilter.aluVerifiedOnly,
                      label: Text('ALU Verified'),
                    ),
                    ButtonSegment(
                      value: StartupVerificationFilter.notVerified,
                      label: Text('Others'),
                    ),
                  ],
                  selected: {filters.verificationFilter},
                  onSelectionChanged: (selection) {
                    final selected = selection.first;
                    ref.read(opportunityFilterProvider.notifier).state =
                        filters.copyWith(verificationFilter: selected);
                  },
                ),
                const SizedBox(width: 12),
                FilledButton.tonalIcon(
                  onPressed: () => _openSkillFilterSheet(context, filters),
                  icon: const Icon(Icons.tune),
                  label: Text(
                    filters.requiredSkills.isEmpty
                        ? 'Skills'
                        : 'Skills (${filters.requiredSkills.length})',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: feedAsync.when(
              data: (items) {
                if (viewerId != null) {
                  // Track one impression per opportunity per user per day.
                  // ignore: discarded_futures
                  ref
                      .read(opportunityViewTrackerProvider.notifier)
                      .trackVisible(items, viewerId: viewerId);
                }

                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No opportunities match your current filters.',
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return OpportunityCard(opportunity: items[index]);
                  },
                );
              },
              error: (error, _) {
                return Center(
                  child: Text('Failed to load opportunities: $error'),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openSkillFilterSheet(
    BuildContext context,
    OpportunityFilterState filters,
  ) async {
    final skillController = TextEditingController();
    final selectedSkills = [...filters.requiredSkills];

    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            void addSkill() {
              final raw = skillController.text.trim();
              if (raw.isEmpty) {
                return;
              }

              final normalized = raw.toLowerCase();
              if (!selectedSkills.contains(normalized)) {
                setSheetState(() => selectedSkills.add(normalized));
              }
              skillController.clear();
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter by required skills',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: skillController,
                          decoration: const InputDecoration(
                            hintText: 'e.g. flutter, ui/ux',
                          ),
                          onSubmitted: (_) => addSkill(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: addSkill,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedSkills
                        .map(
                          (skill) => InputChip(
                            label: Text(skill),
                            onDeleted: () {
                              setSheetState(() => selectedSkills.remove(skill));
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(const <String>[]),
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () =>
                              Navigator.of(context).pop(selectedSkills),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    skillController.dispose();

    if (!mounted || result == null) {
      return;
    }

    ref.read(opportunityFilterProvider.notifier).state =
        filters.copyWith(requiredSkills: result);
  }
}
