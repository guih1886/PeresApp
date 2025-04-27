import 'package:flutter/material.dart';
import 'package:pi_desenv_mobile/components/barra_navegacao.dart';
import 'package:pi_desenv_mobile/screens/oferta_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;
  final List<Widget> pages = [
    const OfertaScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(255, 200, 255, 0.5),
          width: width,
          height: height,
          child: pages[currentPageIndex],
        ),
      ),
      bottomNavigationBar: BarraNavegacao(
        onPageChanged: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
