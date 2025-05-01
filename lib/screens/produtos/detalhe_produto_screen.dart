import 'package:flutter/material.dart';

import '../../components/produtos/full_screen.dart';
import '../../models/produto_model.dart';

class DetalheProdutoScreen extends StatefulWidget {
  final double fontSize;
  final ProdutoModel produto;

  DetalheProdutoScreen(
      {super.key, required this.produto, required this.fontSize});

  @override
  State<DetalheProdutoScreen> createState() => _DetalheProdutoScreenState();
}

class _DetalheProdutoScreenState extends State<DetalheProdutoScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          title: const Text("Detalhes do Produto",
              style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF203A43),
          iconTheme: const IconThemeData(color: Colors.white, size: 35)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImagePage(imageUrl: widget.produto.imagem),
                  ),
                );
              },
                child: SizedBox(
                  width: width * 0.8,
                  height: height * 0.3,
                  child: Stack(
                    children: [
                      // Imagem
                      Image.network(
                        widget.produto.imagem,
                        fit: BoxFit.fill,
                        width: width * 0.8,
                        height: height * 0.3,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/sem_imagem.jpg',
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                      // Ícone de lupa sobreposto
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: Icon(
                          Icons.zoom_in,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )

            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.produto.descricao,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: widget.fontSize * 1.1)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _singleItem("CÓDIGO", widget.produto.codigoProduto.toString(), width: width * 0.25),
                _singleItem("DESC. RESUMIDA", widget.produto.descricaoResumida, width: width * 0.65)
              ],
            ),
            _singleItem("SEÇÃO", ""),
            _singleItem("CATEGORIA", ""),

            _sectionTitle("Códigos de Barras"),
            _barcodeRow("UN", "EAN13", "7896527700058"),
            _barcodeRow("CX", "DUN14", "47896527700056"),
            _barcodeRow("DP", "DUN14", "17896527700055"),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    );
  }

  Widget _barcodeRow(String pac, String type, String code) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              initialValue: pac,
              decoration: InputDecoration(labelText: "Pac", isDense: true),
            )),
            SizedBox(width: 10),
            Expanded(
                child: TextFormField(
              enabled: false,
              initialValue: type,
              decoration: InputDecoration(
                  labelText: "Type",
                  isDense: true,
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            )),
            SizedBox(width: 10),
            Expanded(
                child: TextFormField(
              initialValue: code,
              decoration: InputDecoration(labelText: "Bar Code", isDense: true),
            )),
          ],
        ),
      ),
    );
  }

  Widget _singleItem(String label, String text, {double? width}) {
    final content = Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        readOnly: true,
        initialValue: text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          labelStyle: const TextStyle(
              color: Colors.indigoAccent, fontWeight: FontWeight.bold),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );

    final card = Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: content,
    );

    return width != null ? SizedBox(width: width, child: card) : card;
  }


}
