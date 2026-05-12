import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/brand_mark.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../dashboard/main_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _previewEmail = 'owner@salonflow.app';
  static const _previewPassword = 'salonflow123';

  final _emailController = TextEditingController(text: 'owner@salonflow.app');
  final _passwordController = TextEditingController(text: 'salonflow123');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            children: [
              const BrandMark(size: 76),
              const SizedBox(height: 16),
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Run your salon day without notebook chaos.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 15),
              ),
              const SizedBox(height: 12),
              const Text(
                'Use the preview owner account to access the current app build.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              const SizedBox(height: 32),
              PremiumCard(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email_rounded),
                        hintText: 'Phone or email',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _signIn,
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _showPreviewAccessInfo,
                          child: const Text('Preview Access'),
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                    // Future implementation:
                    // - Forgot password flow
                    // - Continue with Google
                    // - Account creation via web portal or in-app onboarding
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showAppMessage(context, 'Enter both account and password to continue.');
      return;
    }
    if (email != _previewEmail || password != _previewPassword) {
      showAppMessage(
        context,
        'Preview access is currently limited to the shared owner account.',
      );
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  Future<void> _showPreviewAccessInfo() async {
    await showInfoSheet(
      context,
      title: 'Preview Access',
      message:
          'This build currently supports one shared preview owner credential for review: owner@salonflow.app / salonflow123. Account creation, password recovery, and Google sign-in are reserved for future implementation.',
      actionLabel: 'Use Preview Account',
    );
    if (!mounted) {
      return;
    }
    _emailController.text = _previewEmail;
    _passwordController.text = _previewPassword;
  }
}
