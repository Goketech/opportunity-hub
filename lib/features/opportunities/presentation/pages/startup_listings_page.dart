import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/data/opportunity_repository.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_model.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/opportunity_providers.dart';

class StartupListingsPage extends ConsumerWidget {
  const StartupListingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider).valueOrNull;
    final startupId = authState is AuthAuthenticated ? authState.profile.startupId : null;

    if (startupId == null || startupId.isEmpty) {
      return const Center(
        child: Text('Complete startup onboarding to post opportunities.'),
      );
    }

    final opportunitiesAsync = ref.watch(founderOpportunitiesProvider);

    return Scaffold(
      body: opportunitiesAsync.when(
        data: (items) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            children: [
              Text(
                'Your internship listings',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Create opportunities and track active postings in real-time.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              if (items.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No listings yet. Tap Post Opportunity to begin.'),
                  ),
                )
              else
                ...items.map((item) => _FounderOpportunityCard(opportunity: item)),
            ],
          );
        },
        error: (error, _) => Center(
          child: Text('Failed to load startup listings: $error'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) {
              return FractionallySizedBox(
                heightFactor: 0.95,
                child: _OpportunityCreationWizard(startupId: startupId),
              );
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Post Opportunity'),
      ),
    );
  }
}

class _FounderOpportunityCard extends StatelessWidget {
  const _FounderOpportunityCard({required this.opportunity});

  final OpportunityModel opportunity;

  @override
  Widget build(BuildContext context) {
    final statusColor = opportunity.isOpen ? Colors.green : Colors.grey;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    opportunity.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(opportunity.isOpen ? 'Open' : 'Closed'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(opportunity.description),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text(opportunity.category)),
                Chip(label: Text(opportunity.duration)),
                ...opportunity.requirements.map((tag) => Chip(label: Text(tag))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OpportunityCreationWizard extends ConsumerStatefulWidget {
  const _OpportunityCreationWizard({required this.startupId});

  final String startupId;

  @override
  ConsumerState<_OpportunityCreationWizard> createState() =>
      _OpportunityCreationWizardState();
}

class _OpportunityCreationWizardState
    extends ConsumerState<_OpportunityCreationWizard> {
  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skillController = TextEditingController();
  final _customQuestionController = TextEditingController();

  final List<String> _requiredSkills = <String>[];
  final List<String> _selectedQuestions = <String>[];

  CompensationType _compensationType = CompensationType.stipend;
  int _currentStep = 0;
  bool _submitting = false;

  static const _questionBank = <String>[
    'Why are you interested in this internship?',
    'Describe a project that best demonstrates your skills.',
    'What is your availability per week?',
    'How do you handle feedback and iteration?',
    'Share links to your portfolio or GitHub.',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    _skillController.dispose();
    _customQuestionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Internship Opportunity')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _onContinue,
        onStepCancel: _onCancel,
        onStepTapped: (index) => setState(() => _currentStep = index),
        controlsBuilder: (context, details) {
          final isFinalStep = _currentStep == 2;
          return Row(
            children: [
              FilledButton(
                onPressed: _submitting ? null : details.onStepContinue,
                child: Text(isFinalStep ? 'Publish Opportunity' : 'Continue'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: _submitting ? null : details.onStepCancel,
                child: const Text('Back'),
              ),
            ],
          );
        },
        steps: [
          Step(
            isActive: _currentStep >= 0,
            title: const Text('Role Basics'),
            content: Form(
              key: _formKeyStep1,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Role Title'),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.length < 4) {
                        return 'Title must be at least 4 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return 'Category is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _durationController,
                    decoration: const InputDecoration(
                      labelText: 'Duration (e.g. 3 months)',
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return 'Duration is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<CompensationType>(
                    initialValue: _compensationType,
                    decoration: const InputDecoration(labelText: 'Compensation'),
                    items: const [
                      DropdownMenuItem(
                        value: CompensationType.paid,
                        child: Text('Paid'),
                      ),
                      DropdownMenuItem(
                        value: CompensationType.stipend,
                        child: Text('Stipend'),
                      ),
                      DropdownMenuItem(
                        value: CompensationType.unpaid,
                        child: Text('Unpaid'),
                      ),
                      DropdownMenuItem(
                        value: CompensationType.equity,
                        child: Text('Equity'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _compensationType = value);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Step(
            isActive: _currentStep >= 1,
            title: const Text('Description & Skills'),
            content: Form(
              key: _formKeyStep2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _descriptionController,
                    minLines: 4,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      labelText: 'Role Description',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.length < 30) {
                        return 'Description must be at least 30 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _skillController,
                          decoration: const InputDecoration(
                            labelText: 'Required skill',
                          ),
                          onSubmitted: (_) => _addSkill(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        onPressed: _addSkill,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_requiredSkills.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _requiredSkills
                          .map(
                            (skill) => InputChip(
                              label: Text(skill),
                              onDeleted: () {
                                setState(() => _requiredSkills.remove(skill));
                              },
                            ),
                          )
                          .toList(),
                    )
                  else
                    Text(
                      'Add at least one required skill.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
          ),
          Step(
            isActive: _currentStep >= 2,
            title: const Text('Application Questions'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select screening questions applicants should answer.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _questionBank
                      .map(
                        (question) => FilterChip(
                          label: Text(question),
                          selected: _selectedQuestions.contains(question),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedQuestions.add(question);
                              } else {
                                _selectedQuestions.remove(question);
                              }
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _customQuestionController,
                        decoration: const InputDecoration(
                          hintText: 'Add custom question',
                        ),
                        onSubmitted: (_) => _addCustomQuestion(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _addCustomQuestion,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_selectedQuestions.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedQuestions
                        .map(
                          (question) => InputChip(
                            label: Text(question),
                            onDeleted: () {
                              setState(() {
                                _selectedQuestions.remove(question);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addSkill() {
    final skill = _skillController.text.trim().toLowerCase();
    if (skill.isEmpty) {
      return;
    }

    if (!_requiredSkills.contains(skill)) {
      setState(() => _requiredSkills.add(skill));
    }
    _skillController.clear();
  }

  void _addCustomQuestion() {
    final question = _customQuestionController.text.trim();
    if (question.isEmpty) {
      return;
    }

    if (!_selectedQuestions.contains(question)) {
      setState(() => _selectedQuestions.add(question));
    }
    _customQuestionController.clear();
  }

  Future<void> _onContinue() async {
    if (_currentStep == 0) {
      final valid = _formKeyStep1.currentState?.validate() ?? false;
      if (valid) {
        setState(() => _currentStep = 1);
      }
      return;
    }

    if (_currentStep == 1) {
      final valid = _formKeyStep2.currentState?.validate() ?? false;
      if (!valid) {
        return;
      }

      if (_requiredSkills.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Add at least one required skill.')),
        );
        return;
      }

      setState(() => _currentStep = 2);
      return;
    }

    if (_selectedQuestions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Select or add at least one application question.'),
        ),
      );
      return;
    }

    await _submit();
  }

  void _onCancel() {
    if (_currentStep == 0) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _currentStep -= 1);
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);

    try {
      await ref.read(opportunityRepositoryProvider).createOpportunity(
        startupId: widget.startupId,
        title: _titleController.text.trim(),
        category: _categoryController.text.trim(),
        description: _descriptionController.text.trim(),
        requiredSkills: _requiredSkills,
        duration: _durationController.text.trim(),
        compensationType: _compensationType,
        screeningQuestions: _selectedQuestions,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opportunity published successfully.')),
      );
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to publish opportunity: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }
}
