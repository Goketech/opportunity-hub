import 'package:opportunity_hub/features/auth/domain/models/user_profile.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

final class AuthOnboardingRequired extends AuthState {
  const AuthOnboardingRequired({required this.uid, required this.email});

  final String uid;
  final String email;
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.profile);

  final UserProfile profile;
}
