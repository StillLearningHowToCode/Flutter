import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyListPage(title: 'Exemple de ListView'),
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  final List<String> _donnees = [
    'Allemagne',
    'France',
    'Italie',
    'Belgique',
    'Luxembourg',
    'Pays-Bas'
  ];

  void _ajouterPays(String pays) {
    setState(() {
      if (!_donnees.contains(pays)) {
        _donnees.add(pays);
      }
    });
  }

  void _saisirPays() {
    var _ctrlPays = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Saisir un nouveau pays'),
        content: TextField(
            decoration: const InputDecoration(
              hintText: 'Pays',
            ),
            controller: _ctrlPays),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _ajouterPays(_ctrlPays.text);
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: _donnees
              .map((e) => ListTile(
                    title: Text(e),
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saisirPays(),
        tooltip: 'Ajouter un pays',
        child: const Icon(Icons.add),
      ),
    );
  }
}
