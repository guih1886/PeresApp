import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peres_app/components/produtos/produto_item.dart';
import 'package:peres_app/components/shared/custom_input.dart';
import 'package:peres_app/models/oferta_model.dart';
import 'package:peres_app/services/produto_service.dart';

import '../../components/ofertas/oferta_filtro.dart';
import '../../models/produto_model.dart';

class DetalheOfertaScreen extends StatefulWidget {
  final double fontSize;
  final OfertaModel oferta;

  final int empresaId;

  const DetalheOfertaScreen(
      {super.key,
      required this.oferta,
      required this.empresaId,
      required this.fontSize});

  @override
  State<DetalheOfertaScreen> createState() => _DetalheOfertaScreenState();
}

class _DetalheOfertaScreenState extends State<DetalheOfertaScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ProdutoService _produtoService = ProdutoService();
  late List<ProdutoModel> produtos = [];
  late List<ProdutoModel> produtosVisiveis = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    try {
      List<ProdutoModel> produtos = await _produtoService
          .carregarProdutosByIdOferta(widget.oferta.seqKit, widget.empresaId);

      setState(() {
        produtos.sort((a, b) => a.descricao.compareTo(b.descricao));
        this.produtos = produtos;
        produtosVisiveis = produtos;
      });
    } on TimeoutException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          duration: const Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    } on HttpException catch (e) {
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

  void filtraProdutos(String filtro) {
    setState(() {
      if (filtro.isEmpty) {
        produtosVisiveis = List.from(produtos);
      } else {
        final f = filtro.toUpperCase();
        produtosVisiveis = produtos
            .where((p) =>
                p.descricao.contains(f) || p.descricaoResumida.contains(f))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
                  iconTheme: const IconThemeData(color: Colors.white, size: 35),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(75),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextField(
                            focusNode: _focusNode,
                            onChanged: (value) {
                              filtraProdutos(_inputController.text);
                            },
                            controller: _inputController,
                            decoration: InputDecoration(
                              hintText:
                                  'Buscar por descrição ou descr. resumida',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: _inputController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          _inputController.clear();
                                          filtraProdutos('');
                                          _focusNode.unfocus();
                                        });
                                      },
                                    )
                                  : null,
                            ))),
                  )),
              body: (produtos.isEmpty)
                  ? const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.white))
                  : ProdutoItem(
                      produtos: produtosVisiveis, fontSize: widget.fontSize))),
    );
  }
}
