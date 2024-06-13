import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> partidos() async {
    return listarDatos('partidos');
  }

Future<List<dynamic>> listarDatos(String coleccion) async {
    var respuesta = await http.get(Uri.parse(apiUrl + '/' + coleccion));

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    }
    print(respuesta.statusCode);
    return [];
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

