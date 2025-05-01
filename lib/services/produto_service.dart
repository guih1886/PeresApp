import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:peres_app/models/produto_model.dart';
import 'package:peres_app/tools/UrlTool.dart';

class ProdutoService {
  Future<List<ProdutoModel>> carregarProdutosByIdOferta(
      int id, int empresaId) async {
    List<ProdutoModel>? listaProdutos;
    var promocaoProdutoUrl = await getUrlFromConfigFile("promocaoProduto");

    promocaoProdutoUrl =
        promocaoProdutoUrl.replaceAll("{SeqKit}", id.toString());

    promocaoProdutoUrl =
        promocaoProdutoUrl.replaceAll("{EmpresaId}", empresaId.toString());

    Uri uri = Uri.parse(promocaoProdutoUrl);

    var response = await http.get(uri).timeout(
      const Duration(seconds: 120),
      onTimeout: () {
        throw TimeoutException(
            "Ocorreu um problema ao carregar os produtos. Verique a internet e tente novamente.");
      },
    );

    if (response.statusCode == 200) {
      var dados = jsonDecode(response.body);
      listaProdutos = (dados['data'] as List)
          .map((json) => ProdutoModel.fromJson(json))
          .toList();
    } else {
      throw const HttpException("Erro ao carregar os produtos.");
    }
    return listaProdutos;
  }
}
