/* import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apod_model.dart';

class NasaService {
  // Use 'DEMO_KEY' para testes ou crie sua chave em api.nasa.gov
  final String apiKey = 'DEMO_KEY';
  final String baseUrl = 'https://api.nasa.gov/planetary/apod';

  Future<ApodModel> getApod({String? date}) async {

    String url = '$baseUrl?api_key=$apiKey';
    if (date != null) {
      url += '&date=$date';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return ApodModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erro ao carregar imagem: ${response.statusCode}');
    }
  }
}
*/
