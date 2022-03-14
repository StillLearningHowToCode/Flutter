import 'dart:convert';

class Categorie {
  // Les attributs ne sont pas 'final' car dans un cas plus complet
  // est amené à modifier les valeurs
  int _id;
  String _libelle;
  int _noOrdre;

  get libelle {
    return _libelle;
  }

  Categorie(this._id, this._libelle, this._noOrdre);

  @override
  String toString() {
    return _libelle;
  }

  // Méthode utiisée par la DAO pour créer une
  // liste d'instances de Categorie
  // à partir d'une liste d'objets JSON
  static List<Categorie> listeFromJsonString(String sJSON) {
    List<Categorie> liste = [];

    var json = jsonDecode(sJSON);

    for (var value in json) {
      liste.add(Categorie(int.parse(value['no_categorie']),
          value['lib_categorie'], int.parse(value['no_ordre'])));
    }

    return liste;
  }
}
