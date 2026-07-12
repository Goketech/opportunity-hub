import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/application_model.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/founder_applications_providers.dart';

class FounderApplicationsScreen extends ConsumerWidget {
  const FounderApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupId = ref.watch(founderStartupIdProvider);

    if (startupId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Applications')),
        body: const Center(
          child: Text('Unable to load applications. Please log in as a founder.'),
        ),
      );
    }

    final applicationsAsync = ref.watch(founderApplicationsProvider(startupId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming Applications'),
        elevation: 0,
      ),
      body: applicationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
            ],
          ),
        ),
        data: (applications) {
          if (applications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No applications yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Applications from students will appear here',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: applications.length,
            itemBuilder: (context, index) {
              return ApplicationCard(
                application: applications[index],
              );
            },
          );
        },
      ),
    );
  }
}

class ApplicationCard extends ConsumerStatefulWidget {
  final ApplicationModel application;

  const ApplicationCard({
    required this.application,
    super.key,
  });

  @override
  ConsumerState<ApplicationCard> createState() => _ApplicationCardState();
}

class _ApplicationCardState extends ConsumerState<ApplicationCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final statusUpdateAsync = ref.watch(applicationStatusUpdateProvider);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Header with applicant name and status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getStatusColor(widget.application.status).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Application ID: ${widget.application.id.substring(0, 8)}...',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Submitted ${_formatDate(widget.application.appliedAt)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.application.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.application.status.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Expandable content
          if (_isExpanded) ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Screening Answers Section
                  Text(
                    'Screening Answers',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 12),
                  ...widget.application.answers.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              entry.value,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  // Review Notes (if reviewed)
                  if (widget.application.reviewNotes != null) ...[
                    Text(
                      'Review Notes',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.application.reviewNotes!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Status Update Buttons
                  if (widget.application.status == ApplicationStatus.submitted)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: statusUpdateAsync.isLoading
                                ? null
                                : () => _updateStatus(
                              ApplicationStatus.reviewed,
                            ),
                            icon: const Icon(Icons.check_circle),
                            label: const Text('Shortlist'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: statusUpdateAsync.isLoading
                                ? null
                                : () => _showRejectDialog(),
                            icon: const Icon(Icons.close),
                            label: const Text('Reject'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (widget.application.status == ApplicationStatus.reviewed)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: statusUpdateAsync.isLoading
                                ? null
                                : () => _updateStatus(
                              ApplicationStatus.accepted,
                            ),
                            icon: const Icon(Icons.thumb_up),
                            label: const Text('Accept'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: statusUpdateAsync.isLoading
                                ? null
                                : () => _showRejectDialog(),
                            icon: const Icon(Icons.thumb_down),
                            label: const Text('Reject'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
          // Expand/Collapse Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton.icon(
              onPressed: () {
                setState(() => _isExpanded = !_isExpanded);
              },
              icon: Icon(
                _isExpanded
                    ? Icons.expand_less
                    : Icons.expand_more,
              ),
              label: Text(
                _isExpanded ? 'Show Less' : 'Show More',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateStatus(ApplicationStatus newStatus) async {
    final notifier = ref.read(applicationStatusUpdateProvider.notifier);
    await notifier.updateStatus(
      applicationId: widget.application.id,
      newStatus: newStatus,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Application updated to ${newStatus.name}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) => _RejectDialog(
        applicationId: widget.application.id,
      ),
    );
  }

  Color _getStatusColor(ApplicationStatus status) {
    return switch (status) {
      ApplicationStatus.submitted => Colors.orange,
      ApplicationStatus.reviewed => Colors.blue,
      ApplicationStatus.accepted => Colors.green,
      ApplicationStatus.rejected => Colors.red,
      ApplicationStatus.withdrawn => Colors.grey,
    };
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

class _RejectDialog extends ConsumerStatefulWidget {
  final String applicationId;

  const _RejectDialog({
    required this.applicationId,
  });

  @override
  ConsumerState<_RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends ConsumerState<_RejectDialog> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusUpdateAsync = ref.watch(applicationStatusUpdateProvider);

    return AlertDialog(
      title: const Text('Reject Application'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add optional feedback for the applicant:',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Feedback (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: statusUpdateAsync.isLoading
              ? null
              : () => _rejectApplication(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Reject'),
        ),
      ],
    );
  }

  void _rejectApplication() async {
    final notifier = ref.read(applicationStatusUpdateProvider.notifier);
    await notifier.updateStatus(
      applicationId: widget.applicationId,
      newStatus: ApplicationStatus.rejected,
      reviewNotes: _notesController.text.isNotEmpty
          ? _notesController.text
          : null,
    );

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Application rejected'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
