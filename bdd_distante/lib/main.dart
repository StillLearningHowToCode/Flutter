import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(
        title: "Le widget ListView",
      ),
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
  void lire() async {
    var url = Uri.parse(
        'https://lpsil.iutmetz.univ-lorraine.fr/android/ws_recettes/get_categories.php');
    var response = await http.post(url, body: {
      "no_categorie": "1",
      "lib_categorie": "Entree",
      "no_ordre": "0",
      "supprimee": "0"
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var parsedJson = convert.json.decode(response.body);
    parsedJson.forEach((element) => print('Element : $element'));
  }

  void _showMyDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Êtes vous sûr de vouloir supprimer cet élément ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                // Text('Êtes vous sûr de vouloir supprimer cet élément ?'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    lire();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  ListView(padding: const EdgeInsets.all(8), children: <Widget>[
                Container(
                    // alignment: Alignment.center,
                    height: 50,
                    color: Colors.yellow[100],
                    child: Row(
                      children: [
                        const Center(child: Text('Element A')),
                        ElevatedButton(
                          onPressed: () {
                            _showMyDialog();
                          },
                          child: const Text('-'),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    )),
                Container(
                  height: 50,
                  color: Colors.pink[50],
                  child: const Center(child: Text('Element B')),
                ),
                Container(
                  height: 50,
                  color: Colors.blue[50],
                  child: const Center(child: Text('Element C')),
                )
              ]),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     _showMyDialog();
            //   },
            //   child: const Text('-'),
            // ),
          ],
        )); // This trailing comma makes auto-formatting nicer for build methods
  }
}

// Données en dur
// Map<String, dynamic> entree = {
//       "no_categorie": "1",
//       "lib_categorie": "Entr\u00e9e",
//       "no_ordre": "0",
//       "supprimee": "0"
//     },
//     viande = {
//       "no_categorie": "3",
//       "lib_categorie": "Viande",
//       "no_ordre": "1",
//       "supprimee": "0"
//     },
//     poisson = {
//       "no_categorie": "4",
//       "lib_categorie": "Poissons",
//       "no_ordre": "2",
//       "supprimee": "0"
//     },
//     dessert = {
//       "no_categorie": "6",
//       "lib_categorie": "Dessert",
//       "no_ordre": "3",
//       "supprimee": "0"
//     };
