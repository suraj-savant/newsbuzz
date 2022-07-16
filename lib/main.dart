import 'package:flutter/material.dart';
import 'package:newsbuzz/provider/article_provider.dart';
import 'package:newsbuzz/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider<ArticleProvider>(create: (_) => ArticleProvider()),
    ], child: const NewsApp()));

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
