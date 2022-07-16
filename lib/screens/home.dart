import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/provider/article_provider.dart';
import 'package:newsbuzz/utils/news_builder.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("NewsBuzz"),
          bottom: TabBar(
            padding: const EdgeInsets.all(16),
            isScrollable: true,
            tabs: categories
                .map((category) => Text(category.toUpperCase()))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: context
              .watch<ArticleProvider>()
              .categoryArticleList
              .map((articlelist) => NewsBuilder(articleList: articlelist))
              .toList(),
        ),
      ),
    ));
  }
}

class NewsBuilder extends StatelessWidget {
  const NewsBuilder({Key? key, required this.articleList}) : super(key: key);
  final Future<List<Article>> articleList;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async => Future.delayed(Duration(seconds: 4), () => 1),
        child: FutureBuilder<List<Article>>(
          future: articleList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Opps Please check your Internet connection");
            } else if (snapshot.hasData) {
              return ArticleBuilder(
                articles: snapshot.data!,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
