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
          'CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, author TEXT, rating INTEGER, read INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<Book>> fetchBooks() async {
    final db = await database;
    final maps = await db.query('books');
    return List.generate(maps.length, (i) {
      return Book(
        id: maps[i]['id'] as int?,
        title: maps[i]['title'] as String,
        author: maps[i]['author'] as String,
        rating: maps[i]['rating'] as int,
        read: (maps[i]['read'] as int) == 1,
      );
    });
  }

  //Create a book
  Future<void> insertBook(Book book) async {
    final db = await database;
    await db.insert('books', book.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //update a book details
  Future<void> updateBook(Book book) async {
    final db = await database;
    await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  // Delete a book from the db
  Future<void> deleteBook(int id) async {
    final db = await database;
    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
