import 'package:flutter/material.dart';
import 'package:peres_app/components/ofertas/oferta_item.dart';
import 'package:peres_app/services/oferta_service.dart';

import '../../models/oferta_model.dart';

class OfertaScreen extends StatefulWidget {
  final double fontSize;

  const OfertaScreen({super.key, required this.fontSize});

  @override
  State<OfertaScreen> createState() => _OfertaScreenState();
}

class _OfertaScreenState extends State<OfertaScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final OfertaService ofertaService = OfertaService();
  List<OfertaModel>? ofertasSp;
  List<OfertaModel>? ofertasMg;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      List<OfertaModel>? listaSp =
          await ofertaService.carregarOfertas("promocoesSP");

      List<OfertaModel>? listaMg =
          await ofertaService.carregarOfertas("promocoesMG");

      setState(() {
        if (listaSp != null && listaMg != null) {
          ofertasSp = listaSp;
          ofertasMg = listaMg;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao carregar as ofertas. Tente novamente.'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text(
            'Ofertas',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF203A43),
          iconTheme: const IconThemeData(color: Colors.white, size: 35),
          bottom: TabBar(
            unselectedLabelColor: Colors.white24,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5,
            labelStyle: TextStyle(
                fontSize: widget.fontSize * 1.1, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(
                fontSize: widget.fontSize * 1.1, fontWeight: FontWeight.bold),
            tabs: const <Widget>[
              Tab(
                text: "Peres SP",
              ),
              Tab(
                text: "Peres MG",
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ofertasSp == null
                ? const Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white))
                : ListView.builder(
                    itemCount: ofertasSp!.length,
                    itemBuilder: (context, index) {
                      var oferta = ofertasSp![index];
                      return OfertaItem(
                        oferta: oferta,
                        fontSize: widget.fontSize,
                        empresaId: 1,
                      );
                    },
                  ),
            ofertasMg == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: ofertasMg!.length,
                    itemBuilder: (context, index) {
                      var oferta = ofertasMg![index];
                      return OfertaItem(
                        oferta: oferta,
                        fontSize: widget.fontSize,
                        empresaId: 2,
                      );
                    },
                  )
          ],
        ));
  }
}
