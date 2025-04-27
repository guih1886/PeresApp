import 'package:flutter/material.dart';
import 'package:pi_desenv_mobile/models/oferta_model.dart';
import 'package:intl/intl.dart';
import 'package:pi_desenv_mobile/services/produto_service.dart';

import '../models/produto_model.dart';

class DetalheOfertaScreen extends StatefulWidget {
  final OfertaModel oferta;

  const DetalheOfertaScreen({super.key, required this.oferta});

  @override
  State<DetalheOfertaScreen> createState() => _DetalheOfertaScreenState();
}

class _DetalheOfertaScreenState extends State<DetalheOfertaScreen> {
  final ProdutoService _produtoService = ProdutoService();
  late List<ProdutoModel>? produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    List<ProdutoModel>? produtos = await _produtoService
        .carregarProdutosByIdOferta(widget.oferta.seqKit);

    setState(() {
      if (produtos != null) {
        produtos.sort((a, b) => a.descricao.compareTo(b.descricao));
        this.produtos = produtos;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery
        .of(context)
        .textScaler
        .scale(16);

    return SafeArea(
      child: Expanded(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.oferta.descricao),
            backgroundColor: const Color.fromRGBO(255, 200, 255, 0.5),
          ),
          body: (produtos == null || produtos!.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: produtos!.length,
            itemBuilder: (context, index) {
              ProdutoModel produto = produtos![index];
              return Card(
                color: Colors.white70,
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                elevation: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  produto.descricao,
                                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                                  softWrap: true,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  NumberFormat.simpleCurrency(locale: 'pt_BR').format(produto.valor),
                                  style: TextStyle(fontSize: fontSize),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Estoque: ${produto.estoque}",
                                  style: TextStyle(fontSize: fontSize),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
