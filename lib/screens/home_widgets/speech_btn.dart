import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:newsbuzz/provider/article.dart';
import 'package:newsbuzz/provider/speech_provider.dart';
import 'package:provider/provider.dart';

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
        showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (context) {
              var state = context.watch<SpeechProvider>();
              return SizedBox(
                height: 200,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarGlow(
                      animate: context.watch<SpeechProvider>().isListening,
                      glowColor: Theme.of(context).primaryColor,
                      endRadius: 75.0,
                      duration: const Duration(milliseconds: 2000),
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      repeat: true,
                      child: IconButton(
                        onPressed: _sttHandler,
                        icon: const Icon(Icons.mic),
                      ),
                    ),
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

    return FloatingActionButton(
      onPressed: _sttHandler,
      child: const Icon(Icons.mic),
    );
  }
}
