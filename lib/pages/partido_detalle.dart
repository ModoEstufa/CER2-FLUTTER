import 'package:aplicacion_esports/services/http_service.dart';
import 'package:flutter/material.dart';

class PartidoDetalle extends StatefulWidget {
  final String id;
  final String fecha;
  final String lugar;
  final String equipoLocal;
  final String equipoVisitante;

  PartidoDetalle(
      {required this.id,
      required this.fecha,
      required this.lugar,
      required this.equipoLocal,
      required this.equipoVisitante});

  @override
  State<PartidoDetalle> createState() => _PartidoDetalleState();
}

class _PartidoDetalleState extends State<PartidoDetalle> {
  late TextEditingController equipoLocalController;
  late TextEditingController equipoVisitanteController;
  late TextEditingController fechaController;
  late TextEditingController lugarController;

  @override
  void initState() {
    super.initState();
    equipoLocalController = TextEditingController(text: widget.equipoLocal);
    equipoVisitanteController =
        TextEditingController(text: widget.equipoVisitante);
    fechaController = TextEditingController(text: widget.fecha);
    lugarController = TextEditingController(text: widget.lugar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Partido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: equipoLocalController,
              decoration: InputDecoration(labelText: 'Equipo Local'),
            ),
            TextField(
              controller: equipoVisitanteController,
              decoration: InputDecoration(labelText: 'Equipo Visitante'),
            ),
            TextField(
              controller: fechaController,
              decoration: InputDecoration(labelText: 'Fecha'),
            ),
            TextField(
              controller: lugarController,
              decoration: InputDecoration(labelText: 'Lugar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                HttpService().actualizarPartido(
                  widget.id,
                  equipoLocalController.text,
                  equipoVisitanteController.text,
                  fechaController.text,
                  lugarController.text);
              },
              child: Text('Guardar Cambios'),
            ),

            

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Eliminar Partido'),
                    content: Text('¿Estás seguro de eliminar este partido?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Eliminar'),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          //await eliminarPartido(id);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Text('Eliminar'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    equipoLocalController.dispose();
    equipoVisitanteController.dispose();
    fechaController.dispose();
    lugarController.dispose();
    super.dispose();
  }
}
