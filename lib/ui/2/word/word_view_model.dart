import 'package:get/get.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';

class WordViewModel extends GetxController {
  final DatabaseService databaseService = Get.put(DatabaseService());

  Future<void> loadData() async {
    Future<bool> isLoaded() async {
      await readBasicWordTotalList();
      await readKtestWordTotalList();
      await readToeicWordTotalList();
      await readBomoolWordList();
      await readWrongWordList();
      await readBasicWordList();
      await readKtestWordList();
      await readToeicWordList();
      return true;
    }

    isLoaded().then((result) {
      if (result) setCount();
    });
  }

//기초, 수능, 토익 총 갯수
  int total(String mode) {
    int totalCount;
    mode == ModeType.basic.toKo
        ? totalCount = totalBasicList.length //기초단어
        : mode == ModeType.koreaTest.toKo
            ? totalCount = totalKtestList.length //수능단어
            : totalCount = totalToeicList.length; //토익단어

    return totalCount;
  }

  var totalBasicList = <WordModel>[].obs;
  var totalKtestList = <WordModel>[].obs;
  var totalToeicList = <WordModel>[].obs;

  Future<List<WordModel>> readBasicWordTotalList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWords());
    totalBasicList.value = allWords
        .where((words) => words.level == ModeType.basic.toKo)
        .map((words) => words)
        .toList();

    return totalBasicList;
  }

  Future<List<WordModel>> readKtestWordTotalList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWords());
    totalKtestList.value = allWords
        .where((words) => words.level == ModeType.koreaTest.toKo)
        .map((words) => words)
        .toList();

    return totalKtestList;
  }

  Future<List<WordModel>> readToeicWordTotalList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWords());
    totalToeicList.value = allWords
        .where((words) => words.level == ModeType.toeic.toKo)
        .map((words) => words)
        .toList();

    return totalToeicList;
  }

//단어 리스트
  var wordBomoolList = <WordModel>[].obs;
  var wordWrongList = <WordModel>[].obs;
  var wordBasicList = <WordModel>[].obs;
  var wordKtestList = <WordModel>[].obs;
  var wordToeicList = <WordModel>[].obs;

//모드별 리스트 카운트
  var bomoolCount = 0.obs;
  var wrongCount = 0.obs;
  var basicCount = 0.obs;
  var kTestCount = 0.obs;
  var toeicCount = 0.obs;

//카운트 함수
  void setCount() {
    bomoolCount.value = wordBomoolList.length;
    wrongCount.value = wordWrongList.length;
    basicCount.value = wordBasicList.length;
    kTestCount.value = wordKtestList.length;
    toeicCount.value = wordToeicList.length;
  }

//mode card 카운트함수
  int currentCount(mode) {
    var currentCount = 0;
    if (mode == ModeType.basic.toKo) {
      currentCount = basicCount.value;
    }
    if (mode == ModeType.koreaTest.toKo) {
      currentCount = kTestCount.value;
    }

    if (mode == ModeType.toeic.toKo) {
      currentCount = toeicCount.value;
    }
    return currentCount;
  }

//퍼센트
  double percent(mode) {
    double currentPercent = (total(mode) - currentCount(mode)) / total(mode);

    return currentPercent;
  }

  double percent100(mode) {
    double percent100 = percent(mode) * 100;
    return percent100;
  }

//모드별 현재 남은 단어 리스트
  Future<List<WordModel>> readBomoolWordList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readBomoolWords());
    wordBomoolList.value = allWords
        .where((words) => words.level == ModeType.bomool.toKo)
        .map((words) => words)
        .toList();

    return wordBomoolList;
  }

  Future<List<WordModel>> readWrongWordList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWrongWords());
    wordWrongList.value = allWords;

    return wordWrongList;
  }

  Future<List<WordModel>> readBasicWordList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWords());
    wordBasicList.value = allWords
        .where(
            (words) => words.level == ModeType.basic.toKo && words.correct == 0)
        .map((words) => words)
        .toList();

    return wordBasicList;
  }

  Future<List<WordModel>> readKtestWordList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWords());
    wordKtestList.value = allWords
        .where((words) =>
            words.level == ModeType.koreaTest.toKo && words.correct == 0)
        .map((words) => words)
        .toList();

    return wordKtestList;
  }

  Future<List<WordModel>> readToeicWordList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWords());
    wordToeicList.value = allWords
        .where(
            (words) => words.level == ModeType.toeic.toKo && words.correct == 0)
        .map((words) => words)
        .toList();

    return wordToeicList;
  }
}
