import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/utils/fetch_news.dart';
import 'package:newsbuzz/utils/news_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "general",
      "entertainment",
      "health",
      "science",
      "sports",
      "technology"
    ];
    return SafeArea(
        child: DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("NewsBuzz"),
          bottom: TabBar(
            padding: const EdgeInsets.all(16),
            isScrollable: true,
            tabs: List.generate(
              categories.length,
              (index) => Text(
                categories[index].toUpperCase(),
              ),
            ),
          ),
        ),
        body: TabBarView(
            children: List.generate(categories.length,
                (index) => NewsBuilder(category: categories[index]))),
      ),
    ));
  }
}

class NewsBuilder extends StatelessWidget {
  NewsBuilder({Key? key, required this.category}) : super(key: key);
  String category;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Article>>(
        future: fetchArticle(category),
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
    );
  }
}
