import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hoomss/ui/2/bomoolbook/widget/del_dialog.dart';

class WordCard extends StatelessWidget {
  final int id;
  final String word;
  final String meaning;
  const WordCard(
      {super.key, required this.word, required this.meaning, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
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
                        builder: (BuildContext context) => delDialog(id));
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
              word,
              maxLines: 1,
              minFontSize: 10,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AutoSizeText(
              meaning,
              minFontSize: 10,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
