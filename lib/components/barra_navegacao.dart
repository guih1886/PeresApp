import 'package:flutter/material.dart';

class BarraNavegacao extends StatefulWidget {
  final ValueChanged<int> onPageChanged;

  const BarraNavegacao({super.key, required this.onPageChanged});

  @override
  State<BarraNavegacao> createState() => _BarraNavegacaoState();
}

class _BarraNavegacaoState extends State<BarraNavegacao> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        backgroundColor: const Color.fromRGBO(255, 200, 255, 0.5),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            widget.onPageChanged(currentPageIndex);
          });
        },
        indicatorColor: Colors.blue.shade100,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.local_offer),
            label: 'Ofertas',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_offer),
            label: 'Ofertas',
          )
        ]);
  }
}
