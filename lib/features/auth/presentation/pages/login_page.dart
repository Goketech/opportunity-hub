import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:opportunity_hub/core/router/app_router.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in with your ALU email to access internships and startup opportunities.',
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
                            'Sign In',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            decoration: const InputDecoration(
                              labelText: 'ALU Email',
                              hintText: 'you@alueducation.com',
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
                            autofillHints: const [AutofillHints.password],
                            decoration: const InputDecoration(labelText: 'Password'),
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'Password is required.';
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
                                        .signIn(
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
                                : const Text('Sign In'),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () => context.go(AppRoutes.signup),
                            child: const Text('Create an account'),
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
