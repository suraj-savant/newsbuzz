import 'package:flutter/material.dart';
import 'package:newsbuzz/models/article.dart';
import 'package:newsbuzz/provider/article.dart';
import 'package:newsbuzz/provider/speech_provider.dart';
import 'package:newsbuzz/provider/toogle_search_bar.dart';
import 'package:newsbuzz/utils/news_builder.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Builder(builder: (context) {
        final int? currentTabIndex = DefaultTabController.of(context)?.index;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text("NewsBuzz"),
              actions: [
                const SearchBar(),
                IconButton(
                  onPressed: context.read<ToogleSearch>().toogleSeachBar,
                  icon: const Icon(Icons.search),
                ),
              ],
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
                  .map((articlelist) => NewsBuilder(
                        articleList: articlelist,
                        currentTabIndex: currentTabIndex,
                      ))
                  .toList(),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: const SpeechButton(),
          ),
        );
      }),
    );
  }
}

class SpeechButton extends StatefulWidget {
  const SpeechButton({
    Key? key,
  }) : super(key: key);

  @override
  State<SpeechButton> createState() => _SpeechButtonState();
}

class _SpeechButtonState extends State<SpeechButton> {
  bool bottomSheetOpened = false;
  void toogleSheet() {
    setState(() {
      bottomSheetOpened = !bottomSheetOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    void searchArticle(String? serachInput) {
      if (serachInput != '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fetching Results for $serachInput')),
        );
        context.read<ArticleProvider>().queryArticles(serachInput!);
      }
    }

    void _sttHandler() async {
      if (!bottomSheetOpened) {
        showBottomSheet(
            context: context,
            builder: (context) {
              var state = context.watch<SpeechProvider>();
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.text),
                  ],
                ),
              );
            });
        toogleSheet();
      } else {
        Navigator.pop(context);
        toogleSheet();
      }
      String? textFromStt = await context.read<SpeechProvider>().speechToText();
      searchArticle(textFromStt);
    }

    return AvatarGlow(
      animate: context.watch<SpeechProvider>().isListening,
      glowColor: Theme.of(context).primaryColor,
      endRadius: 75.0,
      duration: const Duration(milliseconds: 2000),
      repeatPauseDuration: const Duration(milliseconds: 100),
      repeat: true,
      child: FloatingActionButton(
        onPressed: _sttHandler,
        child: const Text("Start"),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void searchArticle(String serachInput) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fetching Results for $serachInput')),
      );
      context.read<ArticleProvider>().queryArticles(serachInput);
      context.read<ToogleSearch>().toogleSeachBar();
    }

    const inputDecoration = InputDecoration(
      hintText: "Seach Anything ...",
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
    return AnimatedContainer(
      width: context.watch<ToogleSearch>().isSearchBarActive ? 200 : 0,
      duration: const Duration(seconds: 1),
      child: TextField(
        onSubmitted: searchArticle,
        decoration: inputDecoration,
      ),
    );
  }
}

class NewsBuilder extends StatelessWidget {
  const NewsBuilder(
      {Key? key, required this.articleList, required this.currentTabIndex})
      : super(key: key);
  final Future<List<Article>> articleList;
  final int? currentTabIndex;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RefreshIndicator(
      onRefresh: () =>
          context.read<ArticleProvider>().refreshArticleList(currentTabIndex),
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
    ));
  }
}
