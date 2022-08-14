import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart ';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/utils/utils.dart';

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
      categories.map((category) => fetchArticleByCategory(category)).toList();

  Future<void> refreshArticleList(int? tabIndex) async {
    List<Article> temp = await categoryArticleList[tabIndex!];
    temp.shuffle();
    categoryArticleList[tabIndex] = Future.value(temp);
    notifyListeners();
  }

  Future<void> queryArticles(String query) async {
    List<Article> temp = await categoryArticleList[0];
    temp.insertAll(0, await fetchArticleByQuery(query));
    categoryArticleList[0] = Future.value(temp);
    notifyListeners();
  }
}
