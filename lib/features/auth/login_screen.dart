import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../shared/widgets/brand_mark.dart';
import '../../shared/widgets/helpers.dart';
import '../../shared/widgets/premium_card.dart';
import '../dashboard/main_shell.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              const SizedBox(height: 32),
              PremiumCard(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email_rounded),
                        hintText: 'Phone or email',
                      ),
                    ),
                    const SizedBox(height: 12),
                    const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const MainShell()),
                      ),
                      child: const Text('Sign In'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () => showInfoSheet(
                        context,
                        title: 'Google Sign-In',
                        message:
                            'Google authentication is not configured in this demo build yet. Use Sign In to continue through the app.',
                      ),
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 30),
                      label: const Text('Continue with Google'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => showInfoSheet(
                            context,
                            title: 'Reset Password',
                            message:
                                'Password reset would normally send a recovery link or OTP to the account contact.',
                          ),
                          child: const Text('Forgot password?'),
                        ),
                        TextButton(
                          onPressed: () => showInfoSheet(
                            context,
                            title: 'Create Account',
                            message:
                                'Account creation is not wired to a backend in this demo build yet.',
                          ),
                          child: const Text('Create account'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
