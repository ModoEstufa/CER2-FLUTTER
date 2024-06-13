import 'package:aplicacion_esports/services/http_service.dart';
import 'package:aplicacion_esports/widgets/partidos_tile.dart';
import 'package:flutter/material.dart';

class PartidosTab extends StatefulWidget {
  @override
  _PartidosTabState createState() => _PartidosTabState();
}

class _PartidosTabState extends State<PartidosTab> {
  final HttpService httpService = HttpService();
  Map<String, List<Map<String, String>>> partidosPorDia = {};

  @override
  void initState() {
    super.initState();
    fetchPartidos();
  }

  Future<void> fetchPartidos() async {
    try {
      List<dynamic> partidos = await httpService.partidos();
      Map<String, List<Map<String, String>>> groupedPartidos = {};

      for (var partido in partidos) {
        String id = partido['id'].toString();
        String fecha = partido['fecha'].split(' ')[0];
        String equipoLocal = partido['equipo_local']['nombre'];
        String equipoVisitante = partido['equipo_visitante']['nombre'];
        String lugar = partido['lugar'];
        String fechaCompleta = partido['fecha'];

        if (!groupedPartidos.containsKey(fecha)) {
          groupedPartidos[fecha] = [];
        }

        groupedPartidos[fecha]?.add({
          'id': id,
          'equipoLocal': equipoLocal,
          'equipoVisitante': equipoVisitante,
          'fecha': fechaCompleta,
          'lugar': lugar,
        });
      }

      setState(() {
        partidosPorDia = groupedPartidos;
      });
    } catch (e) {
      print('Error fetching partidos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: partidosPorDia.keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Partidos', style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 111, 8, 8),
          bottom: partidosPorDia.isEmpty
              ? null
              : TabBar(
                  
                  isScrollable: true,
                  tabs: partidosPorDia.keys.map((fecha) {
                    return Tab(text: fecha);
                  }).toList(),
                ),
        ),
        body: partidosPorDia.isEmpty
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: partidosPorDia.keys.map((fecha) {
                  List<Map<String, String>> partidos = partidosPorDia[fecha]!;
                  return ListView.builder(
                    itemCount: partidos.length,
                    itemBuilder: (context, index) {
                      final partido = partidos[index];
                      return PartidosTile(
                        id: partido['id']!,
                        equipoLocal: partido['equipoLocal']!,
                        equipoVisitante: partido['equipoVisitante']!,
                        fecha: partido['fecha']!,
                        lugar: partido['lugar']!,
                      );
                    },
                  );
                }).toList(),
              ),
      ),
    );
  }
}

