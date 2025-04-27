import 'package:flutter/material.dart';
import 'package:pi_desenv_mobile/services/oferta_service.dart';
import 'package:intl/intl.dart';

import '../models/oferta_model.dart';
import 'detalhe_oferta_screen.dart';

class OfertaScreen extends StatefulWidget {
  const OfertaScreen({super.key});

  @override
  State<OfertaScreen> createState() => _OfertaScreenState();
}

class _OfertaScreenState extends State<OfertaScreen> {
  final OfertaService ofertaService = OfertaService();
  List<OfertaModel> ofertas = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    List<OfertaModel>? lista = await ofertaService.carregarOfertas();
    setState(() {
      if (lista != null) {
        ofertas = lista;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofertas'),
        backgroundColor: const Color.fromRGBO(255, 200, 255, 0.5),
      ),
      body: ofertas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ofertas.length,
              itemBuilder: (context, index) {
                var oferta = ofertas[index];
                var dataFimFormatada =
                    DateFormat("dd/MM/yyyy HH:mm").format(oferta.validadeAte);
                return Card(
                  color: Colors.white70,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    leading: const Icon(Icons.local_offer, color: Colors.blue),
                    title: Text(oferta.descricao,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "Válido até $dataFimFormatada",
                      style: const TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetalheOfertaScreen(oferta: oferta),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
