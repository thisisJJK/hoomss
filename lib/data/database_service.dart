import 'package:hoomss/data/word/word_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  late Future<Database> database;

  factory DatabaseService() => _databaseService;

  DatabaseService._internal() {
    databaseConfig();
  }
//db 설정
  Future<bool> databaseConfig() async {
    try {
      database = openDatabase(
        join(await getDatabasesPath(), 'hoomss_database.db'),
        onCreate: (db, version) async {
          await db.execute('''
              CREATE TABLE words(
              id INTEGER PRIMARY KEY,
              eng TEXT,
              kor TEXT,
              level TEXT,
              correct BOOL DEFAULT 0
              )
              ''');
          await db.execute('''
              CREATE TABLE bomool(
              id INTEGER PRIMARY KEY,
              eng TEXT,
              kor TEXT,
              level TEXT,
              correct BOOL DEFAULT 0

              )
              ''');
          await db.execute('''
              CREATE TABLE wrong(
              id INTEGER PRIMARY KEY,
              eng TEXT,
              kor TEXT,
              level TEXT,
              correct BOOL DEFAULT 0

              )
              ''');

          await _insertInitData(db);
        },
        version: 1,
      );
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

//초기 단어 데이터
  Future<bool> _insertInitData(Database db) async {
    try {
      //word
      List<WordModel> words = await parseWords();
      for (var word in words) {
        await db.insert('words', word.toMap());
      }

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> insertWord(WordModel word) async {
    final Database db = await database;
    try {
      db.insert('words', word.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<WordModel>> readWords() async {
    final Database db = await database;
    final List<Map<String, dynamic>> data = await db.query('words');

    return List.generate(data.length, (i) {
      return WordModel(
        id: data[i]['id'],
        eng: data[i]['eng'],
        kor: data[i]['kor'],
        level: data[i]['level'],
        correct: data[i]['correct'],
      );
    });
  }

  Future<WordModel> readWord(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> data =
        await db.query('words', where: 'id=?', whereArgs: [id]);
    return WordModel(
      id: data[0]['id'],
      eng: data[0]['eng'],
      kor: data[0]['kor'],
      level: data[0]['level'],
      correct: data[0]['correct'],
    );
  }

  Future<bool> updateWord(WordModel word) async {
    final Database db = await database;
    try {
      db.update(
        'words',
        word.toMap(),
        where: 'id=?',
        whereArgs: [word.id],
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> deleteWord(int id) async {
    final Database db = await database;

    try {
      db.delete(
        'words',
        where: 'id=?',
        whereArgs: [id],
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> insertBomoolWord(WordModel word) async {
    final Database db = await database;
    try {
      db.insert('bomool', word.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> insertWrongWord(WordModel word) async {
    final Database db = await database;
    try {
      db.insert('wrong', word.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<WordModel>> readBomoolWords() async {
    final Database db = await database;
    final List<Map<String, dynamic>> data = await db.query('bomool');

    return List.generate(data.length, (i) {
      return WordModel(
          id: data[i]['id'],
          eng: data[i]['eng'],
          kor: data[i]['kor'],
          level: data[i]['level']);
    });
  }

  Future<List<WordModel>> readWrongWords() async {
    final Database db = await database;
    final List<Map<String, dynamic>> data = await db.query('wrong');

    return List.generate(data.length, (i) {
      return WordModel(
        id: data[i]['id'],
        eng: data[i]['eng'],
        kor: data[i]['kor'],
        level: data[i]['level'],
        correct: data[i]['correct'],
      );
    });
  }

  Future<WordModel> readBomoolWord(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> data =
        await db.query('bomool', where: 'id=?', whereArgs: [id]);
    return WordModel(
      id: data[0]['id'],
      eng: data[0]['eng'],
      kor: data[0]['kor'],
      level: data[0]['level'],
      correct: data[0]['correct'],
    );
  }

  Future<WordModel> readWrongWord(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> data =
        await db.query('wrong', where: 'id=?', whereArgs: [id]);
    return WordModel(
      id: data[0]['id'],
      eng: data[0]['eng'],
      kor: data[0]['kor'],
      level: data[0]['level'],
      correct: data[0]['correct'],
    );
  }

  Future<bool> deleteBomoolWord(int id) async {
    final Database db = await database;

    try {
      db.delete(
        'bomool',
        where: 'id=?',
        whereArgs: [id],
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> deleteWrongWord(int id) async {
    final Database db = await database;

    try {
      db.delete(
        'wrong',
        where: 'id=?',
        whereArgs: [id],
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateBomoolWord(WordModel word) async {
    final Database db = await database;

    try {
      db.update(
        'bomool',
        word.toMap(),
        where: 'id=?',
        whereArgs: [word.id],
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateIsCorrectedWord(WordModel word) async {
    final Database db = await database;
    Map<String, dynamic> correct = {
      'correct': 1,
    };

    try {
      db.update(
        'words',
        correct,
        where: 'id=?',
        whereArgs: [word.id],
      );
      return true;
    } catch (err) {
      return false;
    }
  }
}
