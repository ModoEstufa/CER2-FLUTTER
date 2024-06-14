import 'package:flutter/material.dart';
import 'package:aplicacion_esports/services/http_service.dart';
import 'pantalla_jugadores.dart'; // Importar pantalla de jugadores

class EquiposScreen extends StatefulWidget {
  final int campeonatoId;

  EquiposScreen({required this.campeonatoId});

  @override
  _EquiposScreenState createState() => _EquiposScreenState();
}

class _EquiposScreenState extends State<EquiposScreen> {
  HttpService httpService = HttpService();
  List<dynamic> equipos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarEquipos();
  }

  void _cargarEquipos() async {
    try {
      List<dynamic> response = await httpService.obtenerEquiposPorCampeonato(widget.campeonatoId);
      setState(() {
        equipos = response;
        isLoading = false;
      });
    } catch (e) {
      print('Error al obtener equipos por campeonato: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos del Campeonato'),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange.shade200, Colors.orange.shade400],
                ),
              ),
              child: ListView.builder(
                itemCount: equipos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleEquipoScreen(
                            equipoId: equipos[index]['id'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.orange.shade100, Colors.orange.shade200],
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          title: Text(
                            equipos[index]['nombre'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Text(
                            equipos[index]['juegos'],
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}