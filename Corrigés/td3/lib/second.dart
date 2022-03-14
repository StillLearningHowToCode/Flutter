import 'package:flutter/material.dart';

class MySecondScreen extends StatefulWidget {
  const MySecondScreen(this.login, this.password, {Key? key}) : super(key: key);

  // Un StatefulWidget est immuable, la variable sont donc constantes
  final String login;
  final String password;

  @override
  State<MySecondScreen> createState() => _MySecondScreenState();
}

class _MySecondScreenState extends State<MySecondScreen> {
  // Contrôleurs pour les champs de saisie
  final TextEditingController _ctrlMdp1 = TextEditingController();
  final TextEditingController _ctrlMdp2 = TextEditingController();

  // Identifiant pour le formulaire
  final _formKey = GlobalKey<FormState>();

  // Retour à l'écran principal avec renvoi du mdp
  void onClicValider() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _ctrlMdp1.text);
    }
  }

  // Retour à l'écran principal sans renvoi
  void onClicAnnuler() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modification du mot de passe")),
      body:
          // Gestion du bouton back de l'appBar ET du téléphone
          WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            margin: const EdgeInsets.all(10),
            color: Colors.grey[200],
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 70),
                        child: Text(
                          'Bienvenue ' + widget.login,
                          style: const TextStyle(fontSize: 20),
                        )),
                    _buildColumnSaisie(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: onClicAnnuler,
                              child: const Text('Annuler'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: onClicValider,
                              child: const Text('Valider'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnSaisie() {
    return Column(
      children: [
        _buildChampMotDePasse(_ctrlMdp1, _ctrlMdp2, 'Nouveau mot de passe'),
        _buildChampMotDePasse(_ctrlMdp2, _ctrlMdp1, 'Confirmer le mot de passe')
      ],
    );
  }

  Widget _buildChampMotDePasse(
      TextEditingController ctrl1, TextEditingController ctrl2, String hint) {
    return TextFormField(
      controller: ctrl1,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Le mot de passe est obligatoire !';
        }
        if (value.length < 8) {
          return 'Le mot de passe est trop court !';
        }
        if (!_bienForme(value)) {
          return 'Le mot de passe doit contenir majuscule, minuscule et chiffre !';
        }
        if (value != ctrl2.text) {
          return 'Les deux mots de passe doivent être identiques';
        }

        return null;
      },
      obscureText: true,
      decoration: InputDecoration(hintText: hint),
    );
  }

  bool _bienForme(String mdp) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(mdp);
  }
}
