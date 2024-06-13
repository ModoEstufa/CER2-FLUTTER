import 'package:aplicacion_esports/pages/partido_detalle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PartidosTile extends StatefulWidget {
  final String id;
  final String equipoLocal;
  final String equipoVisitante;
  final String fecha;
  final String lugar;

  PartidosTile({
    required this.id,
    required this.equipoLocal,
    required this.equipoVisitante,
    required this.fecha,
    required this.lugar,
  });

  @override
  State<PartidosTile> createState() => _PartidosTileState();
}

class _PartidosTileState extends State<PartidosTile> {
  String _extractHour(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('HH:mm').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    String hora = _extractHour(widget.fecha);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PartidoDetalle(id: widget.id,fecha: widget.fecha, lugar: widget.lugar, equipoLocal: widget.equipoLocal, equipoVisitante: widget.equipoVisitante,)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Color.fromARGB(255, 17, 26, 31), borderRadius: BorderRadius.all(Radius.circular(8)),),
              padding: const EdgeInsets.only(
                  left: 80,
                  right: 30
                  ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hora,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    widget.lugar,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/partidos.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.equipoLocal.split(' ')[0],
                        style: GoogleFonts.oxanium(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        widget.equipoLocal.split(' ')[1],
                        style: GoogleFonts.oxanium(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        widget.equipoVisitante.split(' ')[0],
                        style: GoogleFonts.oxanium(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text(
                        widget.equipoVisitante.split(' ')[1],
                        style: GoogleFonts.oxanium(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}
