import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/data/word/word_model.dart';

class BomoolViewModel extends GetxController {
  final DatabaseService databaseService = Get.put(DatabaseService());

  final TextEditingController engController = TextEditingController();
  final TextEditingController korController = TextEditingController();
  var wordList = <WordModel>[].obs;
  var isLoading = true.obs;
  int currentCount = 0;

  @override
  void onInit() {
    super.onInit();
    readBomoolWordList();
  }

  Future<void> readBomoolWordList() async {
    try {
      List<WordModel> words = await databaseService
          .databaseConfig()
          .then((_) => databaseService.readBomoolWords());

      wordList.assignAll(words);
    } finally {
      isLoading.value = false;
    }
  }
}
