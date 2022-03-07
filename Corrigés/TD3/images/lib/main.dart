import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Images',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Images internes à l\'app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Tableau associatif (titre, choisi pour affichage)
  final Map<String, bool> _albums = {
    '833': false,
    '9868': false,
    '9984': false,
    '11238': true,
    '11280': false,
    '11285': false,
    '11353': false,
    '11362': false
  };

  void _onClicAlbum() {
    bool ajout = false;
    for (var titre in _albums.keys) {
      if (_albums[titre] == false) {
        setState(() {
          _albums[titre] = true;
        });
        ajout = true;
        break;
      }
    }

    // Si rien n'a été ajouté, on enlève tout
    if (!ajout) {
      _albums.forEach((key, value) {
        _albums[key] = false;
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 20,
          children: _buildGalerie(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClicAlbum,
        tooltip: 'Ajout d\'un album',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildGalerie() {
    const dossier = 'assets/albums/';
    const suffixe = '_150.jpg';

    List<Widget> images = [];
    _albums.forEach((titre, choisi) {
      if (choisi) {
        images.add(Image.asset(dossier + titre + suffixe, width: 100));
      }
    });

    return images;
  }
}
