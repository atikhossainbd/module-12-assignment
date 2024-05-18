import 'dart:convert';
import 'package:http/http.dart' as http;

class ModelGallery {
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  ModelGallery({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory ModelGallery.fromJson(Map<String, dynamic> json) {
    return ModelGallery(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class GalleryApi{
  static Future<List<ModelGallery>> fetchUsers() async {
    const url = 'https://jsonplaceholder.typicode.com/photos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    final body = response.body;
    final json = jsonDecode(body);
    final result = json as List<dynamic>;

    final resultTransformed = result.map((e){
      return ModelGallery.fromJson(e);
    }).toList();

    return resultTransformed;
  }
}
