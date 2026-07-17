import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:opportunity_hub/core/router/app_router.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
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
    final isLoading = authAsync.isLoading || authAsync.valueOrNull is AuthLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              children: [
                Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Only ALU identities are eligible. Use your institutional email to continue.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 28),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'ALU Email',
                              hintText: 'you@alu.edu',
                            ),
                            validator: (value) {
                              final email = (value ?? '').trim().toLowerCase();
                              final isValidDomain =
                                  email.endsWith('@alueducation.com') ||
                                  email.endsWith('@alu.edu') ||
                                  email.endsWith('@alustudent.com');
                              if (email.isEmpty) {
                                return 'Email is required.';
                              }
                              if (!isValidDomain) {
                                return 'Use an ALU email domain.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: 'Minimum 8 characters',
                            ),
                            validator: (value) {
                              if ((value ?? '').length < 8) {
                                return 'Password must be at least 8 characters.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _confirmController,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'Confirm Password'),
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    await ref
                                        .read(authNotifierProvider.notifier)
                                        .signUp(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        );
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Create Account'),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () => context.go(AppRoutes.login),
                            child: const Text('Back to sign in'),
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
