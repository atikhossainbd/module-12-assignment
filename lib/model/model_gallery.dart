import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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

class GalleryApi {
  static Future<List<ModelGallery>> fetchUsers() async {
    const url = 'https://jsonplaceholder.typicode.com/photos';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        print(
            'Failed to fetch gallery data. Status code: ${response.statusCode}');
      }

      final body = response.body;
      final json = jsonDecode(body);
      final result = json as List<dynamic>;
      final resultTransformed =
          result.map((e) => ModelGallery.fromJson(e)).toList();
      return resultTransformed;
    } catch (e) {
      print('Failed to fetch gallery data. Status code: ${e.toString()}');
      return [];
    }
  }
}
