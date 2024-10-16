enum ChatType {
  sent,
  received,
}

enum DifficultyType {
  easy(toKo: '쉬움'),
  medium(toKo: '보통'),
  hard(toKo: '어려움');

  final String toKo;

  const DifficultyType({required this.toKo});
}
