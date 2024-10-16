enum ModeType {
  bomool(toKo: '보물 단어장'),
  wrong(toKo: '오답노답'),
  basic(toKo: '기초'),
  koreaTest(toKo: '수능'),
  toeic(toKo: '토익');

  final String toKo;
  const ModeType({required this.toKo});
}

List<Map<String, dynamic>> wordData() {
  return [
    {"id": 1, "eng": "hello", "kor": "안녕하세요", "level": "수능"},
    {"id": 2, "eng": "world", "kor": "세계", "level": "기초"},
    {"id": 3, "eng": "apple", "kor": "사과", "level": "기초"},
    {"id": 4, "eng": "book", "kor": "책", "level": "기초"},
    {"id": 5, "eng": "pen", "kor": "펜", "level": "수능"},
    {"id": 6, "eng": "computer", "kor": "컴퓨터", "level": "수능"},
    {"id": 7, "eng": "water", "kor": "물", "level": "수능"},
    {"id": 8, "eng": "food", "kor": "음식", "level": "수능"},
    {"id": 9, "eng": "love", "kor": "사랑", "level": "수능"},
    {"id": 10, "eng": "friend", "kor": "친구", "level": "토익"},
    {"id": 11, "eng": "school", "kor": "학교", "level": "토익"},
    {"id": 12, "eng": "teacher", "kor": "선생님", "level": "토익"},
    {"id": 13, "eng": "student", "kor": "학생", "level": "토익"},
    {"id": 14, "eng": "sun", "kor": "태양", "level": "토익"},
    {"id": 15, "eng": "moon", "kor": "달", "level": "토익"},
    {"id": 16, "eng": "car", "kor": "자동차", "level": "토익"},
    {"id": 17, "eng": "tree", "kor": "나무", "level": "토익"},
    {"id": 18, "eng": "flower", "kor": "꽃", "level": "수능"},
    {"id": 19, "eng": "house", "kor": "집", "level": "수능"},
    {"id": 20, "eng": "cat", "kor": "고양이", "level": "수능"},
    {"id": 21, "eng": "dog", "kor": "강아지", "level": "수능"},
    {"id": 22, "eng": "bird", "kor": "새", "level": "수능"},
    {"id": 23, "eng": "fish", "kor": "물고기", "level": "수능"},
    {"id": 24, "eng": "mountain", "kor": "산", "level": "수능"},
    {"id": 25, "eng": "river", "kor": "강", "level": "기초"},
    {"id": 26, "eng": "family", "kor": "가족", "level": "기초"},
    {"id": 27, "eng": "music", "kor": "음악", "level": "토익"},
    {"id": 28, "eng": "dance", "kor": "춤", "level": "토익"},
    {"id": 29, "eng": "rain", "kor": "비", "level": "기초"},
    {"id": 30, "eng": "snow", "kor": "눈", "level": "기초"}
  ];
}
