import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/bomoolbook/bomool_view_model.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController engController;
  final TextEditingController korController;
  const AddDialog({
    super.key,
    required this.engController,
    required this.korController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('추가'),
      content: SizedBox(
        height: 220,
        child: Column(
          children: [
            const Text('단어'),
            const SizedBox(
              height: 1,
            ),
            TextField(
              controller: engController,
            ),
            const Text('의미'),
            const SizedBox(
              height: 1,
            ),
            TextField(
              controller: korController,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.find<BomoolViewModel>().currentCount =
                        Get.find<BomoolViewModel>().wordList.length;
                    Get.find<BomoolViewModel>()
                        .databaseService
                        .insertBomoolWord(WordModel(
                          id: Get.find<BomoolViewModel>().currentCount + 1,
                          eng: engController.text,
                          kor: korController.text,
                          level: ModeType.bomool.toKo,
                        ))
                        .then((result) {
                      if (result) {
                        Get.find<BomoolViewModel>().readBomoolWordList();

                        Get.back();
                        engController.text = '';
                        korController.text = '';
                      }
                    });
                  },
                  child: const Text('추가'),
                ),
                ElevatedButton(
                  onPressed: () {
                    engController.text = '';
                    korController.text = '';
                    Get.back();
                  },
                  child: const Text('취소'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
