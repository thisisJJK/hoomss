import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/quiz/quiz_view.dart';
import 'package:hoomss/ui/2/word/word_view_model.dart';
import 'package:hoomss/ui/2/wrong_book/widget/word_card.dart';
import 'package:hoomss/ui/2/wrong_book/wrong_view_model.dart';

class WrongView extends StatelessWidget {
  WrongView({super.key});

  final WrongViewModel _wrongViewModel = Get.put(WrongViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_wrongViewModel.wordList.isEmpty) return;
          Get.to(
            () => QuizView(
              mode: ModeType.wrong,
            ),
          );
        },
        child: const Icon(FeatherIcons.play),
      ),
    );
  }

  Obx body() {
    return Obx(() {
      if (_wrongViewModel.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (_wrongViewModel.wordList.isEmpty) {
        return const Center(
          child: Text(
            '✨완벽완벽✨',
            style: TextStyle(
              fontSize: 21,
            ),
          ),
        );
      }
      return GridView.builder(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          ),
          itemCount: _wrongViewModel.wordList.length,
          itemBuilder: (BuildContext context, int index) {
            WordModel word = _wrongViewModel.wordList[index];
            return WordCard(
              wordModel: word,
            );
          });
    });
  }

  AppBar appbar(context) {
    return AppBar(
      centerTitle: true,
      title: Row(
        children: [
          const Icon(FeatherIcons.book),
          const SizedBox(width: 3),
          Text(
            ModeType.wrong.toKo,
            style: const TextStyle(
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
            Get.find<WordViewModel>().loadData();
            Get.back();
          },
          icon: const Icon(
            FeatherIcons.arrowLeft,
            size: 32,
          ),
        ),
      ),
    );
  }
}
