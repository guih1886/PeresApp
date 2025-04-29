import 'package:flutter/material.dart';
import 'package:pi_desenv_mobile/services/oferta_service.dart';
import 'package:intl/intl.dart';

import '../../models/oferta_model.dart';
import 'detalhe_oferta_screen.dart';

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
                var dataFimFormatada =
                    DateFormat("dd/MM/yyyy HH:mm").format(oferta.validadeAte);
                return Card(
                  color: Colors.white70,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  elevation: 10,
                  child: ListTile(
                    leading: const Icon(
                      Icons.discount,
                      color: Colors.blue,
                      size: 35,
                    ),
                    title: Text(oferta.descricao,
                        style: TextStyle(
                            fontSize: widget.fontSize * 1.2,
                            fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Código: ",
                              style: TextStyle(
                                  fontSize: widget.fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${oferta.seqKit}",
                              style: TextStyle(fontSize: widget.fontSize),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Validade: ",
                              style: TextStyle(
                                  fontSize: widget.fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${dataFimFormatada}",
                              style: TextStyle(fontSize: widget.fontSize),
                            ),
                          ],
                        ),
                        oferta.isRequisito == true ? Text('Com requisito') : Row()
                      ],
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
