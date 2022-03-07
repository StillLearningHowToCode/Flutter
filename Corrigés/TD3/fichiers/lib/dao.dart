import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'utilisateur.dart';
import 'dart:convert';

class DAO {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/utilisateur.txt');
  }

  static Future<File> writeUtilisateur(Utilisateur p) async {
    final file = await _localFile;
    return file.writeAsString(json.encode(p.toJson()));
  }

  static Future<Utilisateur?> readUtilisateur() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();

      return Utilisateur.fromJson(contents);
    } catch (e) {
      return null;
    }
  }
}
