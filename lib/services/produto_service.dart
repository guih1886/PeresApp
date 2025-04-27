import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pi_desenv_mobile/models/produto_model.dart';
import 'package:pi_desenv_mobile/tools/UrlTool.dart';

class ProdutoService {
  Future<List<ProdutoModel>?> carregarProdutosByIdOferta(int id) async {
    try {
      List<ProdutoModel>? listaProdutos;
      var promocaoProdutoUrl = await getUrlFromConfigFile("promocaoProduto");
      promocaoProdutoUrl = promocaoProdutoUrl.replaceAll("{seqKit}", id.toString());

      Uri uri = Uri.parse(promocaoProdutoUrl);

      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var dados = jsonDecode(response.body);
        listaProdutos = (dados['data'] as List)
            .map((json) => ProdutoModel.fromJson(json))
            .toList();
      } else {
        return null;
      }

      return listaProdutos;
    } catch (e) {
      return null;
    }
  }
}
