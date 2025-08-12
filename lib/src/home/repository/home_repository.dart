import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_bloc_app/src/home/models/photo_model.dart';

class HomeRepository {
  final http.Client _client;
  HomeRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Photo>> fetchPhotos() async {
    final response = await _client
        .get(Uri.parse('https://picsum.photos/v2/list?page=1&limit=10'));

    if (response.statusCode == 200) {
      final List<dynamic> photoJson = json.decode(response.body);
      return photoJson.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}