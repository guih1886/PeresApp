import 'package:flutter/material.dart';

import '../../components/produtos/full_screen.dart';
import '../../components/shared/custom_input.dart';
import '../../models/produto_model.dart';

class DetalheProdutoScreen extends StatefulWidget {
  final double fontSize;
  final ProdutoModel produto;

  DetalheProdutoScreen(
      {super.key, required this.produto, required this.fontSize});

  @override
  State<DetalheProdutoScreen> createState() => _DetalheProdutoScreenState();
}

class _DetalheProdutoScreenState extends State<DetalheProdutoScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Necessário para o IndexedStack responder à mudança
    });
    super.initState();
  }

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
        iconTheme: const IconThemeData(color: Colors.white, size: 35),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        FullScreenImagePage(imageUrl: widget.produto.imagem),
                  ),
                );
              },
              child: SizedBox(
                width: width * 0.8,
                height: height * 0.3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.produto.descricao,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.fontSize * 1.1,
                ),
              ),
            ),
            Container(
              color: Colors.white70,
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.black26,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 5,
                labelStyle: TextStyle(
                  fontSize: widget.fontSize * 1.1,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: widget.fontSize * 1.1,
                  fontWeight: FontWeight.bold,
                ),
                tabs: const [
                  Tab(text: "Dados"),
                  Tab(text: "Códigos de Barras"),
                ],
              ),
            ),
            IndexedStack(
              index: _tabController.index,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomInput(
                            label: "CÓDIGO",
                            text: widget.produto.codigoProduto.toString(),
                            width: width * 0.25,
                          ),
                          CustomInput(
                            label: "DESC. RESUMIDA",
                            text: widget.produto.descricaoResumida,
                            width: width * 0.65,
                          ),
                        ],
                      ),
                      CustomInput(label: "SEÇÃO", text: widget.produto.secao, width: width),
                      CustomInput(label: "CATEGORIA", text: widget.produto.categoria, width: width),
                      CustomInput(label: "FABRICANTE", text: widget.produto.fabricante, width: width),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomInput(
                            label: "PESO BRT. (g)",
                            text: widget.produto.pesoBrt,
                            width: width * 0.45,
                          ),
                          CustomInput(
                            label: "PESO LIQ. (g)",
                            text: widget.produto.pesoLiq,
                            width: width * 0.45,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomInput(
                              label: "UNID. COMPRA",
                              text: widget.produto.unidCompra,
                              width: width * 0.45),
                          CustomInput(
                              label: "NCM", text: widget.produto.ncm, width: width * 0.45),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: widget.produto.codigosBarras
                        .map((codigoBarra) => _barcodeRow(
                      codigoBarra.unidadeVenda,
                      codigoBarra.tipoCodigoBarra,
                      codigoBarra.codigoBarra ?? '',
                      width,
                    ))
                        .toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _barcodeRow(String fator, String tipo, String codigo, double width) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(
                width: width * 0.15,
                child: TextFormField(
              enabled: false,
              initialValue: fator,
                  style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  labelText: "Fator",
                  isDense: true,
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            )),
            const SizedBox(width: 10),
            SizedBox(
                width: width * 0.2,
                child: TextFormField(
              enabled: false,
              initialValue: tipo,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  labelText: "Tipo",
                  isDense: true,
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            )),
            const SizedBox(width: 10),
            Expanded(
                child: TextFormField(
              enabled: false,
              initialValue: codigo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  labelText: "Código Barra",
                  isDense: true,
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            )),
          ],
        ),
      ),
    );
  }
}
