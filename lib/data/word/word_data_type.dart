enum ModeType {
  bomool(toKo: '보물단어장'),
  wrong(toKo: '오답노답장'),
  basic(toKo: '1000제 1탄'),
  koreaTest(toKo: '1000제 2탄'),
  toeic(toKo: '1000제 3탄');

  final String toKo;
  const ModeType({required this.toKo});
}

enum TableType {
  words,
  bomool,
  wrong;
}










  // void addBasic(List<Map<String, dynamic>> newWords) {
  //   for (var word in newWords) {
  //     String eng = word['eng'];
  //     String kor = word['kor'];

  //     // bool isDuplicate = words.any((word) => word['eng'] == eng);

  //     Map<String, dynamic> newWord = {
  //       'id': basic.length + 1,
  //       'eng': eng,
  //       'kor': kor,
  //       'level': ModeType.basic.toKo,
  //       'correct': 0
  //     };

  //     basic.add(newWord);
  //   }
  // }

  // void addKtest(List<Map<String, dynamic>> newWords) {
  //   for (var word in newWords) {
  //     String eng = word['eng'];
  //     String kor = word['kor'];

  //     // bool isDuplicate = words.any((word) => word['eng'] == eng);

  //     Map<String, dynamic> newWord = {
  //       'id': kTest.length + 1001,
  //       'eng': eng,
  //       'kor': kor,
  //       'level': ModeType.koreaTest.toKo,
  //       'correct': 0
  //     };

  //     kTest.add(newWord);
  //   }
  // }

  // void addToeic(List<Map<String, dynamic>> newWords) {
  //   for (var word in newWords) {
  //     String eng = word['eng'];
  //     String kor = word['kor'];

  //     // bool isDuplicate = words.any((word) => word['eng'] == eng);

  //     Map<String, dynamic> newWord = {
  //       'id': toeic.length + 2001,
  //       'eng': eng,
  //       'kor': kor,
  //       'level': ModeType.toeic.toKo,
  //       'correct': 0
  //     };

  //     toeic.add(newWord);
  //   }
  // }
