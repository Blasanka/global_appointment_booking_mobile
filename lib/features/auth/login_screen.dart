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
                'Preview access is ready. You can sign in with the filled account or enter your own details.',
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
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _continueWithGoogle,
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 30),
                      label: const Text('Continue with Google'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _sendReset,
                          child: const Text('Forgot password?'),
                        ),
                        TextButton(
                          onPressed: _createAccount,
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

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showAppMessage(context, 'Enter both account and password to continue.');
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  void _continueWithGoogle() {
    _emailController.text = 'owner@salonflow.app';
    _passwordController.text = 'salonflow123';
    showAppMessage(context, 'Google account selected. Continuing to dashboard.');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  void _sendReset() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      showAppMessage(context, 'Enter your account email first.');
      return;
    }
    showAppMessage(context, 'Password reset instructions sent to $email.');
  }

  Future<void> _createAccount() async {
    await showInfoSheet(
      context,
      title: 'Account Ready',
      message:
          'A preview owner account has been prepared for this device. Continue with the default details to access the dashboard.',
      actionLabel: 'Use Preview Account',
    );
    if (!mounted) return;
    _emailController.text = 'owner@salonflow.app';
    _passwordController.text = 'salonflow123';
  }
}
