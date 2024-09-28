import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class WordCard extends StatelessWidget {
  final String word;
  final String meaning;
  const WordCard({super.key, required this.word, required this.meaning});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Icon(
              FeatherIcons.star,
              size: 16,
              color: Colors.yellow,
            ),
          ),
          AutoSizeText(
            word,
            maxLines: 1,
            minFontSize: 10,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          AutoSizeText(
            meaning,
            minFontSize: 10,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
