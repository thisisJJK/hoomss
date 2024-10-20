import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';
import 'package:hoomss/ui/2/bomool_book/bomool_view_model.dart';

class EditDialog extends StatelessWidget {
  final Future<WordModel> word;
  final int id;
  final TextEditingController engController;
  final TextEditingController korController;
  const EditDialog(
      {super.key,
      required this.id,
      required this.engController,
      required this.korController,
      required this.word});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('편집'),
      content: FutureBuilder(
          future: word,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              engController.text = snapshot.data!.eng;
              korController.text = snapshot.data!.kor;

              return SizedBox(
                height: 220,
                child: Column(
                  children: [
                    const Text('단어'),
                    TextField(
                      controller: engController,
                    ),
                    const Text('의미'),
                    TextField(
                      controller: korController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.find<BomoolViewModel>()
                                .databaseService
                                .updateBomoolWord(
                                  WordModel(
                                    id: snapshot.data!.id,
                                    eng: engController.text,
                                    kor: korController.text,
                                    level: ModeType.bomool.toKo,
                                  ),
                                )
                                .then((result) {
                              if (result) {
                                Get.find<BomoolViewModel>()
                                    .readBomoolWordList();
                                engController.text = '';
                                korController.text = '';
                                Get.back();
                              }
                            });
                          },
                          child: const Text('수정'),
                        ),
                        const SizedBox(
                          width: 10,
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
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('error'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
