import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/data/model/word_model.dart';

class BomoolViewModel extends GetxController {
  
  final DatabaseService databaseService = Get.put(DatabaseService());
   Future<List<WordModel>> wordList = DatabaseService()
      .databaseConfig()
      .then((_) => DatabaseService().readWords());

  int currentCount = 0;
}
