class CodigosBarraUnidadeProdutoModel {
  final int id;
  final int sequencial;
  final int codigoProduto;
  final String unidadeVenda;
  final String tipoCodigoBarra;
  final String codigoBarra;

  CodigosBarraUnidadeProdutoModel(
      {required this.id,
      required this.sequencial,
      required this.codigoProduto,
      required this.unidadeVenda,
      required this.codigoBarra,
      required this.tipoCodigoBarra});

  factory CodigosBarraUnidadeProdutoModel.fromJson(Map<String, dynamic> json) {
    return CodigosBarraUnidadeProdutoModel(
      id: json["id"],
      sequencial: json["sequencial"],
      codigoProduto: json["codigoProduto"],
      unidadeVenda: json["unidadeVenda"],
      tipoCodigoBarra: json["tipoCodigoBarra"],
      codigoBarra: json["codigoBarra"],
    );
  }
}
