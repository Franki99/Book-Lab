import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:book_lab/models/book.dart';

class DBHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books.db');

    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, author TEXT, rating INTEGER, read INTEGER, isFavorite INTEGER)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
              'ALTER TABLE books ADD COLUMN isFavorite INTEGER DEFAULT 0');
        }
      },
      version: 2,
    );
  }

  Future<List<Book>> fetchBooks() async {
    final db = await database;
    final maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book.fromMap(maps[i]);
    });
  }

  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert('books', book.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateBook(Book book) async {
    final db = await database;
    await db
        .update('books', book.toMap(), where: 'id = ?', whereArgs: [book.id]);
  }

  Future<void> deleteBook(int id) async {
    final db = await database;
    await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }
}
