import 'package:flutter/material.dart';
import 'pages/pantalla_Principal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: PantallaPrincipal() ,
    );
  }
}
