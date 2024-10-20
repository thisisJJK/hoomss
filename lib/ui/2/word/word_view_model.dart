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
      await readWrongListBybasic();
      await readWrongListByKtest();
      await readWrongListByToeic();

      return true;
    }

    isLoaded().then((result) {
      if (result) setCount();
    });
  }

//기초, 수능, 토익 총 갯수
  int totalCount = 1000;

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

//현재 남은 단어 리스트
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

  //모드별 오답 리스트
  var wrongListByBasic = <WordModel>[].obs;
  var wrongListByKtest = <WordModel>[].obs;
  var wrongListByToeic = <WordModel>[].obs;

  //모드별 오답 카운트
  var wrongCountBybasic = 0.obs;
  var wrongCountByKtest = 0.obs;
  var wrongCountByToeic = 0.obs;

//현재 남은 단어 카운트 함수
  void setCount() {
    bomoolCount.value = wordBomoolList.length;
    wrongCount.value = wordWrongList.length;
    basicCount.value = wordBasicList.length;
    kTestCount.value = wordKtestList.length;
    toeicCount.value = wordToeicList.length;
  }

  //모드별 오답 카운트 함수
  var wrongCountByMode1 = 0.obs;
  var wrongCountByMode2 = 0.obs;
  var wrongCountByMode3 = 0.obs;

  void setWrongCountByMode(mode) {
    wrongCountBybasic.value = wrongListByBasic.length;
    wrongCountByKtest.value = wrongListByKtest.length;
    wrongCountByToeic.value = wrongListByToeic.length;
    if (mode == ModeType.basic.toKo) wrongCountByMode1 = wrongCountBybasic;
    if (mode == ModeType.koreaTest.toKo) wrongCountByMode2 = wrongCountByKtest;

    if (mode == ModeType.toeic.toKo) wrongCountByMode3 = wrongCountByToeic;
  }

//mode card 카운트함수
  var currentCount1 = 0.obs;
  var currentCount2 = 0.obs;
  var currentCount3 = 0.obs;

  void currentCountByMode(mode) {
    if (mode == ModeType.basic.toKo) {
      currentCount1 = basicCount;
    }
    if (mode == ModeType.koreaTest.toKo) {
      currentCount2 = kTestCount;
    }
    if (mode == ModeType.toeic.toKo) {
      currentCount3 = toeicCount;
    }
  }

//퍼센트
  var currentPercent1 = 0.0.obs;
  var currentPercent2 = 0.0.obs;
  var currentPercent3 = 0.0.obs;
  void percent(mode) {
    setWrongCountByMode(mode);
    currentCountByMode(mode);

    if (mode == ModeType.basic.toKo) {
      currentPercent1.value =
          (totalCount - currentCount1.value - wrongCountByMode1.value) /
              totalCount;
    }
    if (mode == ModeType.koreaTest.toKo) {
      currentPercent2.value =
          (totalCount - currentCount2.value - wrongCountByMode2.value) /
              totalCount;
    }

    if (mode == ModeType.toeic.toKo) {
      currentPercent3.value =
          (totalCount - currentCount3.value - wrongCountByMode3.value) /
              totalCount;
    }
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

//모드별 오답 리스트
  Future<List<WordModel>> readWrongListBybasic() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWrongWords());
    wrongListByBasic.value = allWords
        .where((words) => words.level == ModeType.basic.toKo)
        .map((words) => words)
        .toList();
    return wrongListByBasic;
  }

  Future<List<WordModel>> readWrongListByKtest() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWrongWords());
    wrongListByKtest.value = allWords
        .where((words) => words.level == ModeType.koreaTest.toKo)
        .map((words) => words)
        .toList();
    return wrongListByKtest;
  }

  Future<List<WordModel>> readWrongListByToeic() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWrongWords());
    wrongListByToeic.value = allWords
        .where((words) => words.level == ModeType.toeic.toKo)
        .map((words) => words)
        .toList();

    return wrongListByToeic;
  }
}
