import 'dart:convert';
import 'package:assignment_app/core/models/photo.dart';
import 'package:assignment_app/dependencies_initialization.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Future<List<Photo>> fetchPhotos(String url) async {
//   final client = getIt<http.Client>();
//   final response = await client.get(Uri.parse(url));
// // 'https://jsonplaceholder.typicode.com/photos'
//   if (response.statusCode == 200) {
//     // Use the compute function to run parsePhotos in a separate isolate.
//     final result = await compute(parsePhotos, response.body);
//     return result;
//   } else {
//     throw Exception("Failed to fetch photos");
//   }
// }

Future<List<Photo>> fetchPhotos(String url) async {
  final client = getIt<http.Client>();

  try {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = await compute(parsePhotos, response.body);
      return result;
    } else {
      //for status code other then 200, like 504 (gateway not found) etc..
      return [];
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}
