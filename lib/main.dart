import 'package:flutter/material.dart';
import 'package:peres_app/screens/home_screen.dart';
import 'package:peres_app/screens/ofertas/oferta_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery.of(context).textScaler.scale(16);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(fontSize: fontSize,),
      routes: {
        "/ofertas": (context) => OfertaScreen(fontSize: fontSize),
        "/produtos": (context) => OfertaScreen(fontSize: fontSize),
        "/sobre": (context) => OfertaScreen(fontSize: fontSize),
        "/disponibilidade": (context) => OfertaScreen(fontSize: fontSize),
        "/contato": (context) => OfertaScreen(fontSize: fontSize),
        "/suporte": (context) => OfertaScreen(fontSize: fontSize),
      },
    );

  }
}

