import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pi_desenv_mobile/tools/UrlTool.dart';

import '../models/oferta_model.dart';

class OfertaService {
  Future<List<OfertaModel>?> carregarOfertas() async {
    try {
      List<OfertaModel>? listaOfertas;
      final promocoesUrl = await getUrlFromConfigFile("promocoesSP");

      var url = Uri.parse(promocoesUrl);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var dados = jsonDecode(response.body);
        listaOfertas = (dados['data'] as List)
             .map((json) => OfertaModel.fromJson(json))
             .toList();
      } else {
        return null;
      }

      return listaOfertas;
    } catch (e) {
      return null;
    }
  }
}
