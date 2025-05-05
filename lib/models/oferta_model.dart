import 'package:peres_app/models/requisito_promocao.dart';

class OfertaModel {
  final int id;
  final int seqKit;
  final String descricao;
  final DateTime validadeDe;
  final DateTime validadeAte;
  final bool ativo;
  final bool envioPalmTop;
  final List<RequisitoPromocao> requisitos;

  OfertaModel(
      {required this.id,
      required this.seqKit,
      required this.descricao,
      required this.validadeDe,
      required this.validadeAte,
      required this.ativo,
      required this.envioPalmTop,
      required this.requisitos
      });

  factory OfertaModel.fromJson(Map<String, dynamic> json) {
    return OfertaModel(
        id: json['id'],
        seqKit: json['seqKit'],
        descricao: json['descricao'],
        validadeDe: DateTime.parse(json['validadeDe']),
        validadeAte: DateTime.parse(json['validadeAte']),
        ativo: json['ativo'] == 1,
        envioPalmTop: json['envioPalmTop'] == true,
        requisitos: (json['requisitos'] as List)
            .map((e) => RequisitoPromocao.fromJson(e))
            .toList()
    );
  }
}
