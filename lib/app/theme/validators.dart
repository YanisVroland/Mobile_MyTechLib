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


  static String? validateEmail(String? value){
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
    }
    if (!rgMail.hasMatch(value)) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return 'Ne peut pas être vide';
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

}
