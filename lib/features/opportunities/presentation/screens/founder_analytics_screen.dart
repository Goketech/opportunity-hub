import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/founder_metrics_model.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/founder_applications_providers.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/opportunity_providers.dart';

class FounderAnalyticsScreen extends ConsumerWidget {
  const FounderAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startupId = ref.watch(founderStartupIdProvider);

    if (startupId == null) {
      return const Center(
        child: Text('Unable to load analytics. Please log in as a founder.'),
      );
    }

    final metricsAsync = ref.watch(founderMetricsProvider(startupId));

    return metricsAsync.when(
      data: (metrics) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Posting Performance',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Live metrics from Firestore aggregation counters.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _MetricCard(
              title: 'Total Views',
              value: metrics.totalViews.toString(),
              subtitle: 'Unique in-app feed impressions (session deduped)',
              icon: Icons.visibility,
              color: Colors.blue,
            ),
            const SizedBox(height: 12),
            _MetricCard(
              title: 'Total Applications',
              value: metrics.totalApplications.toString(),
              subtitle: 'Applications submitted to your postings',
              icon: Icons.mail,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            _MetricCard(
              title: 'Conversion Rate',
              value: '${metrics.conversionRate.toStringAsFixed(1)}%',
              subtitle: _conversionFormulaLabel(metrics),
              icon: Icons.trending_up,
              color: Colors.deepOrange,
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text('Failed to load analytics: $error'),
      ),
    );
  }

  String _conversionFormulaLabel(FounderMetricsModel metrics) {
    if (metrics.totalViews == 0) {
      return 'No view data yet';
    }
    return '${metrics.totalApplications} / ${metrics.totalViews} x 100';
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
