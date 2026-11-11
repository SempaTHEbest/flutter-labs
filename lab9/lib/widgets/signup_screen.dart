import 'package:flutter/material.dart';

import '../validators.dart';
import 'common.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() => _autovalidate = AutovalidateMode.onUserInteraction);
    if (_formKey.currentState!.validate()) {
      showMessage(
        context,
        'Реєстрація',
        "Ім'я: ${_nameController.text.trim()}\n"
            'E-mail: ${_emailController.text.trim()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppLogo(size: 72),
                const SizedBox(height: 14),
                const ScreenHeader(
                  title: 'Новий акаунт',
                  subtitle: 'Усі поля обовʼязкові',
                ),
                const SizedBox(height: 22),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: "Ім'я користувача",
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: validateName,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'E-mail (логін)',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 12),
                PasswordField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  validator: validatePassword,
                ),
                const SizedBox(height: 12),
                PasswordField(
                  controller: _confirmController,
                  hint: 'Повторіть пароль',
                  validator: (v) =>
                      validatePasswordConfirm(v, _passwordController.text),
                  onSubmitted: _submit,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Зареєструватися'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Назад до входу'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
