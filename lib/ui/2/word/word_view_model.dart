import 'package:get/get.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';

class WordViewModel extends GetxController {
  @override
  void onInit() {
    readBomoolWordList();
    readWrongWordList();
    readBasicWordList();
    readKtestWordList();
    readToeicWordList();
    setCount();

    super.onInit();
  }

  final DatabaseService databaseService = Get.put(DatabaseService());

//기초, 수능, 토익 총 갯수
  int total(String mode) {
    int totalCount;
    mode == ModeType.basic.toKo
        ? totalCount = 50 //기초단어
        : mode == ModeType.koreaTest.toKo
            ? totalCount = 50 //수능단어
            : totalCount = 50; //토익단어

    return totalCount;
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
    int currentCount = 0;
    if (mode == ModeType.basic.toKo) {
      currentCount = wordBasicList.length;
    }
    if (mode == ModeType.koreaTest.toKo) {
      currentCount = wordKtestList.length;
    }

    if (mode == ModeType.toeic.toKo) {
      currentCount = wordToeicList.length;
    }
    return currentCount;
  }

//퍼센트
  double percent(mode) {
    double currentPercent = (total(mode) - currentCount(mode)) / total(mode);

    return currentPercent;
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
