import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../controllers/demo_auth_controller.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final _code = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Verify')),
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  demoAuth.email.isEmpty
                      ? 'Start with sign up or login to try verification.'
                      : 'Demo verification for ${demoAuth.email}',
                ),
                const SizedBox(height: 16),
                const Text(
                  'No email was sent. Enter demo code ${DemoAuthController.demoCode}.',
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _code,
                  decoration: InputDecoration(
                    labelText: 'Verification code',
                    errorText: _error,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 6,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: demoAuth.email.isEmpty
                      ? null
                      : () {
                          if (demoAuth.verify(_code.text)) {
                            context.go(AppRoutes.home);
                          } else {
                            setState(
                              () => _error =
                                  'Use the demo code ${DemoAuthController.demoCode}',
                            );
                          }
                        },
                  child: const Text('Verify and continue'),
                ),
                TextButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Demo only: no message sent. Code: ${DemoAuthController.demoCode}',
                      ),
                    ),
                  ),
                  child: const Text('Resend code (demo)'),
                ),
                TextButton(
                  onPressed: () => context.go(AppRoutes.welcome),
                  child: const Text('Back to welcome'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
