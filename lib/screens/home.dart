import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/utils/news_builder.dart';
import 'package:newsbuzz/utils/fetch_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Article>> articles;
  @override
  void initState() {
    super.initState();
    articles = fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("NewsBuzz"),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
          future: articles,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error in snapshot ${snapshot.error}");
            } else if (snapshot.hasData) {
              return NewsBuilder(
                articles: snapshot.data!,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
