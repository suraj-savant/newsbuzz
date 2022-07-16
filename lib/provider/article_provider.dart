import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart ';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/utils/fetch_news.dart';

const List<String> categories = [
  "general",
  "entertainment",
  "health",
  "science",
  "sports",
  "technology"
];

class ArticleProvider with ChangeNotifier {
  List<Future<List<Article>>> categoryArticleList =
      categories.map((category) => fetchArticle(category)).toList();
}
