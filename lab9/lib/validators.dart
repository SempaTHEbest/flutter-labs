final _emailRegExp = RegExp(r'^[\w.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$');

const int minPasswordLength = 7;

String? validateRequired(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return 'Поле «$fieldName» є обовʼязковим';
  }
  return null;
}

String? validateName(String? value) => validateRequired(value, "Ім'я");

String? validateEmail(String? value) {
  final required = validateRequired(value, 'E-mail');
  if (required != null) return required;
  if (!_emailRegExp.hasMatch(value!.trim())) {
    return 'Введіть коректний e-mail, напр. name@domain.com';
  }
  return null;
}

String? validatePassword(String? value) {
  final required = validateRequired(value, 'Пароль');
  if (required != null) return required;
  if (value!.length < minPasswordLength) {
    return 'Пароль має містити не менше $minPasswordLength символів';
  }
  return null;
}

String? validatePasswordConfirm(String? value, String password) {
  final required = validateRequired(value, 'Підтвердження паролю');
  if (required != null) return required;
  if (value != password) return 'Паролі не збігаються';
  return null;
}
