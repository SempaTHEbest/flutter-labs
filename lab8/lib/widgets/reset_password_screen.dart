import 'package:flutter/material.dart';

import '../validators.dart';
import 'common.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      showMessage(context, 'Відновлення', 'Дані коректні, скидання паролю ще не реалізовано');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Відновлення паролю')),
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
                  title: 'Забули пароль?',
                  subtitle: 'Введіть логін або e-mail, і ми надішлемо '
                      'посилання для скидання паролю',
                ),
                const SizedBox(height: 28),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Логін або e-mail',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: validateLoginOrEmail,
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Скинути пароль'),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Повернутися до входу'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
