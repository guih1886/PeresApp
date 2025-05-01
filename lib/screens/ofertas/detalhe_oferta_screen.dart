import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peres_app/components/produtos/produto_item.dart';
import 'package:peres_app/models/oferta_model.dart';
import 'package:peres_app/services/produto_service.dart';

import '../../models/produto_model.dart';

class DetalheOfertaScreen extends StatefulWidget {
  final double fontSize;
  final OfertaModel oferta;

  final int empresaId;

  const DetalheOfertaScreen(
      {super.key, required this.oferta, required this.empresaId, required this.fontSize});

  @override
  State<DetalheOfertaScreen> createState() => _DetalheOfertaScreenState();
}

class _DetalheOfertaScreenState extends State<DetalheOfertaScreen> {
  final ProdutoService _produtoService = ProdutoService();
  late List<ProdutoModel> produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    try {
      List<ProdutoModel> produtos = await _produtoService
          .carregarProdutosByIdOferta(widget.oferta.seqKit, widget.empresaId);

      setState(() {
        produtos.sort((a, b) => a.descricao.compareTo(b.descricao));
        this.produtos = produtos;
      });

    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    } on HttpException catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      print("Erro inesperado: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
          child: Scaffold(
              backgroundColor: Colors.grey,
              appBar: AppBar(
                  title: Text(widget.oferta.descricao,
                      style: const TextStyle(color: Colors.white)),
                  backgroundColor: const Color(0xFF203A43),
                  iconTheme:
                      const IconThemeData(color: Colors.white, size: 35)),
              body: (produtos == null || produtos!.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.white))
                  : ProdutoItem(
                      produtos: produtos, fontSize: widget.fontSize))),
    );
  }
}
