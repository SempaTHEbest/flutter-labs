final _loginRegExp = RegExp(r'^[a-zA-Z0-9_.]+$');
final _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');

String? validateName(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return "Введіть ім'я";
  if (v.length < 2) return "Ім'я має містити щонайменше 2 символи";
  return null;
}

String? validateLogin(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Введіть логін';
  if (v.length < 4) return 'Логін має містити щонайменше 4 символи';
  if (!_loginRegExp.hasMatch(v)) {
    return 'Дозволені лише латинські літери, цифри, «_» та «.»';
  }
  return null;
}

String? validatePassword(String? value) {
  final v = value ?? '';
  if (v.isEmpty) return 'Введіть пароль';
  if (v.length < 6) return 'Пароль має містити щонайменше 6 символів';
  if (!v.contains(RegExp(r'[A-Z]'))) {
    return 'Пароль має містити хоча б одну велику літеру';
  }
  return null;
}

String? validateLoginOrEmail(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Введіть логін або e-mail';
  if (v.contains('@')) {
    return _emailRegExp.hasMatch(v) ? null : 'Некоректний e-mail';
  }
  return validateLogin(v);
}
