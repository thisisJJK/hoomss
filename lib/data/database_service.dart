import 'package:hoomss/data/model/word_model.dart';
import 'package:hoomss/data/word_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  late Future<Database> database;
  final int _wordVersion = 1;

  factory DatabaseService() => _databaseService;

  DatabaseService._internal() {
    databaseConfig();
  }

  Future<bool> databaseConfig() async {
    try {
      database = openDatabase(
        join(await getDatabasesPath(), 'hoomss_database.db'),
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE words(id INTEGER PRIMARY KEY,eng TEXT,kor TEXT)');

          await _insertInitData(db);
        },
        version: _wordVersion,
      );
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _insertInitData(Database db) async {
    try {
      List<Map<String, dynamic>> words = wordData();

      for (var word in words) {
        await db.insert('words', word);
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
}
