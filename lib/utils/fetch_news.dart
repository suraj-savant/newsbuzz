import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/utils/api_key.dart';

///Fetches the list of artible by given category
///
///
Future<List<Article>> fetchArticleByCategory(String category) async {
  var url =
      'https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apiKey';
  var res = await http.get(Uri.parse(url));
  print(res.statusCode);
  if (!(res.statusCode == 200)) throw Exception("Unable to load json");

  return compute(parseArticle, res.body);
}

Future<List<Article>> fetchArticleByQuery(String query) async {
  var url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';
  var res = await http.get(Uri.parse(url));
  if (!(res.statusCode == 200)) throw Exception("Unable to load json");

  return compute(parseArticle, res.body);
}

/// A functiion that converts the response body from http get method into the
/// `List<Articles>`

List<Article> parseArticle(String responseBody) {
  final jsonData = jsonDecode(responseBody);
  List<dynamic> articleJsonList = jsonData['articles'];
  List<Article> temp =
      articleJsonList.map((value) => Article.fromJson(value)).toList();
  temp.shuffle();
  return temp;
}
