import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsbuzz/firebase_options.dart';
import 'package:newsbuzz/provider/article.dart';
import 'package:newsbuzz/provider/bookmark.dart';
import 'package:newsbuzz/provider/login.dart';
import 'package:newsbuzz/provider/speech_provider.dart';
import 'package:newsbuzz/provider/toogle_search_bar.dart';
import 'package:newsbuzz/screens/home.dart';
import 'package:newsbuzz/screens/login.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BookmarkProvider>(
          create: (_) => BookmarkProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider<ToogleSearch>(
          create: (_) => ToogleSearch(),
        ),
        ChangeNotifierProvider<ArticleProvider>(
          create: (_) => ArticleProvider(),
        ),
        ChangeNotifierProvider<SpeechProvider>(
          create: (_) => SpeechProvider(),
        )
      ],
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = context.watch<LoginProvider>().isloggedIn;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: (!isUserLoggedIn) ? const LoginScreen() : const HomeScreen(),
    );
  }
}
