import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_notifier.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';

class StartupSetupPage extends ConsumerStatefulWidget {
  const StartupSetupPage({super.key});

  @override
  ConsumerState<StartupSetupPage> createState() => _StartupSetupPageState();
}

class _StartupSetupPageState extends ConsumerState<StartupSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _startupNameController = TextEditingController();
  final _logoUrlController = TextEditingController();
  final _teamSizeController = TextEditingController(text: '2');
  final _descriptionController = TextEditingController();
  final _categoriesController = TextEditingController();

  @override
  void dispose() {
    _startupNameController.dispose();
    _logoUrlController.dispose();
    _teamSizeController.dispose();
    _descriptionController.dispose();
    _categoriesController.dispose();
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
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              children: [
                Text(
                  'Set Up Your Startup Profile',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create the verified startup profile before accessing founder dashboards.',
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
                          TextFormField(
                            controller: _startupNameController,
                            decoration: const InputDecoration(labelText: 'Startup Name'),
                            validator: (value) {
                              if ((value ?? '').trim().length < 3) {
                                return 'Enter a valid startup name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _logoUrlController,
                            decoration: const InputDecoration(labelText: 'Logo URL'),
                            validator: (value) {
                              final raw = (value ?? '').trim();
                              final uri = Uri.tryParse(raw);
                              if (uri == null || !uri.hasAbsolutePath || uri.scheme.isEmpty) {
                                return 'Provide a valid public logo URL.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _teamSizeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Team Size'),
                            validator: (value) {
                              final parsed = int.tryParse((value ?? '').trim());
                              if (parsed == null || parsed < 1) {
                                return 'Team size must be at least 1.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _categoriesController,
                            decoration: const InputDecoration(
                              labelText: 'Categories',
                              hintText: 'FinTech, EdTech, HealthTech',
                            ),
                            validator: (value) {
                              if ((value ?? '').trim().isEmpty) {
                                return 'Add at least one category.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _descriptionController,
                            minLines: 4,
                            maxLines: 7,
                            decoration: const InputDecoration(labelText: 'Startup Description'),
                            validator: (value) {
                              if ((value ?? '').trim().length < 30) {
                                return 'Description must be at least 30 characters.';
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

                                    final categories = _categoriesController.text
                                        .split(',')
                                        .map((item) => item.trim())
                                        .where((item) => item.isNotEmpty)
                                        .toList(growable: false);

                                    await ref
                                        .read(authNotifierProvider.notifier)
                                        .completeFounderStartupSetup(
                                          startupName: _startupNameController.text.trim(),
                                          logoUrl: _logoUrlController.text.trim(),
                                          teamSize: int.parse(_teamSizeController.text.trim()),
                                          categories: categories,
                                          description: _descriptionController.text.trim(),
                                        );
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Text('Create Startup'),
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
