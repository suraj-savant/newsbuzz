import 'package:flutter/material.dart';
import 'package:newsbuzz/provider/article.dart';
import 'package:newsbuzz/provider/toogle_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:newsbuzz/screens/home_widgets/home_popup_btn.dart';
import 'package:newsbuzz/screens/home_widgets/speech_btn.dart';
import 'package:newsbuzz/screens/home_widgets/news_builder.dart';
import 'package:newsbuzz/screens/home_widgets/search_bar.dart';

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
                const HomePopUpBtn(),
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
