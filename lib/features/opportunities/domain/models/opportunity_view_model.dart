import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_model.dart';

class OpportunityViewModel {
  const OpportunityViewModel({
    required this.opportunity,
    required this.startupName,
    required this.startupLogoUrl,
    required this.isStartupAluVerified,
  });

  final OpportunityModel opportunity;
  final String startupName;
  final String startupLogoUrl;
  final bool isStartupAluVerified;
}
