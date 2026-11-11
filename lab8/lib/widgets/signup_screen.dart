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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showMessage(context, 'Реєстрація', 'Дані коректні, реєстрацію ще не реалізовано');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppLogo(size: 80),
                const SizedBox(height: 18),
                const ScreenHeader(
                  title: 'Новий акаунт',
                  subtitle: 'Заповніть дані для реєстрації',
                ),
                const SizedBox(height: 28),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Ім'я користувача",
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: validateName,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Логін',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: validateLogin,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Пароль',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: validatePassword,
                ),
                const SizedBox(height: 28),
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
