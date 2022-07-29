import 'package:flutter/material.dart';
import 'package:newsbuzz/provider/article.dart';
import 'package:newsbuzz/provider/toogle_search_bar.dart';
import 'package:newsbuzz/screens/home.dart';
import 'package:newsbuzz/screens/speech.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ToogleSearch>(create: (_) => ToogleSearch()),
          ChangeNotifierProvider<ArticleProvider>(
              create: (_) => ArticleProvider()),
        ],
        child: const NewsApp(),
      ),
    );

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}
