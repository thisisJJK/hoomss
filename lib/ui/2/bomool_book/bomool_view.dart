import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view_model.dart';
import 'package:hoomss/ui/2/bomool_book/widget/add_dialog.dart';
import 'package:hoomss/ui/2/bomool_book/widget/edit_dialog.dart';
import 'package:hoomss/ui/2/bomool_book/widget/word_card.dart';

class BomoolView extends StatelessWidget {
  BomoolView({super.key});

  final BomoolViewModel _bomoolViewModel = Get.put(BomoolViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: body(),
    );
  }

  Obx body() {
    return Obx(() {
      if (_bomoolViewModel.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (_bomoolViewModel.wordList.isEmpty) {
        return const Center(
          child: Text('단어를 추가해보세요'),
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
          itemCount: _bomoolViewModel.wordList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Future<WordModel> word = Get.find<BomoolViewModel>()
                    .databaseService
                    .readBomoolWord(_bomoolViewModel.wordList[index].id);
                showDialog(
                    context: context,
                    builder: (BuildContext context) => EditDialog(
                        id: _bomoolViewModel.wordList[index].id,
                        engController: _bomoolViewModel.engController,
                        korController: _bomoolViewModel.korController,
                        word: word));
              },
              child: WordCard(
                  id: _bomoolViewModel.wordList[index].id,
                  word: _bomoolViewModel.wordList[index].eng,
                  meaning: _bomoolViewModel.wordList[index].kor),
            );
          });
    });
  }

  AppBar appbar(context) {
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
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AddDialog(
                        engController: _bomoolViewModel.engController,
                        korController: _bomoolViewModel.korController,
                      ));
            },
            icon: const Icon(
              FeatherIcons.plus,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
