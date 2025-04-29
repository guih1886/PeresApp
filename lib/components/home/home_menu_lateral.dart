import 'package:flutter/material.dart';

class HomeMenuLateral extends StatelessWidget {
  final double fontSize;

  const HomeMenuLateral({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0F2027),
                          Color(0xFF203A43),
                          Color(0xFF2C5364)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Peres e Peres App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize * 1.4,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_offer),
                    title:
                        Text('Ofertas', style: TextStyle(fontSize: fontSize)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/ofertas");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title:
                        Text('Produtos', style: TextStyle(fontSize: fontSize)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/produtos");
                    },
                  ),
                  Divider(
                    height: height * 0.03,
                    thickness: 3,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: const Icon(Icons.perm_contact_cal_rounded),
                    title: Text('Sobre a empresa',
                        style: TextStyle(fontSize: fontSize)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/sobre");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text('Verificar Disponibilidade',
                        style: TextStyle(fontSize: fontSize)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/disponibilidade");
                    },
                  ),
                  Divider(
                    height: height * 0.03,
                    thickness: 3,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text('Contato Empresa',
                        style: TextStyle(fontSize: fontSize)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/contato");
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.blue),
              title: const Text('Suporte'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/suporte");
              },
            )
          ],
        ),
      ),
    );
  }
}
