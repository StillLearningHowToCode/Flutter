// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formulaire/formulaire.dart';

void main => runApp(MonApp());

class MonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green;
      ),
      home: Formulaire(),
    )
  }
}