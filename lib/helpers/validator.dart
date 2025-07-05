String? fullNameValidator(String? value) {

  if (value == null || value.trim().isEmpty) {
    return 'Please enter your full name.';
  }

  final trimmed = value.trim();

  if (RegExp(r'^[0-9@\$!%*?&\-_]').hasMatch(trimmed)) {
    return 'Full name cannot start with a number or special character.';
  }

  // Match either exactly 3 English words or exactly 3 Arabic words
  final fullNameRegExp = RegExp(r'^([A-Za-z]+ [A-Za-z]+ [A-Za-z]+|[\u0621-\u064A]+ [\u0621-\u064A]+ [\u0621-\u064A]+)$',);

  if (!fullNameRegExp.hasMatch(trimmed)) {
    return 'Enter exactly three names.';
  }

  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your email address.';
  }

  final trimmed = value.trim();

  // Basic email pattern (RFC 5322 simplified)
  final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  if (!emailRegExp.hasMatch(trimmed)) {
    return 'Please enter a valid email address.';
  }

  return null;
}


String? passwordValidator(String? password) {
  if (password == null || password.trim().isEmpty) {
    return 'Password cannot be empty.';
  }
  if (password.length < 8) {
    return 'Password must be at least 8 characters long.';
  }
  if (!RegExp(r'[A-Z]').hasMatch(password)) {
    return 'Password must contain at least one uppercase letter.';
  }
  if (!RegExp(r'[a-z]').hasMatch(password)) {
    return 'Password must contain at least one lowercase letter.';
  }
  if (!RegExp(r'[0-9]').hasMatch(password)) {
    return 'Password must contain at least one number.';
  }
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
    return 'Password must contain at least one special character.';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Please enter your phone number.';
  }

  final trimmed = value.trim();

  // Starts with 5, followed by exactly 8 digits (total 9 digits)
  final phoneRegExp = RegExp(r'^5[0-9]{8}$');

  if (!phoneRegExp.hasMatch(trimmed)) {
    return 'Please enter a valid Saudi phone number.';
  }

  return null;
}
