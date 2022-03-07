import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utilisateur.dart';
import 'dao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Interface bloquée en portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hacking de login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Instance qui sera créée pour sauvegarde dans le fichier
  Utilisateur _utilisateur = Utilisateur('', '');

  // Contrôleurs pour les champs de saisie
  final TextEditingController _ctrlLogin = TextEditingController();
  final TextEditingController _ctrlMotDePasse = TextEditingController();

  // Identifiant pour le formulaire
  final _formKey = GlobalKey<FormState>();

  bool _souvenir = false;

  // Lancement de l'écran : lecture du fichier
  @override
  void initState() {
    _litFichier();
    super.initState();
  }

  void _litFichier() async {
    var utilisateurLu = await DAO.readUtilisateur();
    if (utilisateurLu != null) {
      var snackBar = SnackBar(
        content:
            Text('Dernier utilisateur hacké : ' + utilisateurLu.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void onChangeSouvenir(bool? checked) {
    setState(() {
      _souvenir = checked!;
    });
  }

  // Clic sur le bouton =>
  // Validation du formulaire, puis :
  // Si ok : enregistrement des données
  // Sinon : messages d'erreurs renvoyés par le validator
  void onClicConnexion() async {
    if (_formKey.currentState!.validate()) {
      var snackBar = SnackBar(
        content: Text('Connexion en cours de ' + _ctrlLogin.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (_souvenir) {
        _utilisateur = Utilisateur(_ctrlLogin.text, _ctrlMotDePasse.text);
        await DAO.writeUtilisateur(_utilisateur);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sur smartphone, pour éviter que le clavier fasse remonter l'interface
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          // Ajout d'un effet bordure + ombre
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 70),
                  child: Text(
                    'Identifiez-vous',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Column(
                  children: [_buildChampLogin(), _buildChampMotDePasse()],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  width: 280,
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Se souvenir de moi'),
                      value: _souvenir,
                      onChanged: onChangeSouvenir),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        child: const Text("Connexion"),
                        onPressed: onClicConnexion),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChampLogin() {
    return TextFormField(
      controller: _ctrlLogin,
      decoration: const InputDecoration(hintText: 'Login'),
      validator: (value) {
        // La validation est une règle "métier", elle doit donc
        // être faite dans l'objet métier Utilisateur (voir le setter)
        try {
          _utilisateur.login = value!;
        } on FormatException catch (e) {
          return e.message;
        }

        return null;
      },
    );
  }

  Widget _buildChampMotDePasse() {
    return TextFormField(
      controller: _ctrlMotDePasse,
      validator: (value) {
        // La validation est une règle "métier", elle doit donc
        // être faite dans l'objet métier Utilisateur (voir le setter)
        try {
          _utilisateur.motDePasse = value!;
        } on FormatException catch (e) {
          return e.message;
        }

        return null;
      },
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Mot de passe'),
    );
  }
}
