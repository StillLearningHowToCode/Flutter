import 'package:flutter/material.dart';

void main() {
  // var nombres = Map<int, String>();
// nombres[0] = "Un";
  // nombres[1] = "Un";
  // nombres[2] = "Deux";
  // nombres[3] = "Trois";
  // nombres[4] = "Quatre";
  // print("nombres = $nombres");
  List<String> words = ['fee', 'fi', 'fo', 'fum'];
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Images',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.pink and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
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
  int _counter = 0;
  List<String> images = [];
  @override
  void initState() {
    images.add("apartment.png");
    images.add("blocks.png");
    images.add("castle.png");
    images.add("museum.png");
    images.add("park.png");
    images.add("temple.png");
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 3,
        // Generate 50 widgets that display their index in the List.
        children: List.generate(_counter, (index) {
          return Center(
            child: Image.asset(images[index % images.length],
                height: 200, width: 200),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
