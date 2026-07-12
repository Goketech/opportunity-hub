import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/domain/models/user_profile.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _skillsController = TextEditingController();
  final _verificationController = TextEditingController();

  UserRole _selectedRole = UserRole.student;
  StartupVerificationMethod _verificationMethod =
      StartupVerificationMethod.ventureTrackingId;

  @override
  void dispose() {
    _fullNameController.dispose();
    _bioController.dispose();
    _skillsController.dispose();
    _verificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        },
      );
    });

    final authAsync = ref.watch(authNotifierProvider);
    final authState = authAsync.valueOrNull;
    final onboardingState =
        authState is AuthOnboardingRequired ? authState : null;
    final isLoading = authAsync.isLoading || authState is AuthLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              children: [
                Text(
                  'Complete Onboarding',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  onboardingState == null
                      ? 'Set your role and profile details to continue.'
                      : 'Signed in as ${onboardingState.email}. Select your role and complete setup.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Role Selection',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 14),
                          SegmentedButton<UserRole>(
                            segments: const [
                              ButtonSegment<UserRole>(
                                value: UserRole.student,
                                icon: Icon(Icons.school_outlined),
                                label: Text('Student'),
                              ),
                              ButtonSegment<UserRole>(
                                value: UserRole.startupFounder,
                                icon: Icon(Icons.rocket_launch_outlined),
                                label: Text('Startup Founder'),
                              ),
                            ],
                            selected: {_selectedRole},
                            onSelectionChanged: (selection) {
                              setState(() {
                                _selectedRole = selection.first;
                              });
                            },
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            controller: _fullNameController,
                            decoration: const InputDecoration(labelText: 'Full Name'),
                            validator: (value) {
                              if ((value ?? '').trim().length < 3) {
                                return 'Enter your full name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _bioController,
                            minLines: 3,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: 'Bio',
                              hintText: 'Summarize your background and goals.',
                            ),
                            validator: (value) {
                              if ((value ?? '').trim().length < 20) {
                                return 'Please provide a richer bio (minimum 20 chars).';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _skillsController,
                            decoration: const InputDecoration(
                              labelText: 'Skills',
                              hintText: 'Flutter, Product Design, Data Analysis',
                            ),
                            validator: (value) {
                              if ((value ?? '').trim().isEmpty) {
                                return 'Add at least one skill.';
                              }
                              return null;
                            },
                          ),
                          if (_selectedRole == UserRole.startupFounder) ...[
                            const SizedBox(height: 18),
                            Text(
                              'ALU Startup Verification',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 10),
                            SegmentedButton<StartupVerificationMethod>(
                              segments: const [
                                ButtonSegment<StartupVerificationMethod>(
                                  value: StartupVerificationMethod.ventureTrackingId,
                                  label: Text('Venture Tracking ID'),
                                ),
                                ButtonSegment<StartupVerificationMethod>(
                                  value: StartupVerificationMethod.approvalToken,
                                  label: Text('Approval Token'),
                                ),
                              ],
                              selected: {_verificationMethod},
                              onSelectionChanged: (selection) {
                                setState(() {
                                  _verificationMethod = selection.first;
                                });
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _verificationController,
                              decoration: InputDecoration(
                                labelText: _verificationMethod ==
                                        StartupVerificationMethod.ventureTrackingId
                                    ? 'Venture Tracking ID'
                                    : 'Approval Token',
                              ),
                              validator: (value) {
                                if (_selectedRole == UserRole.startupFounder &&
                                    (value ?? '').trim().isEmpty) {
                                  return 'Verification credential is required.';
                                }
                                return null;
                              },
                            ),
                          ],
                          const SizedBox(height: 22),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    final skills = _skillsController.text
                                        .split(',')
                                        .map((s) => s.trim())
                                        .where((s) => s.isNotEmpty)
                                        .toList(growable: false);

                                    if (_selectedRole == UserRole.student) {
                                      await ref
                                          .read(authNotifierProvider.notifier)
                                          .completeStudentOnboarding(
                                            fullName: _fullNameController.text.trim(),
                                            bio: _bioController.text.trim(),
                                            skills: skills,
                                          );
                                      return;
                                    }

                                    await ref
                                        .read(authNotifierProvider.notifier)
                                        .completeFounderOnboarding(
                                          fullName: _fullNameController.text.trim(),
                                          bio: _bioController.text.trim(),
                                          skills: skills,
                                          verificationMethod: _verificationMethod,
                                          verificationCode: _verificationController.text,
                                        );
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Finish Onboarding'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
