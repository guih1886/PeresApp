import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peres_app/models/oferta_model.dart';

import '../../screens/ofertas/detalhe_oferta_screen.dart';

class OfertaItem extends StatelessWidget {
  final OfertaModel oferta;
  final double fontSize;

  final int empresaId;

  const OfertaItem(
      {super.key,
      required this.oferta,
      required this.fontSize,
      required this.empresaId});

  @override
  Widget build(BuildContext context) {
    var dataFimFormatada =
        DateFormat("dd/MM/yyyy HH:mm").format(oferta.validadeAte);

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 10,
      child: ListTile(
        leading: const Icon(
          Icons.discount,
          color: Colors.blue,
          size: 35,
        ),
        title: Text(oferta.descricao,
            style: TextStyle(
                color: Colors.indigoAccent,
                fontSize: fontSize * 1.2,
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
                      fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${oferta.seqKit}",
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Validade: ",
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
                Text(
                  dataFimFormatada,
                  style: TextStyle(fontSize: fontSize),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ...oferta.requisitos.map((e) {
                      if(e.valorRequisito > 1){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "REQUISITO - ",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              "${e.requisitoPromocao.descricao}: ",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${e.valorRequisito.toInt()}",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ],
                        );
                      } else  {
                        return const Row();
                      }
                    })
                  ],
                )
              ],
            )
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalheOfertaScreen(
                  oferta: oferta, fontSize: fontSize, empresaId: empresaId),
            ),
          );
        },
      ),
    );
  }
}
