import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/wrong_book/widget/del_dialog.dart';

class WordCard extends StatelessWidget {
  final WordModel wordModel;
  const WordCard({
    super.key,
    required this.wordModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            delDialog(wordModel));
                  },
                  child: const Icon(
                    FeatherIcons.x,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              wordModel.eng,
              maxLines: 1,
              minFontSize: 10,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AutoSizeText(
              wordModel.kor,
              minFontSize: 10,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
