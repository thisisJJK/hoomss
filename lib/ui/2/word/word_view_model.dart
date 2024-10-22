import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hoomss/admob/ad_helper.dart';
import 'package:hoomss/data/database_service.dart';
import 'package:hoomss/data/word/word_data_type.dart';
import 'package:hoomss/data/word/word_model.dart';

class WordViewModel extends GetxController {
  var isAdReady = false.obs;
  BannerAd? bannerAd;

  @override
  void onInit() {
    adHelper().configureAdSettings(
      (ad) => {
        bannerAd = ad,
        isAdReady.value = true,
      },
      BannerType.large,
    );
    super.onInit();
  }

  final DatabaseService databaseService = Get.put(DatabaseService());

  Future<void> loadData() async {
    // if (totalBasicList.isEmpty) {
    //   //전체
    //   await readBasicWordTotalList();

    //   await readKtestWordTotalList();

    //   await readToeicWordTotalList();
    // }
    //모드별
    await readBomoolWordList();

    await readWrongWordList();

    await readBasicWordList();

    await readKtestWordList();

    await readToeicWordList();

    //오답 모드별
    await readWrongListBybasic();

    await readWrongListByKtest();

    await readWrongListByToeic();

    //
    setCount();

    percent();
  }

//기초, 수능, 토익 총 갯수
  int totalCount = 1000;

  // var totalBasicList = <WordModel>[].obs;
  // var totalKtestList = <WordModel>[].obs;
  // var totalToeicList = <WordModel>[].obs;

//모드별 전체 단어 함수
  // Future<List<WordModel>> readBasicWordTotalList() async {
  //   final Database db = await databaseService.database;
  //   List<Map<String, dynamic>> allBasicData =
  //       await databaseService.databaseConfig().then(
  //             (_) => db.query('words',
  //                 where: 'level=?', whereArgs: [ModeType.basic.name]),
  //           );

  //   List<WordModel> allBasicWords = List.generate(
  //     allBasicData.length,
  //     (i) => WordModel(
  //       id: allBasicData[i]['id'],
  //       eng: allBasicData[i]['eng'],
  //       kor: allBasicData[i]['kor'],
  //       level: allBasicData[i]['level'],
  //     ),
  //   );
  //   totalBasicList.value = allBasicWords;

  //   return totalBasicList;
  // }

  // Future<List<WordModel>> readKtestWordTotalList() async {
  //   final Database db = await databaseService.database;
  //   List<Map<String, dynamic>> allBasicData =
  //       await databaseService.databaseConfig().then(
  //             (_) => db.query('words',
  //                 where: 'level=?', whereArgs: [ModeType.koreaTest.name]),
  //           );

  //   List<WordModel> allKtestWords = List.generate(
  //     allBasicData.length,
  //     (i) => WordModel(
  //       id: allBasicData[i]['id'],
  //       eng: allBasicData[i]['eng'],
  //       kor: allBasicData[i]['kor'],
  //       level: allBasicData[i]['level'],
  //     ),
  //   );
  //   totalKtestList.value = allKtestWords;

  //   return totalKtestList;
  // }

  // Future<List<WordModel>> readToeicWordTotalList() async {
  //   final Database db = await databaseService.database;
  //   List<Map<String, dynamic>> allBasicData =
  //       await databaseService.databaseConfig().then(
  //             (_) => db.query('words',
  //                 where: 'level=?', whereArgs: [ModeType.toeic.name]),
  //           );

  //   List<WordModel> allToeicWords = List.generate(
  //     allBasicData.length,
  //     (i) => WordModel(
  //       id: allBasicData[i]['id'],
  //       eng: allBasicData[i]['eng'],
  //       kor: allBasicData[i]['kor'],
  //       level: allBasicData[i]['level'],
  //     ),
  //   );
  //   totalToeicList.value = allToeicWords;

  //   return totalToeicList;
  // }

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

//퍼센트
  var currentPercent1 = 0.0.obs;
  var currentPercent2 = 0.0.obs;
  var currentPercent3 = 0.0.obs;

  void percent() {
    currentPercent1.value =
        (totalCount - basicCount.value - wrongListByBasic.length) / totalCount;

    currentPercent2.value =
        (totalCount - kTestCount.value - wrongListByKtest.length) / totalCount;

    currentPercent3.value =
        (totalCount - toeicCount.value - wrongListByToeic.length) / totalCount;
  }

//모드별 현재 남은 단어 리스트
  Future<List<WordModel>> readBomoolWordList() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readBomoolWords());
    wordBomoolList.assignAll(allWords);

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
            (words) => words.level == ModeType.basic.name && words.correct == 0)
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
            words.level == ModeType.koreaTest.name && words.correct == 0)
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
            (words) => words.level == ModeType.toeic.name && words.correct == 0)
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
        .where((word) => word.level == ModeType.basic.name)
        .map((word) => word)
        .toList();

    return wrongListByBasic;
  }

  Future<List<WordModel>> readWrongListByKtest() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWrongWords());
    wrongListByKtest.value = allWords
        .where((words) => words.level == ModeType.koreaTest.name)
        .map((words) => words)
        .toList();

    return wrongListByKtest;
  }

  Future<List<WordModel>> readWrongListByToeic() async {
    var allWords = await databaseService
        .databaseConfig()
        .then((_) => databaseService.readWrongWords());
    wrongListByToeic.value = allWords
        .where((words) => words.level == ModeType.toeic.name)
        .map((words) => words)
        .toList();

    return wrongListByToeic;
  }
}
