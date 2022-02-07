import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); //? accept null

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
              // Text('Login'),
              TextFormField(
                  controller: _teLogin,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Login',
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Le login est obligatoire !';
                  //   }
                  //   return null;
                  // },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Login is required"),
                    EmailValidator(errorText: "Enter valid email id"),
                  ])
                  // validator: EmailValidator(errorText: "Enter valid email id"),
                  ),
              // Text('Mot De Passe'),
              Padding(
                // Even Padding On All Sides
                padding: EdgeInsets.all(10.0),
              ),
              TextFormField(
                controller: _tePass,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
                // Sans extension validator flutter
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Le mot de passe est obligatoire !';
                //   } else if (value.length < 6) {
                //     return "Password should be atleast 6 characters";
                //   } else if (value.length > 15) {
                //     return "Password should not be greater than 15 characters";
                //   } else
                //     return null;
                // },
                validator: MultiValidator([
                  RequiredValidator(errorText: "Password is required"),
                  MinLengthValidator(6,
                      errorText: "Password should be atleast 6 characters"),
                  MaxLengthValidator(15,
                      errorText:
                          "Password should not be greater than 15 characters")
                ]),
              ),
              Padding(
                // Even Padding On All Sides
                padding: EdgeInsets.all(10.0),
              ),
              ElevatedButton(
                // style: style,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //! vérif si pas de valeur 'null'
                    print("Validated");
                    clicLogin();
                  } else {
                    print("Not Validated");
                  }
                },

                child: const Text('Connection'),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
