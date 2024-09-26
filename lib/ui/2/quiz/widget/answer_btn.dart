import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnswerBtn extends StatelessWidget {
  const AnswerBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5),
      width: 190,
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: const Center(
        child: AutoSizeText(
          '흘린 단어장으로fhfhhf',
          maxLines: 2,
          minFontSize: 12,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
