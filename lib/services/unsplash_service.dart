import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/unsplass_foto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UnsplashService {
  final String _baseUrl =dotenv.env['UNSPLASH_URL'] ?? 'https://api.unsplash.com'; 
 final String _clientId = dotenv.env['UNSPLASH_API_KEY'] ?? '2HbS_Y17Yli5rOMrZM23vNaNaML0yOKSR84ru450tMw';


  Future<List<UnsplashPhoto>> searchPhotos({
    required String query,
    int page = 1,
    int perPage = 20,
  }) async {
    final url = Uri.parse('$_baseUrl/search/photos?query=$query&page=$page&per_page=$perPage');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Client-ID $_clientId',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((photo) => UnsplashPhoto.fromMap(photo)).toList();
    } else {
      throw Exception('Error al obtener fotos: ${response.statusCode}');
    }
  }
}
