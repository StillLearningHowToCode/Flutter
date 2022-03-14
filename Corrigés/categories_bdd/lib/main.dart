import 'package:flutter/material.dart';
import './dao/mysqldao_categorie.dart';
import './metier/categorie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Démo BDD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UICategoriesWidget(),
    );
  }
}

class UICategoriesWidget extends StatefulWidget {
  const UICategoriesWidget({Key? key}) : super(key: key);

  @override
  State<UICategoriesWidget> createState() => _UICategoriesWidgetState();
}

class _UICategoriesWidgetState extends State<UICategoriesWidget> {
  List<Categorie>? _categories;

  @override
  void initState() {
    _chargeCategories();
    super.initState();
  }

  void _chargeCategories() async {
    _categories = await MySQLDAOCategorie.getCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des catégories"),
      ),
      body: _categories == null
          ? const Center(
              child: Text("Chargement en cours..."),
            )
          : ListView(
              padding: const EdgeInsets.all(10),
              children: <Widget>[
                for (var idx = 0; idx < _categories!.length; idx++)
                  ListTile(
                    title: Text(_categories![idx].libelle),
                    trailing: Icon(Icons.remove_circle,
                        color: Theme.of(context).primaryColor),
                    onTap: () {
                      _showDialogSuppr(_categories![idx]);
                    },
                  ),
              ],
            ),
    );
  }

  void _showDialogSuppr(Categorie categorieSelectionnee) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Etes-vous sûr que vous voulez supprimer ?'),
        content: Text(categorieSelectionnee.libelle),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('ANNULER'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _categories!.remove(categorieSelectionnee);
              });
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
