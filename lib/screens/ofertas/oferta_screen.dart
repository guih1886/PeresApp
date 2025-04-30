import 'package:flutter/material.dart';
import 'package:peres_app/components/ofertas/oferta_item.dart';
import 'package:peres_app/services/oferta_service.dart';

import '../../models/oferta_model.dart';

class OfertaScreen extends StatefulWidget {
  final double fontSize;

  const OfertaScreen({super.key, required this.fontSize});

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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro ao carregar as ofertas. Tente novamente.'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ofertas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF203A43),
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
      ),
      body: ofertas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ofertas.length,
              itemBuilder: (context, index) {
                var oferta = ofertas[index];

                return OfertaItem(oferta: oferta, fontSize: widget.fontSize);
              },
            ),
    );
  }
}
