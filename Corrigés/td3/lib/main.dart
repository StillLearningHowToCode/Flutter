import '../second.dart';
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
      home: const MyHomePage(title: 'Formulaire de login'),
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
  // Contrôleurs pour les champs de saisie
  final TextEditingController _ctrlLogin = TextEditingController();
  final TextEditingController _ctrlMotDePasse = TextEditingController();

  // Identifiant pour le formulaire
  final _formKey = GlobalKey<FormState>();

  bool _souvenir = false;

  void onChangeSouvenir(bool? checked) {
    setState(() {
      _souvenir = checked!;
    });
  }

  // Clic sur le bouton =>
  // Validation du formulaire, puis :
  // Si ok : appel second écran
  // Sinon : messages d'erreurs renvoyés par le validator
  void onClicConnexion() async {
    if (_formKey.currentState!.validate()) {
      String? newPass = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contexxt) =>
                  MySecondScreen(_ctrlLogin.text, _ctrlMotDePasse.text)));

      String msg;
      if (newPass != null) {
        msg = "Mot de passe modifié avec succès !";
      } else {
        msg = "Mise à jour abandonnée";
      }

      var snackBar = SnackBar(
        content: Text(msg),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sur smartphone, pour éviter que le clavier fasse reonter l'interface
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          margin: const EdgeInsets.all(10),
          color: Colors.grey[200],
          child: OrientationBuilder(
            builder: (context, orientation) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: orientation == Orientation.portrait
                          ? const EdgeInsets.only(top: 30, bottom: 70)
                          : const EdgeInsets.only(top: 10, bottom: 20),
                      child: const Text(
                        'Identifiez-vous',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    orientation == Orientation.portrait
                        ? _buildColumnSaisie()
                        : _buildRowSaisie(),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      width: 250,
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildColumnSaisie() {
    return Column(
      children: [_buildChampLogin(), _buildChampMotDePasse()],
    );
  }

  Widget _buildRowSaisie() {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: _buildChampLogin(),
        ),
        const Spacer(flex: 1),
        Flexible(
          flex: 3,
          child: _buildChampMotDePasse(),
        ),
      ],
    );
  }

  Widget _buildChampLogin() {
    return TextFormField(
      controller: _ctrlLogin,
      decoration: const InputDecoration(hintText: 'Login'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le login est obligatoire !';
        }
        if (!value.contains('@')) {
          return 'Le login doit contenir un @ !';
        }
        var regEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
            caseSensitive: false, multiLine: false);
        if (regEmail.allMatches(value).length != 1) {
          return 'Le login doit être une adresse mail !';
        }
        return null;
      },
    );
  }

  Widget _buildChampMotDePasse() {
    return TextFormField(
      controller: _ctrlMotDePasse,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le mot de passe est obligatoire !';
        }
        if (value.length < 6) {
          return 'Le mot de passe est trop court !';
        }
        return null;
      },
      obscureText: true,
      decoration: const InputDecoration(hintText: 'Mot de passe'),
    );
  }
}
