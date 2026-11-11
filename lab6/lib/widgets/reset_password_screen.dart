import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Відновлення паролю'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset('assets/logo.png', height: 90),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Скидання паролю',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Вкажіть логін або e-mail, і ми надішлемо '
                'інструкції для встановлення нового паролю.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Логін або e-mail',
                  prefixIcon: Icon(Icons.alternate_email),
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Text('Повідомлення'),
                        content: const Text('Відновлення ще не реалізовано'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  )
                },
                icon: const Icon(Icons.lock_reset),
                label: const Text('Скинути пароль'),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.arrow_back),
                label: const Text('Назад до входу'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
