import 'package:flutter/material.dart';

import '../validators.dart';
import 'common.dart';
import 'reset_password_screen.dart';
import 'signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showMessage(context, 'Вхід', 'Дані коректні, авторизацію ще не реалізовано');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Іванашко Д.В., Лаб. 8')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppLogo(),
                const SizedBox(height: 18),
                const ScreenHeader(
                  title: 'З поверненням!',
                  subtitle: 'Увійдіть, щоб продовжити',
                ),
                const SizedBox(height: 28),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      ),
                    ),
                    child: const Text('Забули пароль?'),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Увійти'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  ),
                  child: const Text('Створити акаунт'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
