enum StartupVerificationFilter {
  all,
  aluVerifiedOnly,
  notVerified,
}

class OpportunityFilterState {
  const OpportunityFilterState({
    this.searchTerm = '',
    this.category,
    this.requiredSkills = const <String>[],
    this.verificationFilter = StartupVerificationFilter.all,
  });

  final String searchTerm;
  final String? category;
  final List<String> requiredSkills;
  final StartupVerificationFilter verificationFilter;

  OpportunityFilterState copyWith({
    String? searchTerm,
    String? category,
    bool clearCategory = false,
    List<String>? requiredSkills,
    StartupVerificationFilter? verificationFilter,
  }) {
    return OpportunityFilterState(
      searchTerm: searchTerm ?? this.searchTerm,
      category: clearCategory ? null : (category ?? this.category),
      requiredSkills: requiredSkills ?? this.requiredSkills,
      verificationFilter: verificationFilter ?? this.verificationFilter,
    );
  }
}
