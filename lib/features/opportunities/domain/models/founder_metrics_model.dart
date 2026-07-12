class FounderMetricsModel {
  const FounderMetricsModel({
    required this.startupId,
    required this.totalViews,
    required this.totalApplications,
  });

  final String startupId;
  final int totalViews;
  final int totalApplications;

  double get conversionRate {
    if (totalViews <= 0) {
      return 0;
    }
    return (totalApplications / totalViews) * 100;
  }
}
