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
      home: const MyHomePage(title: 'Interface simple - Login'),
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
  // Gestion de la case à cocher
  bool _souvenir = false;

  void onChangeSouvenir(bool? checked) {
    // nécessaire pour faire évoluer l'interface
    setState(() {
      _souvenir = checked!;
    });
  }

  // Clic sur le bouton => Affichage d'un petit message
  void onClicConnexion() {
    const snackBar = SnackBar(
      content: Text('Connexion en cours...'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return Column(
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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildColumnSaisie() {
    return Column(
      children: const [
        TextField(
          decoration: InputDecoration(hintText: 'Login'),
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Mot de passe'),
        ),
      ],
    );
  }

  // En ligne, utilisation de Flexible car, par défaut, un
  // TextField est aussi grand que le parent
  Widget _buildRowSaisie() {
    return Row(
      children: const [
        Flexible(
          flex: 3,
          child: TextField(
            decoration: InputDecoration(hintText: 'Login'),
          ),
        ),
        Spacer(flex: 1),
        Flexible(
          flex: 3,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: 'Mot de passe'),
          ),
        ),
      ],
    );
  }
}
