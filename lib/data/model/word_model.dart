class WordModel {
  final int id;
  final String eng;
  final String kor;

  WordModel({
    required this.id,
    required this.eng,
    required this.kor,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'eng': eng, 'kor': kor};
  }
}
