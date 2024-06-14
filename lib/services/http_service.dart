import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = 'http://192.168.1.90:8000/api';

  Future<List<dynamic>> partidos() async {
    return listarDatos('partidos');
  }

  Future<List<dynamic>> equipos() async {
    return listarDatos('equipos');
  }

  Future<List<dynamic>> jugadores() async {
    return listarDatos('jugadores');
  }

  Future<List<dynamic>> campeonatos() async {
    return listarDatos('campeonatos');
  }

Future<List<dynamic>> obtenerEquiposPorCampeonato(int campeonatoId) async {
  var url = Uri.parse('$apiUrl/campeonatos/$campeonatoId/equipos');
  print('URL solicitada: $url'); // Añade este print para depurar la URL
  
  var respuesta = await http.get(url);

  if (respuesta.statusCode == 200) {
    return json.decode(respuesta.body);
  } else {
    print('Error al obtener equipos por campeonato: ${respuesta.statusCode}');
    throw Exception('Failed to load equipos');
  }
}


  Future<List<dynamic>> obtenerJugadoresPorEquipo(int equipoId) async {
    var url = Uri.parse('$apiUrl/jugadores?equipo_id=$equipoId');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      print('Error al obtener jugadores por equipo: ${respuesta.statusCode}');
      throw Exception('Failed to load jugadores');
    }
  }


Future<List<dynamic>> listarDatos(String coleccion) async {
    var respuesta = await http.get(Uri.parse(apiUrl + '/' + coleccion));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    print(respuesta.statusCode);
    return [];
  }

 Future<Map<String, dynamic>?> obtenerDetalle(String coleccion, String id) async {
    var respuesta = await http.get(Uri.parse('$apiUrl/$coleccion/$id'));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    print('Error ${respuesta.statusCode}: ${respuesta.body}');
    return null;
  }


void actualizarPartido(String id, String equipoLocal, String equipoVisitante, String fecha, String lugar) async {
  final url = '$apiUrl/$id'; 
  final response = await http.put(
    Uri.parse(url),
    body: {
      'equipoLocal': equipoLocal,
      'equipoVisitante': equipoVisitante,
      'fecha': fecha,
      'lugar': lugar,
    },
  );

  if (response.statusCode == 200) {
    print('Partido actualizado exitosamente');
  } else {
    print('Error al actualizar el partido: ${response.statusCode}');
  }
}
}


