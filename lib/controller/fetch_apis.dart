import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SeedlingImage {
  final String imgURL;

  const SeedlingImage({required this.imgURL});

  factory SeedlingImage.fromJson(Map<String, dynamic> json) {
    return SeedlingImage(imgURL: json['url']);
  }
}

class SeedlingContent {
  final String content;

  const SeedlingContent({required this.content});

  factory SeedlingContent.fromJson(Map<String, dynamic> json) {
    return SeedlingContent(content: json['url']);
  }
}

Future<SeedlingImage> fetchImages() async {
  final response =
      await http.get(Uri.parse('https://jsonplacehoder.typicode.com/photos'));
  if (response.statusCode == 200) {
    return SeedlingImage.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('Failed to Load Image');
  }
}

Future<SeedlingContent> fetchContent() async {
  final response =
      await http.get(Uri.parse('https://jsonplacehoder.typicode.com/photos'));
  if (response.statusCode == 200) {
    return SeedlingContent.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception('Failed to Load Image');
  }
}
