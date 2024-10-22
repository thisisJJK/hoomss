import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view_model.dart';

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
    Get.find<BomoolViewModel>().readBomoolWordList();

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
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //추가버튼
                ElevatedButton(
                  onPressed: () {
                    if (engController.text == '' || korController.text == '') {
                      Get.back();
                      engController.text = '';
                      korController.text = '';
                    }
                    if (engController.text != '' && korController.text != '') {
                      var wordList = Get.find<BomoolViewModel>().wordList;
                      int id = 1;

                      if (wordList.isNotEmpty) {
                        id = wordList.last.id + 1;
                      }
                      Get.find<BomoolViewModel>()
                          .databaseService
                          .insertBomoolWord(WordModel(
                            id: id,
                            eng: engController.text,
                            kor: korController.text,
                            level: ModeType.bomool.name,
                          ))
                          .then((result) {
                        if (result) {
                          Get.find<BomoolViewModel>().readBomoolWordList();

                          Get.back();
                          engController.text = '';
                          korController.text = '';
                        }
                      });
                    }
                  },
                  child: const Text('추가'),
                ),
                const SizedBox(
                  width: 10,
                ),
                //취소버튼
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
