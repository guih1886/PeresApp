class RequisitoPromocao {
  final int id;
  final int requisitoPromId;
  final RequisitoPromocaoItem requisitoPromocao;
  final int seqKit;
  final double valorRequisito;
  final int? valorRequisitoMax;

  RequisitoPromocao({
    required this.id,
    required this.requisitoPromId,
    required this.requisitoPromocao,
    required this.seqKit,
    required this.valorRequisito,
    required this.valorRequisitoMax,
  });

  factory RequisitoPromocao.fromJson(Map<String, dynamic> json) {
    return RequisitoPromocao(
        id: json['id'],
        requisitoPromId: json['requisitoPromId'],
        requisitoPromocao:
            RequisitoPromocaoItem.fromJson(json['requisitoPromocao']),
        seqKit: json['seqKit'],
        valorRequisito: json['valorRequisito'],
        valorRequisitoMax: json['valorRequisitoMax']);
  }
}

class RequisitoPromocaoItem {
  final int id;
  final String descricao;

  RequisitoPromocaoItem({
    required this.id,
    required this.descricao,
  });

  factory RequisitoPromocaoItem.fromJson(Map<String, dynamic> json) {
    return RequisitoPromocaoItem(id: json['id'], descricao: json['descricao']);
  }
}
