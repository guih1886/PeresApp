class ProdutoModel {
  final int id;
  final String descricao;
  final double valor;
  final String imagem;
  final int estoque;

  ProdutoModel({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.imagem,
    required this.estoque,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'],
      descricao: json['descricao'],
      valor: 15.00,
      imagem: "",
      estoque: 123,
    );
  }
}
