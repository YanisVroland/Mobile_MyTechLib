/*
  This file contains a class for performing various input validations.
*/

class Validators {
// Regular expressions for email and string validation
  static RegExp rgMail =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp rgString = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]");

// Validate password
  static String? validatePassword(String? value) {
    if (value!.length < 5) {
      return 'Mot de passe incorrect: au moins 6 caractères';
    }
    return null;
  }

// Validate email
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
    }
    if (!rgMail.hasMatch(value)) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

// Validate if a value is empty
  static String? validateEmpty(String? value) {
    if (value!.trim().isEmpty) {
      return 'Ne peut pas être vide';
    }
    return null;
  }

// Validate if a value is an integer
  static String? validateInteger(String? value) {
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
    }
    int? val = int.tryParse(value);
    if (val == null) return 'Ce n\'est pas un nombre entier';
    return null;
  }

// Validate if a dropdown value is empty
  static String? validateDropDownEmpty(dynamic value) {
    if (value == null) {
      return 'Ne peut pas être vide';
    }
    return null;
  }
}
