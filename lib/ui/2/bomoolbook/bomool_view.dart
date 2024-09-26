import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/ui/2/bomoolbook/widget/word_card.dart';

class BomoolView extends StatelessWidget {
  const BomoolView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: GridView.builder(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          childAspectRatio: 1.5,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return const WordCard(
              word: 'wordwordword', meaning: 'meaningmeaningmeaning');
        },
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      title: const Row(
        children: [
          Icon(FeatherIcons.book),
          SizedBox(width: 3),
          Text(
            '보물 단어장',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              FeatherIcons.arrowLeft,
              size: 32,
            )),
      ),
    );
  }
}
