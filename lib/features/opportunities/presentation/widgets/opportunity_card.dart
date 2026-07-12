import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/application_model.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_model.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_view_model.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/application_providers.dart';
import 'package:opportunity_hub/features/opportunities/presentation/widgets/application_submission_sheet.dart';

class OpportunityCard extends ConsumerWidget {
  const OpportunityCard({
    super.key,
    required this.opportunity,
  });

  final OpportunityViewModel opportunity;

  String _compensationLabel(CompensationType type) {
    return switch (type) {
      CompensationType.paid => 'Paid',
      CompensationType.stipend => 'Stipend',
      CompensationType.unpaid => 'Unpaid',
      CompensationType.equity => 'Equity',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationStatus = ref.watch(checkApplicationStatusProvider(opportunity.opportunity.id));
    final authState = ref.watch(authNotifierProvider).valueOrNull;
    final theme = Theme.of(context);
    final studentSkills = authState is AuthAuthenticated
        ? authState.profile.skills
        : const <String>[];
    final matrix = _buildSkillMatrix(
      opportunitySkills: opportunity.opportunity.requirements,
      studentSkills: studentSkills,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        opportunity.opportunity.title,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        opportunity.startupName,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (opportunity.isStartupAluVerified)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Text(
                      'ALU Verified',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.green.shade900,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(opportunity.opportunity.description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MetaChip(label: opportunity.opportunity.category),
                _MetaChip(label: opportunity.opportunity.duration),
                _MetaChip(
                  label:
                      '${_compensationLabel(opportunity.opportunity.compensationType)} role',
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (opportunity.opportunity.requirements.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${matrix.matchPercentage}% Skill Match',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: opportunity.opportunity.requirements.map((item) {
                      final normalized = item.trim().toLowerCase();
                      final isMatched = matrix.matchedSkills.contains(normalized);
                      return Chip(
                        label: Text(item),
                        backgroundColor: isMatched
                            ? Colors.green.shade50
                            : Colors.grey.shade200,
                        side: BorderSide(
                          color: isMatched
                              ? Colors.green.shade300
                              : Colors.grey.shade400,
                        ),
                        labelStyle: theme.textTheme.bodySmall?.copyWith(
                          color: isMatched
                              ? Colors.green.shade900
                              : Colors.grey.shade800,
                          fontWeight: isMatched
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: applicationStatus.when(
                data: (existingApplication) {
                  if (existingApplication != null) {
                    final statusText = switch (existingApplication.status) {
                      ApplicationStatus.submitted => 'Application Pending Review',
                      ApplicationStatus.reviewed => 'Application Under Review',
                      ApplicationStatus.accepted => 'Application Accepted',
                      ApplicationStatus.rejected => 'Application Rejected',
                      ApplicationStatus.withdrawn => 'Application Withdrawn',
                    };
                    return OutlinedButton(
                      onPressed: null,
                      child: Text(statusText),
                    );
                  }
                  
                  return ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => ApplicationSubmissionSheet(
                          opportunity: opportunity.opportunity,
                          onSuccess: () {
                            // Refresh the application status after successful submission
                            // ignore: unused_result
                            ref.refresh(checkApplicationStatusProvider(opportunity.opportunity.id));
                          },
                        ),
                      );
                    },
                    child: const Text('Apply Now'),
                  );
                },
                loading: () => const SizedBox(
                  height: 40,
                  child: Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
                error: (error, stackTrace) => ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  },
                  child: const Text('Apply Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillMatrix {
  const _SkillMatrix({
    required this.matchPercentage,
    required this.matchedSkills,
  });

  final int matchPercentage;
  final Set<String> matchedSkills;
}

_SkillMatrix _buildSkillMatrix({
  required List<String> opportunitySkills,
  required List<String> studentSkills,
}) {
  final normalizedOpportunitySkills = opportunitySkills
      .map((skill) => skill.trim().toLowerCase())
      .where((skill) => skill.isNotEmpty)
      .toSet();
  final normalizedStudentSkills = studentSkills
      .map((skill) => skill.trim().toLowerCase())
      .where((skill) => skill.isNotEmpty)
      .toSet();

  if (normalizedOpportunitySkills.isEmpty) {
    return const _SkillMatrix(matchPercentage: 100, matchedSkills: <String>{});
  }

  final matchedSkills =
      normalizedOpportunitySkills.intersection(normalizedStudentSkills);
  final percentage =
      ((matchedSkills.length / normalizedOpportunitySkills.length) * 100)
          .round();

  return _SkillMatrix(
    matchPercentage: percentage,
    matchedSkills: matchedSkills,
  );
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Text(label),
    );
  }
}
