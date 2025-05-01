class ProdutoModel {
  final int id;
  final int codigoProduto;
  final String descricao;
  final String descricaoResumida;
  final double valor;
  final String imagem;
  final double estoque;
  final double qtdVendaMin;
  final double qtdVendaMult;
  final String fatorEstoque;

  final double percentDesc;

  ProdutoModel({
    required this.id,
    required this.codigoProduto,
    required this.descricao,
    required this.descricaoResumida,
    required this.valor,
    required this.imagem,
    required this.estoque,
    required this.qtdVendaMin,
    required this.qtdVendaMult,
    required this.fatorEstoque,
    required this.percentDesc,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    var precoFixo = json['precoFixo'];
    var percentual = json['percentualDesconto'];

    double vendaMin = double.parse(json['qtdeMinVenda'].toString());
    double vendaMult = double.parse(json['qtdeMultVenda'].toString());
    double estoque = double.parse(json['qtdeEmEstoque'].toString());

    return ProdutoModel(
        id: json['id'],
        codigoProduto: json['codigoProduto'],
        descricao: json['descricao'],
        descricaoResumida: json['descricaoResumida'],
        valor: precoFixo > 0 ? precoFixo : 0,
        imagem: json['urlImagem'],
        estoque: estoque,
        qtdVendaMin: vendaMin,
        qtdVendaMult: vendaMult,
        fatorEstoque: json['fatorEstoque'],
        percentDesc: precoFixo > 0 ? 0 : percentual
    );
  }
}
