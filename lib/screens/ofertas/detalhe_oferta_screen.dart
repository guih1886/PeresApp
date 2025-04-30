import 'package:flutter/material.dart';
import 'package:peres_app/components/produtos/produto_item.dart';
import 'package:peres_app/models/oferta_model.dart';
import 'package:peres_app/services/produto_service.dart';

import '../../models/produto_model.dart';

class DetalheOfertaScreen extends StatefulWidget {
  final double fontSize;
  final OfertaModel oferta;

  const DetalheOfertaScreen(
      {super.key, required this.oferta, required this.fontSize});

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
    List<ProdutoModel>? produtos =
        await _produtoService.carregarProdutosByIdOferta(widget.oferta.seqKit);

    setState(() {
      if (produtos != null) {
        produtos.sort((a, b) => a.descricao.compareTo(b.descricao));
        this.produtos = produtos;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
          child: Scaffold(
              appBar: AppBar(
                title: Text(widget.oferta.descricao,
                    style: const TextStyle(color: Colors.white)),
                backgroundColor: const Color(0xFF203A43),
                iconTheme: const IconThemeData(color: Colors.white, size: 35)
              ),
              body: (produtos == null || produtos!.isEmpty)
                  ? const Center(child: CircularProgressIndicator())
                  : ProdutoItem(
                      produtos: produtos, fontSize: widget.fontSize))),
    );
  }
}
