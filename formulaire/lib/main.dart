import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulaire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Formulaire'),
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
// Déclaration variables (tout le temps en haut)
  final _formKey = GlobalKey<FormState>();
  final _teLogin = TextEditingController();
  final _tePass = TextEditingController();

// Définition des fonctions
  void clicLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connexion de ' + this._teLogin.text)));
    }
  }

  @override
  void dispose() {
    _teLogin.dispose();
    _tePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Login'),
              TextFormField(
                controller: _teLogin,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Login'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le login est obligatoire !';
                  }
                  return null;
                },
              ),
              Text('Mot De Passe'),
              TextFormField(
                controller: _tePass,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Mot de Passe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Le mot de passe est obligatoire !';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                // style: style,
                onPressed: () {},
                child: const Text('Enabled'),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
