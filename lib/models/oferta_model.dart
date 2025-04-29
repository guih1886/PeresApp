class OfertaModel {
  final int id;
  final int seqKit;
  final String descricao;
  final DateTime validadeDe;
  final DateTime validadeAte;
  final bool ativo;
  final bool envioPalmTop;
  final bool isRequisito;

  OfertaModel(
      {required this.id,
      required this.seqKit,
      required this.descricao,
      required this.validadeDe,
      required this.validadeAte,
      required this.ativo,
      required this.envioPalmTop,
      required this.isRequisito
      });

  factory OfertaModel.fromJson(Map<String, dynamic> json) {
    return OfertaModel(
        id: json['id'],
        seqKit: json['seqKit'],
        descricao: json['descricao'],
        validadeDe: DateTime.parse(json['validadeDe']),
        validadeAte: DateTime.parse(json['validadeAte']),
        ativo: json['ativo'] == 1,
        envioPalmTop: json['envioPalmTop'] == 1,
        isRequisito: json['isRequisito'] == 1,
    );
  }
}
