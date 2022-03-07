import 'package:flutter/material.dart';

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
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
