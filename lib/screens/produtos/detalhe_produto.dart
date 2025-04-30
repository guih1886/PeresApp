import 'package:flutter/material.dart';
import 'package:peres_app/models/produto_model.dart';

class DetalheProduto extends StatelessWidget {
  final ProdutoModel produto;

  const DetalheProduto({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return Text("Produto: ${produto.descricao}");
  }
}
