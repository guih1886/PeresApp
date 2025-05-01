import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peres_app/tools/UrlTool.dart';

import '../models/oferta_model.dart';

class OfertaService {
  Future<List<OfertaModel>?> carregarOfertas(String configUrl) async {
    try {
      List<OfertaModel>? listaOfertas;
      final promocoesUrl = await getUrlFromConfigFile(configUrl);

      var url = Uri.parse(promocoesUrl);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var dados = jsonDecode(response.body);
        listaOfertas = (dados['data'] as List)
            .map((json) => OfertaModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            "Ocorreu um problema ao carregar as ofertas. Tente novamente.");
      }

      return listaOfertas;
    } catch (e) {
      throw Exception(
          "Ocorreu um problema ao carregar as ofertas. Tente novamente.");
    }
  }
}
