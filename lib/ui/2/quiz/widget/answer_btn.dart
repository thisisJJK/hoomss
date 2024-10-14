import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnswerBtn extends StatelessWidget {
  final Function() onTap;
  final String text;
  const AnswerBtn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        width: 190,
        height: 90,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: AutoSizeText(
            text,
            maxLines: 2,
            minFontSize: 12,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 21),
          ),
        ),
      ),
    );
  }
}
