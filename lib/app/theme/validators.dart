class Validators {
  static RegExp rgMail =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp rgString = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]");

  static String? validatePassword(String? value) {
    if (value!.length < 5) {
      return 'Mot de passe incorrect: au moins 6 caractères';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
    }
    if (!rgString.hasMatch(value)) {
      return 'Le nom d’utilisateur ou le mot de passe est incorrect';
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      // return 'Ne peut pas être vide';
      return '';
    }
    return null;
  }

  static String? validateInteger(String? value) {
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
    }
    int? val = int.tryParse(value);
    if (val == null) return 'Ce n\'est pas un nombre entier';
    return null;
  }

  static String? validatePercentage(String? value) {
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
    }

    double? val = double.tryParse(value);
    if (val == null || val < 0 || val > 100) return 'Ce n\'est pas un pourcentage valide';

    return null;
  }

  static String? validateDouble(String? value) {
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
    }
    double? val = double.tryParse(value);

    if (val == null) return 'Ce n\'est pas une valeur décimale';
    return null;
  }

  static String? validateDropDownEmpty(dynamic value) {
    if (value == null) {
      // return 'Ne peut pas être vide';
      return '';
    }
    return null;
  }
}
