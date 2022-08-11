import "package:flutter/material.dart";
import 'package:newsbuzz/provider/bookmark.dart';
import 'package:newsbuzz/utils/news_builder.dart';
import "package:provider/provider.dart";

import '../models/article.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookMarks"),
      ),
      body: FutureBuilder<List<Article>>(
        future: context.watch<BookmarkProvider>().getBookmarks(),
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
