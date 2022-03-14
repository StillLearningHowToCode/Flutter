import 'package:http/http.dart' as http;
import '../metier/categorie.dart';

class MySQLDAOCategorie {
  static const String urlServeur =
      "https://lpsil.iutmetz.univ-lorraine.fr/android/ws_recettes/";

  static Future<List<Categorie>> getCategories() async {
    final response =
        await http.get(Uri.parse(urlServeur + 'get_categories.php'));
    if (response.statusCode == 200) {
      return Categorie.listeFromJsonString(response.body);
    } else {
      throw Exception('Impossible de charger les categories');
    }
  }
}
