import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/produto_model.dart';
import '../../screens/produtos/detalhe_produto.dart';

class ProdutoItem extends StatelessWidget {
  final List<ProdutoModel>? produtos;
  final double fontSize;

  const ProdutoItem(
      {super.key, required this.produtos, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos!.length,
      itemBuilder: (context, index) {
        ProdutoModel produto = produtos![index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalheProduto(produto: produto),
              ),
            );
          },
          child: Card(
            color: Colors.white70,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Expanded(
                        child: Image.asset(
                      "assets/icons/logo_peres.png",
                      fit: BoxFit.fill,
                    )),
                    title: Text(
                      produto.descricao.toUpperCase(),
                      style: TextStyle(
                        fontSize: fontSize * 1.1,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produto.descricaoResumida.toUpperCase(),
                          style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Min. ${produto.qtdVendaMin} | Mult. ${produto.qtdVendaMult} UN",
                          style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Estoque: ${produto.estoque} ${produto.fatorEstoque}",
                          style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("Preço Base - ${produto.fatorEstoque}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  NumberFormat.simpleCurrency(locale: 'pt_BR')
                                      .format(produto.valor),
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Row(
                              children: [
                                Text("% Desc."),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  produto.percentDesc
                                      .toStringAsFixed(2)
                                      .replaceAll(".", ","),
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text("Valor Liq. - ${produto.fatorEstoque}"),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  NumberFormat.simpleCurrency(locale: 'pt_BR')
                                      .format(produto.valor -
                                          (produto.valor *
                                              produto.percentDesc)),
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
