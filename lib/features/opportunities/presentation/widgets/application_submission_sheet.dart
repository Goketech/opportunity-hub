import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_model.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/application_providers.dart';

class ApplicationSubmissionSheet extends ConsumerStatefulWidget {
  final OpportunityModel opportunity;
  final VoidCallback? onSuccess;

  const ApplicationSubmissionSheet({
    required this.opportunity,
    this.onSuccess,
    super.key,
  });

  @override
  ConsumerState<ApplicationSubmissionSheet> createState() => _ApplicationSubmissionSheetState();
}

class _ApplicationSubmissionSheetState extends ConsumerState<ApplicationSubmissionSheet> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = {};
    _focusNodes = {};

    for (final question in widget.opportunity.screeningQuestions) {
      _controllers[question] = TextEditingController();
      _focusNodes[question] = FocusNode();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    for (final node in _focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  void _submitApplication() async {
    final auth = ref.read(authNotifierProvider);
    final authState = auth.valueOrNull;
    
    if (authState is! AuthAuthenticated) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User information not available')),
        );
      }
      return;
    }

    // Validate all answers are filled
    final answers = <String, String>{};
    for (final question in widget.opportunity.screeningQuestions) {
      final answer = _controllers[question]?.text.trim() ?? '';
      if (answer.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please answer all questions')),
          );
        }
        return;
      }
      answers[question] = answer;
    }

    final studentId = authState.profile.id;
    final result = await ref.read(applicationSubmissionProvider.notifier).submitApplication(
      opportunityId: widget.opportunity.id,
      studentId: studentId,
      startupId: widget.opportunity.startupId,
      answers: answers,
    );

    if (mounted) {
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully!')),
        );
        widget.onSuccess?.call();
        Navigator.pop(context);
      } else {
        final error = ref.read(applicationSubmissionProvider).errorMessage ?? 'Failed to submit application';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final submissionState = ref.watch(applicationSubmissionProvider);
    final isLoading = submissionState.isLoading;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Padding(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Answer Questions',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    tooltip: 'Close',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.opportunity.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                widget.opportunity.screeningQuestions.length,
                (index) {
                  final question = widget.opportunity.screeningQuestions[index];
                  final controller = _controllers[question]!;
                  final focusNode = _focusNodes[question]!;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: 'Type your answer here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          minLines: 3,
                          maxLines: 5,
                          textInputAction: TextInputAction.newline,
                          enabled: !isLoading,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submitApplication,
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
