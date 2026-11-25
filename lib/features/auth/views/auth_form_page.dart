import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../controllers/demo_auth_controller.dart';

class AuthFormPage extends StatefulWidget {
  const AuthFormPage({super.key, required this.isSignup});
  final bool isSignup;

  @override
  State<AuthFormPage> createState() => _AuthFormPageState();
}

class _AuthFormPageState extends State<AuthFormPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    for (final controller in [_name, _email, _password, _confirm]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    demoAuth.begin(email: _email.text, name: widget.isSignup ? _name.text : '');
    _password.clear();
    _confirm.clear();
    context.push(AppRoutes.verify);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.isSignup ? 'Sign up' : 'Log in')),
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Parent demo • Use made-up details. Passwords are not checked against an account or saved.',
                  ),
                  const SizedBox(height: 24),
                  if (widget.isSignup) ...[
                    TextFormField(
                      controller: _name,
                      decoration: const InputDecoration(labelText: 'Name'),
                      textCapitalization: TextCapitalization.words,
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Enter a name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) =>
                        RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
                            .hasMatch(value?.trim() ?? '')
                        ? null
                        : 'Enter a valid email',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _password,
                    obscureText: _hidePassword,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        tooltip: _hidePassword
                            ? 'Show password'
                            : 'Hide password',
                        onPressed: () =>
                            setState(() => _hidePassword = !_hidePassword),
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                    validator: (value) => (value?.length ?? 0) < 6
                        ? 'Use at least 6 characters for this demo'
                        : null,
                  ),
                  if (widget.isSignup) ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirm,
                      obscureText: _hidePassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Confirm password',
                      ),
                      validator: (value) => value != _password.text
                          ? 'Passwords must match'
                          : null,
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _submit,
                    child: const Text('Continue to verification'),
                  ),
                  TextButton(
                    onPressed: () => context.pushReplacement(
                      widget.isSignup ? AppRoutes.login : AppRoutes.signup,
                    ),
                    child: Text(
                      widget.isSignup
                          ? 'Already have an account? Log in'
                          : 'New here? Create account',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
