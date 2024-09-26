import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class QuizCard extends StatelessWidget {
  final String word;
  const QuizCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 180,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Center(
          child: Text(
            word,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 42,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(

          //즐겨찾기 -> 보물 단어장
          onTap: () {},
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              FeatherIcons.star,
              color: Colors.yellow,
            ),
          ),
        ),
      ),
    ]);
  }
}
