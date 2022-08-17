import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/provider/article.dart';
import 'package:newsbuzz/utils/widgets/article_builder.dart';
import 'package:provider/provider.dart';

class NewsBuilder extends StatelessWidget {
  const NewsBuilder(
      {Key? key, required this.articleList, required this.currentTabIndex})
      : super(key: key);
  final Future<List<Article>> articleList;
  final int? currentTabIndex;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<ArticleProvider>().refreshArticleList(currentTabIndex),
      child: FutureBuilder<List<Article>>(
        future: articleList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return RefreshIndicator(
              onRefresh: () => context
                  .read<ArticleProvider>()
                  .refreshArticleList(currentTabIndex),
              child: ListView(
                children: const [
                  SizedBox(
                    height: 300,
                  ),
                  Center(
                    child:
                        Text("No Internet connection refresh page to reload"),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return ArticleBuilder(
              articles: snapshot.data!,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
