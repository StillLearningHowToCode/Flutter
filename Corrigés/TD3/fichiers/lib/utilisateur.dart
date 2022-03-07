import 'dart:convert';

class Utilisateur {
  String _login;
  String _motDePasse;

  Utilisateur(this._login, this._motDePasse);

  // Second constructeur, qui doit initialiser les 2 paramètres
  // AVANT d'entrer dans le corps de la fonction, pour être sûr
  // qu'ils ne sont pas null
  Utilisateur.fromJson(String jsonString)
      : _login = '',
        _motDePasse = '' {
    Map<String, dynamic> jsonObject = json.decode(jsonString);
    login = jsonObject['login'];
    motDePasse = jsonObject['motDePasse'];
  }

  set login(String value) {
    if (value.trim().isEmpty) {
      throw const FormatException('Le login ne peut être vide !');
    }
    if (!value.contains('@')) {
      throw const FormatException('Le login doit contenir un @ !');
    }
    var regEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
        caseSensitive: false, multiLine: false);
    if (regEmail.allMatches(value).length != 1) {
      throw const FormatException('Le login doit être une adresse mail !');
    }

    _login = value;
  }

  set motDePasse(String value) {
    if (value.trim().isEmpty) {
      throw const FormatException('Le mot de passe ne peut être vide !');
    }
    if (value.length < 8) {
      throw const FormatException('Le mot de passe est trop court !');
    }

    _motDePasse = value;
  }

  @override
  String toString() {
    return _login + ' / ' + _motDePasse;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> resBody = {};
    resBody["login"] = _login;
    resBody["motDePasse"] = _motDePasse;
    return resBody;
  }
}
