import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      home: const MyHomePage(title: 'Images internes ou network'),
    );
  }
}

///
/// Enumération pour les 3 types d'image
///
enum TypeImages { internes, network, cachedNetwork }

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _myTitle;

  @override
  void initState() {
    _myTitle = widget.title;
    super.initState();
  }

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

  // Le type d'images par défaut
  var _typeImagesChoisi = TypeImages.internes;

  // Sélection d'un bouton radio
  void _onChangeRadio(TypeImages? value) {
    _deselectionneAlbums();
    setState(() {
      _typeImagesChoisi = value!;
    });
  }

  void _onClicAjout() {
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
      _deselectionneAlbums();
    }
  }

  // Désélection de tous les abums
  // quand on a tout affiché
  // ou quand on change de types d'image avec les boutons radio
  void _deselectionneAlbums() {
    _albums.forEach((key, value) {
      _albums[key] = false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            RadioListTile<TypeImages>(
                title: Text(TypeImages.internes.name),
                value: TypeImages.internes,
                groupValue: _typeImagesChoisi,
                onChanged: _onChangeRadio),
            RadioListTile<TypeImages>(
                title: Text(TypeImages.network.name),
                value: TypeImages.network,
                groupValue: _typeImagesChoisi,
                onChanged: _onChangeRadio),
            RadioListTile<TypeImages>(
                title: Text(TypeImages.cachedNetwork.name),
                value: TypeImages.cachedNetwork,
                groupValue: _typeImagesChoisi,
                onChanged: _onChangeRadio),
            const Divider(),
            Wrap(
              spacing: 10,
              runSpacing: 20,
              children: _buildGalerie(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClicAjout,
        tooltip: 'Ajout d\'un album',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildGalerie() {
    const dossier = 'assets/albums/';
    const url = 'https://www.albumrock.net/dyn_img/pochettes_album/';
    const suffixe = '_150.jpg';

    List<Widget> images = [];
    _albums.map((key, value) => {
      if (value) {
        Widget? img;
        switch (_typeImagesChoisi) {
          case TypeImages.internes:
            img = Image.asset(dossier + titre + suffixe, width: 100);
            break;
          case TypeImages.network:
            img = Image.network(url + titre + suffixe, width: 100);
            break;
          case TypeImages.cachedNetwork:
            img = CachedNetworkImage(
              imageUrl: url + titre + suffixe,
              width: 100,
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
            );
            break;
        }
        images.add(img);
        return img;
      }
      return null;
    });

    return images;
  }
}
